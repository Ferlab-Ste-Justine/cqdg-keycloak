package bio.ferlab.keycloak.authenticators;

import java.util.Arrays;
import java.util.List;
import org.keycloak.Config;
import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.AuthenticatorFactory;
import org.keycloak.models.AuthenticationExecutionModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;
import org.keycloak.provider.ProviderConfigProperty;

public class ClientConditionalOtpFormAuthenticatorFactory implements AuthenticatorFactory {
    public static final String PROVIDER_ID = "client-auth-conditional-otp-form";
    public static final ClientConditionalOtpFormAuthenticator SINGLETON = new ClientConditionalOtpFormAuthenticator();

    public ClientConditionalOtpFormAuthenticatorFactory() {
    }

    public Authenticator create(KeycloakSession session) {
        return SINGLETON;
    }

    public void init(Config.Scope config) {
    }

    public void postInit(KeycloakSessionFactory factory) {
    }

    public void close() {
    }

    public String getId() {
        return PROVIDER_ID;
    }

    public String getReferenceCategory() {
        return "otp";
    }

    public boolean isConfigurable() {
        return true;
    }

    public boolean isUserSetupAllowed() {
        return true;
    }

    public AuthenticationExecutionModel.Requirement[] getRequirementChoices() {
        return REQUIREMENT_CHOICES;
    }

    public String getDisplayType() {
        return "Client Conditional OTP Form";
    }

    public String getHelpText() {
        return "Validates a OTP on a separate OTP form. Only shown if required based on the configured conditions.";
    }

    public List<ProviderConfigProperty> getConfigProperties() {
        ProviderConfigProperty forceOtpRole = new ProviderConfigProperty();
        forceOtpRole.setType(ProviderConfigProperty.CLIENT_LIST_TYPE);
        forceOtpRole.setName("forceOtpClient");
        forceOtpRole.setLabel("Force OTP for Client");
        forceOtpRole.setHelpText("OTP is always required if user request the given client");
        return Arrays.asList(forceOtpRole);
    }
}
