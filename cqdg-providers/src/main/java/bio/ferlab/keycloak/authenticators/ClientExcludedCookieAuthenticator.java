package bio.ferlab.keycloak.authenticators;//

import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.Authenticator;
import org.keycloak.authentication.authenticators.util.AcrStore;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.UserModel;
import org.keycloak.protocol.LoginProtocol;
import org.keycloak.services.managers.AuthenticationManager;
import org.keycloak.sessions.AuthenticationSessionModel;

import javax.ws.rs.core.MultivaluedMap;
import java.util.Objects;
import java.util.Optional;

public class ClientExcludedCookieAuthenticator implements Authenticator {
    private static final String CLIENT_ID = "client_id";

    public ClientExcludedCookieAuthenticator() {
    }

    public boolean requiresUser() {
        return false;
    }

    public void authenticate(AuthenticationFlowContext context) {
        AuthenticationManager.AuthResult authResult = AuthenticationManager.authenticateIdentityCookie(context.getSession(), context.getRealm(), true);

        if (authResult == null || isExcludedClient(context)) {
            context.attempted();
        } else {
            AuthenticationSessionModel authSession = context.getAuthenticationSession();
            LoginProtocol protocol = (LoginProtocol)context.getSession().getProvider(LoginProtocol.class, authSession.getProtocol());
            authSession.setAuthNote("loa-map", authResult.getSession().getNote("loa-map"));
            context.setUser(authResult.getUser());
            AcrStore acrStore = new AcrStore(authSession);
            if (protocol.requireReauthentication(authResult.getSession(), authSession)) {
                acrStore.setLevelAuthenticatedToCurrentRequest(-1);
                authSession.setAuthNote("FORCED_REAUTHENTICATION", "true");
                context.setForwardedInfoMessage("reauthenticate", new Object[0]);
                context.attempted();
            } else {
                int previouslyAuthenticatedLevel = acrStore.getHighestAuthenticatedLevelFromPreviousAuthentication();
                if (acrStore.getRequestedLevelOfAuthentication() > previouslyAuthenticatedLevel) {
                    acrStore.setLevelAuthenticatedToCurrentRequest(previouslyAuthenticatedLevel);
                    context.attempted();
                } else {
                    acrStore.setLevelAuthenticatedToCurrentRequest(previouslyAuthenticatedLevel);
                    authSession.setAuthNote("SSO_AUTH", "true");
                    context.attachUserSession(authResult.getSession());
                    context.success();
                }
            }
        }

    }

    public void action(AuthenticationFlowContext context) {
    }

    private boolean isExcludedClient(AuthenticationFlowContext context) {
        MultivaluedMap<String, String> queryParameters = context.getUriInfo().getQueryParameters();

        Optional<String> clientRequest = queryParameters.get(CLIENT_ID).stream().reduce((first, second) -> second);
        String clientForm =  context.getAuthenticatorConfig().getConfig().get("forceReAuthForClient");

        return clientRequest.filter(s -> Objects.equals(clientForm, s)).isPresent();
    }

    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }

    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {
    }

    public void close() {
    }
}
