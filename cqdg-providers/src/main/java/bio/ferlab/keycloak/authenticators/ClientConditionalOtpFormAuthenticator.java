package bio.ferlab.keycloak.authenticators;//


import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.authenticators.browser.OTPFormAuthenticator;
import org.keycloak.models.AuthenticatorConfigModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.models.UserModel.RequiredAction;

import javax.ws.rs.core.MultivaluedMap;
import java.util.*;
import java.util.stream.Stream;

public class ClientConditionalOtpFormAuthenticator extends OTPFormAuthenticator {
    public static final String FORCE_OTP_CLIENTS = "forceOtpClients";
    public static final String CLIENT_ID = "client_id";
    private static final String CLIENTS_SEPARATOR = "##";

    public ClientConditionalOtpFormAuthenticator() {
    }

    public void authenticate(AuthenticationFlowContext context) {
        Map<String, String> config = context.getAuthenticatorConfig().getConfig();
        OtpDecision clientDecision = voteForClient(context.getUriInfo().getQueryParameters(), config);

        if(clientDecision == OtpDecision.SHOW_OTP){
            showOtpForm(context);
        } else context.success();
    }

    private boolean tryConcludeBasedOn(OtpDecision state) {
        switch (state) {
            case SHOW_OTP:
                return true;
            default:
                return false;
        }
    }

    private void showOtpForm(AuthenticationFlowContext context) {
        super.authenticate(context);
    }

    private boolean isClientsMatch(MultivaluedMap<String, String> queryParameters, List<String> formClients) {
        Optional<String> clientRequest = queryParameters.get(CLIENT_ID).stream().reduce((first, second) -> second).map(String::toLowerCase);
        return clientRequest.filter(formClients::contains).isPresent();
    }

    private OtpDecision voteForClient(MultivaluedMap<String, String> queryParameters, Map<String, String> config) {
        if (queryParameters.containsKey(CLIENT_ID) && config.containsKey(FORCE_OTP_CLIENTS)) {
            List<String> formClients = Arrays.stream(config.get(FORCE_OTP_CLIENTS).trim().toLowerCase().split(CLIENTS_SEPARATOR)).toList();
            return isClientsMatch(queryParameters, formClients) ? OtpDecision.SHOW_OTP : OtpDecision.ABSTAIN;
        } else return OtpDecision.ABSTAIN;
    }

    private boolean isOTPRequired(KeycloakSession session, RealmModel realm, UserModel user) {
        MultivaluedMap<String, String> queryParameters = session.getContext().getUri().getQueryParameters();

        return realm.getAuthenticatorConfigsStream().anyMatch((configModel) -> {
            if (tryConcludeBasedOn(voteForClient(queryParameters, configModel.getConfig()))) {
                return true;
            } else {
                return configModel.getConfig().containsKey(FORCE_OTP_CLIENTS) && voteForClient(queryParameters, configModel.getConfig()) == OtpDecision.ABSTAIN;
            }
        });
    }

    private List<String> getFormClients(RealmModel realm) {
        Optional<AuthenticatorConfigModel> authenticatorConfigModel = realm.getAuthenticatorConfigsStream().filter(c -> c.getConfig().containsKey(FORCE_OTP_CLIENTS)).reduce((first, second) -> second);

        return authenticatorConfigModel.map(configModel -> Arrays.stream(configModel.getConfig().get(FORCE_OTP_CLIENTS).trim().toLowerCase().split(CLIENTS_SEPARATOR)).toList()).orElse(Collections.emptyList());
    };


    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
        List<String> formClients = getFormClients(realm);
        MultivaluedMap<String, String> queryParameters = session.getContext().getUri().getQueryParameters();

        if (!isOTPRequired(session, realm, user)) {
            user.removeRequiredAction(RequiredAction.CONFIGURE_TOTP);
        } else {
            Stream<String> userRequiredActionsStream = user.getRequiredActionsStream();
            String configureTOTPAction = RequiredAction.CONFIGURE_TOTP.name();
            Objects.requireNonNull(configureTOTPAction);

            if (userRequiredActionsStream.noneMatch(configureTOTPAction::equals) && !formClients.isEmpty()) {
                if(queryParameters.containsKey(CLIENT_ID) && isClientsMatch(queryParameters, formClients)){
                    user.addRequiredAction(RequiredAction.CONFIGURE_TOTP.name());
                }
            }
        }
    }

    enum OtpDecision {
        SKIP_OTP,
        SHOW_OTP,
        ABSTAIN;

        OtpDecision() {
        }
    }
}
