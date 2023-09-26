package bio.ferlab.keycloak.authenticators;

import bio.ferlab.keycloak.authenticators.model.UserOptionsModel;
import bio.ferlab.keycloak.authenticators.model.UserProfileModel;
import kong.unirest.HttpResponse;
import kong.unirest.Unirest;
import org.jboss.logging.Logger;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.requiredactions.util.UpdateProfileContext;
import org.keycloak.authentication.requiredactions.util.UserUpdateProfileContext;
import org.keycloak.crypto.AsymmetricSignatureSignerContext;
import org.keycloak.crypto.KeyUse;
import org.keycloak.crypto.KeyWrapper;
import org.keycloak.events.EventBuilder;
import org.keycloak.events.EventType;
import org.keycloak.jose.jws.JWSBuilder;
import org.keycloak.models.KeycloakContext;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.models.utils.FormMessage;
import org.keycloak.representations.AccessToken;
import org.keycloak.services.Urls;
import org.keycloak.services.validation.Validation;
import org.keycloak.userprofile.UserProfile;
import org.keycloak.userprofile.UserProfileContext;
import org.keycloak.userprofile.UserProfileProvider;
import org.keycloak.userprofile.ValidationException;

import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import static org.keycloak.forms.login.LoginFormsProvider.UPDATE_PROFILE_CONTEXT_ATTR;

public class UserProfileExistAuthenticator implements Authenticator {
    private static final Logger logger = Logger.getLogger(UserProfileExistAuthenticator.class);

    @Override
    public void authenticate(AuthenticationFlowContext context) {
        UserModel user = context.getUser();
        Optional<UserProfileModel> userProfile = getUserProfile(context);
        String redirect = context.getAuthenticationSession().getRedirectUri();
        //Update keycloak user information from profile
        userProfile.ifPresent(
                up -> {
                    user.setFirstName(up.getFirst_name());
                    user.setLastName(up.getLast_name());
                    user.setEmail(up.getEmail());
                }
        );
        if (userProfile.isPresent() && userProfile.stream().anyMatch(UserProfileModel::isCompleted_registration)) {
            context.success();
        } else {
            UpdateProfileContext userBasedContext = new UserUpdateProfileContext(context.getRealm(), user);
            UserProfileModel defaultProfile = new UserProfileModel();
            defaultProfile.setFirst_name(user.getFirstName());
            defaultProfile.setLast_name(user.getLastName());
            defaultProfile.setEmail(user.getEmail());
            Response challenge = context.form()
                    .setAttribute(UPDATE_PROFILE_CONTEXT_ATTR, userBasedContext)
                    .setAttribute("userProfile", userProfile.orElse(defaultProfile))
                    .setAttribute("redirectUrl", redirect)
                    .setAttribute("userOptions", getUserOptions(context).asMap())
                    .setFormData(null)
                    .createUpdateProfilePage();
            context.challenge(challenge);
        }

    }


    private String getUserApiUri(AuthenticationFlowContext context) {
        return context.getAuthenticatorConfig().getConfig().get("userProfileApiUri") + "/user";
    }

    private UserOptionsModel getUserOptions(AuthenticationFlowContext context) {
        String userOptionApi = context.getAuthenticatorConfig().getConfig().get("userProfileApiUri") + "/userOptions";
        HttpResponse<UserOptionsModel> response = Unirest.get(userOptionApi)
                .asObject(UserOptionsModel.class);
        if (response.isSuccess()) {
            return response.getBody();
        } else {
            throw new IllegalStateException("Error when sending request userOptions to user api, response code=" + response.getStatus());
        }
    }

    private Optional<UserProfileModel> getUserProfile(AuthenticationFlowContext context) {
        String userApi = getUserApiUri(context);
        UserModel user = context.getUser();
        String accessToken = getAccessToken(user, context.getSession());
        HttpResponse<UserProfileModel> response = Unirest.get(userApi)
                .header("Authorization", "Bearer " + accessToken)
                .asObject(UserProfileModel.class);
        if (response.getStatus() == 404) {
            return Optional.empty();
        } else if (response.isSuccess()) {
            return response.mapBody(Optional::of);
        } else {
            throw new IllegalStateException("Error when sending request to user api, response code=" + response.getStatus());
        }

    }

