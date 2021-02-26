package ca.cqdg.forms.login;

import org.keycloak.Config;
import org.keycloak.forms.login.LoginFormsProvider;
import org.keycloak.forms.login.LoginFormsProviderFactory;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.KeycloakSessionFactory;
import org.keycloak.theme.FreeMarkerUtil;

public class LoginFlowFormsProviderFactory implements LoginFormsProviderFactory {
    private FreeMarkerUtil freeMarker;

    public LoginFormsProvider create(KeycloakSession session) {
        return new LoginFlowFormsProvider(session, this.freeMarker);
    }

    public void init(Config.Scope config) {
        this.freeMarker = new FreeMarkerUtil();
    }

    public void postInit(KeycloakSessionFactory factory) {
    }

    public void close() {
        this.freeMarker = null;
    }

    public String getId() {
        return "customFreemarker";
    }
}
