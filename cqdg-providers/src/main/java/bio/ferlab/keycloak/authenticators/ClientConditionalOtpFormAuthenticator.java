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
    public static final String FORCE_OTP_CLIENT = "forceOtpClients";
    public static final String CLIENT_ID = "client_id";
    private static final String[] EMPTY_ARRAY = new String[0];

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

    private boolean isClientsMatch(MultivaluedMap<String, String> queryParameters, String[] formClients) {
        Optional<String> clientRequest = queryParameters.get(CLIENT_ID).stream().reduce((first, second) -> second).map(String::toLowerCase);
        return clientRequest.filter(clReq -> Arrays.asList(formClients).contains(clReq)).isPresent();
    }

    private OtpDecision voteForClient(MultivaluedMap<String, String> queryParameters, Map<String, String> config) {
        if (queryParameters.containsKey(CLIENT_ID) && config.containsKey(FORCE_OTP_CLIENT)) {
            String[] formClients = config.get(FORCE_OTP_CLIENT).trim().toLowerCase().split("##");
            return isClientsMatch(queryParameters, formClients) ? OtpDecision.SHOW_OTP : OtpDecision.ABSTAIN;
        } else return OtpDecision.ABSTAIN;
    }

    private boolean isOTPRequired(KeycloakSession session, RealmModel realm, UserModel user) {
        MultivaluedMap<String, String> queryParameters = session.getContext().getUri().getQueryParameters();

        return realm.getAuthenticatorConfigsStream().anyMatch((configModel) -> {
            if (tryConcludeBasedOn(voteForClient(queryParameters, configModel.getConfig()))) {
                return true;
            } else {
                return configModel.getConfig().containsKey(FORCE_OTP_CLIENT) && voteForClient(queryParameters, configModel.getConfig()) == OtpDecision.ABSTAIN;
            }
        });
    }

    private String[] getFormClients(RealmModel realm) {
        Optional<AuthenticatorConfigModel> authenticatorConfigModel = realm.getAuthenticatorConfigsStream().filter(c -> c.getConfig().containsKey(FORCE_OTP_CLIENT)).reduce((first, second) -> second);

        return authenticatorConfigModel.map(configModel -> configModel.getConfig().get(FORCE_OTP_CLIENT).trim().toLowerCase().split("##")).orElse(EMPTY_ARRAY);
    };


    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
        String[] formClients = getFormClients(realm);
        MultivaluedMap<String, String> queryParameters = session.getContext().getUri().getQueryParameters();

        if (!isOTPRequired(session, realm, user)) {
            user.removeRequiredAction(RequiredAction.CONFIGURE_TOTP);
        } else {
            Stream<String> userRequiredActionsStream = user.getRequiredActionsStream();
            String configureTOTPAction = RequiredAction.CONFIGURE_TOTP.name();
            Objects.requireNonNull(configureTOTPAction);

            if (userRequiredActionsStream.noneMatch(configureTOTPAction::equals) && formClients != EMPTY_ARRAY) {
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