    public String getAccessToken(UserModel userModel, KeycloakSession keycloakSession) {
        KeycloakContext keycloakContext = keycloakSession.getContext();

        AccessToken token = new AccessToken();
        token.subject(userModel.getId());
        token.issuer(Urls.realmIssuer(keycloakContext.getUri().getBaseUri(), keycloakContext.getRealm().getName()));
        token.issuedNow();
        token.expiration((int) (token.getIat() + 3600L)); //Lifetime of 60 seconds
        token.setOtherClaims("azp", keycloakContext.getClient().getClientId());
        token.setScope("openid");
        token.type("Bearer");

        KeyWrapper key = keycloakSession.keys().getActiveKey(keycloakContext.getRealm(), KeyUse.SIG, "RS256");

        return new JWSBuilder().kid(key.getKid()).type("JWT").jsonContent(token).sign(new AsymmetricSignatureSignerContext(key));
    }


    @Override
    public void action(AuthenticationFlowContext context) {
        MultivaluedMap<String, String> formData = context.getHttpRequest().getDecodedFormParameters();
        UserModel user = context.getUser();
        EventBuilder event = context.getEvent();
        event.event(EventType.UPDATE_PROFILE);
        event.user(user);
        // Email attributes should be replaced
        if (formData.containsKey(UserModel.EMAIL)) {
            formData.replace(UserModel.EMAIL, Collections.singletonList(user.getEmail()));
        } else {
            formData.add(UserModel.EMAIL, user.getEmail());
        }
        formData.add("firstName", formData.getFirst("first_name"));
        formData.add("lastName", formData.getFirst("last_name"));

        UserProfileProvider provider = context.getSession().getProvider(UserProfileProvider.class);
        UserProfile profile = provider.create(UserProfileContext.UPDATE_PROFILE, formData, user);

        try {
            // backward compatibility with old account console where attributes are not removed if missing
            upsertProfile(formData, context);
            profile.update(false);
            event.success();
            context.success();
        } catch (ValidationException pve) {
            List<FormMessage> errors = Validation.getFormErrorsFromValidation(pve.getErrors());
            Response challenge = context.form()
                    .setErrors(errors)
                    .setFormData(formData)
                    .createResponse(UserModel.RequiredAction.UPDATE_PROFILE);
            context.challenge(challenge);
        }

    }

    private void upsertProfile(MultivaluedMap<String, String> formData, AuthenticationFlowContext context) {
        UserModel user = context.getUser();
        UserProfileModel model = new UserProfileModel();

        model.setFirst_name(formData.getFirst("first_name"));
        model.setLast_name(formData.getFirst("last_name"));
        model.setEmail(user.getEmail());

        model.setEra_commons_id(formData.getFirst("era_commons_id"));

        model.setAffiliation(formData.getFirst("affiliation"));
        model.setAccepted_terms(true);
        model.setUnderstand_disclaimer(true);
        model.setConsent_date(LocalDateTime.now());
        model.setCommercial_use_reason(formData.getFirst("commercial_use_reason"));
        model.setExternal_individual_email(formData.getFirst("external_individual_email"));
        model.setExternal_individual_fullname(formData.getFirst("external_individual_fullname"));
        model.setPortal_usages(formData.get("portal_usages"));
        model.setResearch_domains(formData.get("research_domains"));
        model.setResearch_area_description(formData.getFirst("research_area_description"));
        model.setRoles(formData.get("roles"));

        Optional<UserProfileModel> userProfile = getUserProfile(context);
        if (userProfile.isEmpty()) {
            HttpResponse resp = Unirest.post(getUserApiUri(context))
                    .header("Content-Type", "application/json")
                    .header("Authorization", "Bearer " + getAccessToken(user, context.getSession()))
                    .body(model)
                    .asEmpty();
            if (!resp.isSuccess()) {
                throw new IllegalStateException("An error occured when sending request to user profile api, status=" + resp.getStatus() + "body=" + resp.getBody());
            }
        }
        HttpResponse resp = Unirest.put(getUserApiUri(context)  + "/complete-registration")
                .header("Content-Type", "application/json")
                .header("Authorization", "Bearer " + getAccessToken(user, context.getSession()))
                .body(model)
                .asEmpty();
        if (!resp.isSuccess()) {
            throw new IllegalStateException("An error occured when creating user in profile api, status=" + resp.getStatus() + "body=" + resp.getBody());
        }

    }

    @Override
    public boolean requiresUser() {
        return true;
    }

    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }

    @Override
    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {

    }

    @Override
    public void close() {

    }
}
