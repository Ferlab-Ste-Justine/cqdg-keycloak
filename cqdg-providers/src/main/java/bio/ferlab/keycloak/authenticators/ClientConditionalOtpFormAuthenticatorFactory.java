package bio.ferlab.keycloak.authenticators;

import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.authenticators.browser.OTPFormAuthenticatorFactory;
import org.keycloak.models.KeycloakSession;
import org.keycloak.provider.ProviderConfigProperty;

import java.util.Arrays;
import java.util.List;

public class ClientConditionalOtpFormAuthenticatorFactory extends OTPFormAuthenticatorFactory {
    public static final String PROVIDER_ID = "client-auth-conditional-otp-form";
    public static final ClientConditionalOtpFormAuthenticator SINGLETON = new ClientConditionalOtpFormAuthenticator();

    public ClientConditionalOtpFormAuthenticatorFactory() {
    }

    public Authenticator create(KeycloakSession session) {
        return SINGLETON;
    }

    public String getId() {
        return PROVIDER_ID;
    }

    public boolean isConfigurable() {
        return true;
    }

    public String getDisplayType() {
        return "Client Conditional OTP Form";
    }

    public String getHelpText() {
        return "Validates a OTP on a separate OTP form. Only shown if required based on the configured conditions.";
    }

    public List<ProviderConfigProperty> getConfigProperties() {
        ProviderConfigProperty forceOtpRole = new ProviderConfigProperty();
        forceOtpRole.setType(ProviderConfigProperty.MULTIVALUED_STRING_TYPE); //free text
        forceOtpRole.setName("forceOtpClients");
        forceOtpRole.setLabel("Force OTP for Clients");
        forceOtpRole.setHelpText("OTP is always required if user request the given clients");

        return Arrays.asList(forceOtpRole);
    }
}
