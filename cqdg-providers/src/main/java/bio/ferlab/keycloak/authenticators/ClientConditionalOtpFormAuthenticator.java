package bio.ferlab.keycloak.authenticators;//


import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.authenticators.browser.OTPFormAuthenticator;
import org.keycloak.models.AuthenticatorConfigModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.models.UserModel.RequiredAction;

import javax.ws.rs.core.MultivaluedMap;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Stream;

public class ClientConditionalOtpFormAuthenticator extends OTPFormAuthenticator {
    public static final String FORCE_OTP_CLIENT = "forceOtpClient";
    public static final String CLIENT_ID = "client_id";

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

    private OtpDecision voteForClient(MultivaluedMap<String, String> queryParameters, Map<String, String> config) {
        if (queryParameters.containsKey(CLIENT_ID) && config.containsKey(FORCE_OTP_CLIENT)) {
            return queryParameters.get(CLIENT_ID).contains(config.get(FORCE_OTP_CLIENT)) ?
                    OtpDecision.SHOW_OTP : OtpDecision.ABSTAIN;
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

    private String getFormClient(RealmModel realm) {
        Optional<AuthenticatorConfigModel> authenticatorConfigModel = realm.getAuthenticatorConfigsStream().filter(c -> c.getConfig().containsKey(FORCE_OTP_CLIENT)).reduce((first, second) -> second);
        return authenticatorConfigModel.map(configModel -> configModel.getConfig().getOrDefault(FORCE_OTP_CLIENT, null)).orElse(null);
    };


    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
        String formClient = getFormClient(realm);
        MultivaluedMap<String, String> queryParameters = session.getContext().getUri().getQueryParameters();

        if (!isOTPRequired(session, realm, user)) {
            user.removeRequiredAction(RequiredAction.CONFIGURE_TOTP);
        } else {
            Stream<String> userRequiredActionsStream = user.getRequiredActionsStream();
            String configureTOTPAction = RequiredAction.CONFIGURE_TOTP.name();
            Objects.requireNonNull(configureTOTPAction);

            if (userRequiredActionsStream.noneMatch(configureTOTPAction::equals) && !formClient.isEmpty()) {
                if(queryParameters.containsKey(CLIENT_ID) && queryParameters.get(CLIENT_ID).contains(formClient)){
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
