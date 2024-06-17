package bio.ferlab.keycloak.authenticators;//

import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.authenticators.browser.CookieAuthenticatorFactory;
import org.keycloak.models.KeycloakSession;
import org.keycloak.provider.ProviderConfigProperty;

import java.util.Arrays;
import java.util.List;

public class ClientExcludedCookieAuthenticatorFactory extends CookieAuthenticatorFactory {
    public static final String PROVIDER_ID = "auth-cookie-client-exclude";
    static ClientExcludedCookieAuthenticator SINGLETON = new ClientExcludedCookieAuthenticator();

    public ClientExcludedCookieAuthenticatorFactory() {
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
        return "Cookie Exclude Client";
    }

    public String getHelpText() {
        return "Validates the SSO cookie set by the auth server, except for the set client";
    }


    public List<ProviderConfigProperty> getConfigProperties() {
        ProviderConfigProperty forceReAuthClient = new ProviderConfigProperty();
        forceReAuthClient.setType(ProviderConfigProperty.MULTIVALUED_STRING_TYPE); //free text
        forceReAuthClient.setName("forceReAuthForClient");
        forceReAuthClient.setLabel("Force Re-Authentication for Client");
        forceReAuthClient.setHelpText("Disable SSO cookie validation for set client (force re-authentication)");

        return Arrays.asList(forceReAuthClient);
    }

    public boolean isUserSetupAllowed() {
        return true;
    }
}
