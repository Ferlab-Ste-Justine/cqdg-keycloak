package bio.ferlab.keycloak.authenticators;//

import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.authenticators.browser.CookieAuthenticator;
import org.keycloak.authentication.authenticators.util.AcrStore;
import org.keycloak.protocol.LoginProtocol;
import org.keycloak.services.managers.AuthenticationManager;
import org.keycloak.sessions.AuthenticationSessionModel;

import javax.ws.rs.core.MultivaluedMap;
import java.util.Arrays;
import java.util.Optional;

public class ClientExcludedCookieAuthenticator extends CookieAuthenticator {
    private static final String CLIENT_ID = "client_id";

    public ClientExcludedCookieAuthenticator() {
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

    private boolean isExcludedClient(AuthenticationFlowContext context) {
        MultivaluedMap<String, String> queryParameters = context.getUriInfo().getQueryParameters();

        Optional<String> clientRequest = queryParameters.get(CLIENT_ID).stream().reduce((first, second) -> second).map(String::toLowerCase);

        String[] clientsForm =  context.getAuthenticatorConfig().getConfig().get("forceReAuthForClient").strip().toLowerCase().split("##");

        return clientRequest.filter(clReq -> Arrays.asList(clientsForm).contains(clReq)).isPresent();
    }
}
