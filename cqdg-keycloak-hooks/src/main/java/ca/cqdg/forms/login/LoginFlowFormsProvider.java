package ca.cqdg.forms.login;

import ca.cqdg.forms.FormUtils;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang.StringUtils;
import org.jboss.logging.Logger;
import org.keycloak.authentication.authenticators.broker.util.SerializedBrokeredIdentityContext;
import org.keycloak.broker.provider.BrokeredIdentityContext;
import org.keycloak.common.util.ObjectUtil;
import org.keycloak.forms.login.LoginFormsPages;
import org.keycloak.forms.login.freemarker.FreeMarkerLoginFormsProvider;
import org.keycloak.forms.login.freemarker.Templates;
import org.keycloak.forms.login.freemarker.model.*;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.UserModel;
import org.keycloak.theme.FreeMarkerUtil;
import org.keycloak.theme.Theme;
import org.keycloak.theme.beans.AdvancedMessageFormatterMethod;
import org.keycloak.theme.beans.MessageType;
import org.keycloak.userprofile.UserProfileProvider;

import javax.net.ssl.HttpsURLConnection;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.*;

public class LoginFlowFormsProvider extends FreeMarkerLoginFormsProvider {

    private static final Logger logger = Logger.getLogger(LoginFlowFormsProvider.class);
    private static final ObjectMapper jsonParser = new ObjectMapper();

    private static Map<String, String> affiliations = null;
    private static Map<String, String> titles = null;
    private static Map<String, String> researchDomains = null;

    public LoginFlowFormsProvider(KeycloakSession session, FreeMarkerUtil freeMarker) {
        super(session, freeMarker);
    }

    @Override
    protected Response createResponse(LoginFormsPages page) {
        Theme theme;
        try {
            theme = this.getTheme();
        } catch (IOException var10) {
            logger.error("Failed to create theme", var10);
            return Response.serverError().build();
        }

        // Load referential data if not already loaded.
        loadReferentials();

        attributes.put("affiliations", affiliations);
        attributes.put("titles", titles);
        attributes.put("researchDomains", researchDomains);

        Locale locale = this.session.getContext().resolveLocale(this.user);
        Properties messagesBundle = this.handleThemeResources(theme, locale);
        Map<String, String> localizationTexts = this.realm.getRealmLocalizationTextsByLocale(locale.toLanguageTag());
        messagesBundle.putAll(localizationTexts);
        this.handleMessages(locale, messagesBundle);
        UriBuilder uriBuilder = this.prepareBaseUriBuilder(page == LoginFormsPages.OAUTH_GRANT);
        this.createCommonAttributes(theme, locale, messagesBundle, uriBuilder, page);
        this.attributes.put("login", new LoginBean(this.formData));
        if (this.status != null) {
            this.attributes.put("statusCode", this.status.getStatusCode());
        }

        switch(page) {
            case LOGIN_CONFIG_TOTP:
                this.attributes.put("totp", new TotpBean(this.session, this.realm, this.user, this.uriInfo.getRequestUriBuilder()));
                break;
            case LOGIN_UPDATE_PROFILE:
                SerializedBrokeredIdentityContext userCtx = ((SerializedBrokeredIdentityContext)this.attributes.get("updateProfileCtx"));

                if(userCtx != null){
                    String providerId = userCtx.getIdentityProviderId();
                    if(providerId != null && providerId.toLowerCase().indexOf("orcid") > -1){
                        String brokerUsername = userCtx.getBrokerUsername();
                        String email = getOrcidEmail(brokerUsername);
                        userCtx.setEmail(email);
                    }
                }

                UserModel userModel = context.getSession().users().getUserByEmail(userCtx.getEmail(), this.realm);
                FormUtils.syncContextAttributes(userModel, userCtx);

                ProfileBean user = new ProfileBean(userCtx, this.formData);

                this.attributes.put("user", user);
                break;
            case LOGIN_IDP_LINK_CONFIRM:
            case LOGIN_IDP_LINK_EMAIL:
                BrokeredIdentityContext brokerContext = (BrokeredIdentityContext)this.attributes.get("identityProviderBrokerCtx");
                String idpAlias = brokerContext.getIdpConfig().getAlias();
                idpAlias = ObjectUtil.capitalize(idpAlias);
                this.attributes.put("brokerContext", brokerContext);
                this.attributes.put("idpAlias", idpAlias);
                break;
            case LOGIN_TOTP:
                this.attributes.put("otpLogin", new TotpLoginBean(this.session, this.realm, this.user, (String)this.attributes.get("selectedOtpCredentialId")));
                break;
            case REGISTER:
                this.attributes.put("register", new RegisterBean(this.formData));
                break;
            case OAUTH_GRANT:
                this.attributes.put("oauth", new OAuthGrantBean(this.accessCode, this.client, this.clientScopesRequested));
                this.attributes.put("advancedMsg", new AdvancedMessageFormatterMethod(locale, messagesBundle));
                break;
            case CODE:
                this.attributes.put("code", new CodeBean(this.accessCode, this.messageType == MessageType.ERROR ? this.getFirstMessageUnformatted() : null));
                break;
            case X509_CONFIRM:
                this.attributes.put("x509", new X509ConfirmBean(this.formData));
                break;
            case SAML_POST_FORM:
                this.attributes.put("samlPost", new SAMLPostFormBean(this.formData));
        }

        return this.processTemplate(theme, Templates.getTemplate(page), locale);
    }

