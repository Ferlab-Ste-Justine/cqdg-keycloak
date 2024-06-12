package bio.ferlab.keycloak.authenticators;//

import java.util.Arrays;
import java.util.List;
import org.keycloak.Config;
import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.AuthenticatorFactory;
import org.keycloak.models.AuthenticationExecutionModel;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;
import org.keycloak.provider.ProviderConfigProperty;

public class ClientExcludedCookieAuthenticatorFactory implements AuthenticatorFactory {
    public static final String PROVIDER_ID = "auth-cookie-client-exclude";
    static ClientExcludedCookieAuthenticator SINGLETON = new ClientExcludedCookieAuthenticator();

    public ClientExcludedCookieAuthenticatorFactory() {
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
        return "cookie";
    }

    public boolean isConfigurable() {
        return true;
    }

    public AuthenticationExecutionModel.Requirement[] getRequirementChoices() {
        return REQUIREMENT_CHOICES;
    }

    public String getDisplayType() {
        return "Cookie Exclude Client";
    }

    public String getHelpText() {
        return "Validates the SSO cookie set by the auth server, except for the set client";
    }

    public List<ProviderConfigProperty> getConfigProperties() {
        ProviderConfigProperty forceReAuthClient = new ProviderConfigProperty();
        forceReAuthClient.setType(ProviderConfigProperty.CLIENT_LIST_TYPE);
        forceReAuthClient.setName("forceReAuthForClient");
        forceReAuthClient.setLabel("Force Re-Authentication for Client");
        forceReAuthClient.setHelpText("Disable SSO cookie validation for set client (force re-authentication)");
        return Arrays.asList(forceReAuthClient);
    }

    public boolean isUserSetupAllowed() {
        return true;
    }
}