    private String getOrcidEmail(String brokerUsername){
        try {
            String orcidUrl = System.getenv("ORCID_URL");
            if(orcidUrl == null || orcidUrl.trim().length() == 0){
                logger.error("ORCID_URL is not defined.  Please add it to your environment variables.");
            }

            orcidUrl = orcidUrl.endsWith("/") ? orcidUrl : orcidUrl.concat("/");

            URL url = new URL( orcidUrl.concat(brokerUsername).concat("/person.json"));

            HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            con.setInstanceFollowRedirects(true);
            con.setConnectTimeout(1000);
            con.setReadTimeout(10000);

            int status = con.getResponseCode();
            if(status >= 400){
                throw new Exception("Request to " + url.toString() + " returned HTTP code " + status);
            }

            JsonNode content = null;
            try(BufferedReader reader = new BufferedReader(new InputStreamReader(con.getInputStream())); ){
                content = jsonParser.readValue(reader, JsonNode.class);
            }

            if(content != null){
                JsonNode publicGroupedEmails = content.get("publicGroupedEmails");
                return publicGroupedEmails.fields().next().getValue().get(0).get("email").textValue();
            }
        }catch(Exception e){
            logger.error("Failed to retrieve email from user's public ORCID profile", e);
        }

        return null;
    }

    private synchronized void loadReferentials() {
        //Populate the drop down lists based on the values defined in the theme's message_XX.properties
        if(affiliations == null || titles == null || researchDomains == null) {
            Theme theme;
            try{
                theme = this.getTheme();
            }catch(Exception e){
                logger.error("Failed to retrieve theme", e);
                return;
            }

            Locale locale = this.session.getContext().resolveLocale(this.user);
            Properties messagesBundle = this.handleThemeResources(theme, locale);

            affiliations = new TreeMap<>();
            titles = new TreeMap<>();
            researchDomains = new TreeMap<>();

            messagesBundle.keySet().stream().map(x -> String.valueOf(x)).forEach(
                    key -> {
                        Map<String, String> m = key.startsWith("cqdg.affiliation.") ? affiliations :
                                key.startsWith("cqdg.title.") ? titles :
                                        key.startsWith("cqdg.researchDomain.") ? researchDomains : null;

                        if (m != null && key.indexOf(".") > 0) {
                            m.put(key.substring(key.lastIndexOf(".") + 1), key);
                        }
                    }
            );
        }
    }
}
