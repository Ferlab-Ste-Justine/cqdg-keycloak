package ca.cqdg.forms.registration;

import org.jboss.logging.Logger;

import org.keycloak.Config;
import org.keycloak.authentication.FormAction;
import org.keycloak.authentication.FormActionFactory;
import org.keycloak.authentication.FormContext;
import org.keycloak.authentication.ValidationContext;
import org.keycloak.events.Details;
import org.keycloak.events.Errors;
import org.keycloak.forms.login.LoginFormsProvider;
import org.keycloak.models.*;
import org.keycloak.models.utils.FormMessage;
import org.keycloak.provider.ProviderConfigProperty;
import org.keycloak.services.validation.Validation;
import org.keycloak.theme.Theme;

import javax.ws.rs.core.MultivaluedMap;
import java.io.IOException;
import java.util.*;

public class RegistrationCustomFields implements FormAction, FormActionFactory {

    private static final Logger logger = Logger.getLogger(RegistrationCustomFields.class);

    public static final String PROVIDER_ID = "registration-custom-profile-action";

    public static final String FIELD_AFFILIATION = "user.attributes.affiliation";
    public static final String FIELD_TITLE = "user.attributes.title";
    public static final String FIELD_RESEARCH_DOMAIN = "user.attributes.researchDomain";

    public static final String MESSAGE_AFFILIATION_REQUIRED = "requiredAffiliationMessage";
    public static final String MESSAGE_AFFILIATION_INVALID = "invalidAffiliationMessage";

    public static final String MESSAGE_TITLE_REQUIRED = "requiredTitleMessage";
    public static final String MESSAGE_TITLE_INVALID = "invalidTitleMessage";

    public static final String MESSAGE_RESEARCH_DOMAIN_REQUIRED = "requiredResearchDomainMessage";
    public static final String MESSAGE_RESEARCH_DOMAIN_INVALID = "invalidResearchDomainMessage";

    @Override
    public String getDisplayType() {
        return "Profile Custom Fields Validation";
    }

    @Override
    public String getReferenceCategory() {
        return null;
    }

    @Override
    public String getId() {
        return PROVIDER_ID;
    }

    @Override
    public String getHelpText() {
        return "Validates custom fields added to the registration page.";
    }

    @Override
    public List<ProviderConfigProperty> getConfigProperties() {
        return null;
    }

    @Override
    public boolean isConfigurable() {
        return false;
    } //true?

    @Override
    public AuthenticationExecutionModel.Requirement[] getRequirementChoices() {
        return new AuthenticationExecutionModel.Requirement[] {
                AuthenticationExecutionModel.Requirement.REQUIRED,
                AuthenticationExecutionModel.Requirement.DISABLED
        };
    }

    @Override
    public void buildPage(FormContext context, LoginFormsProvider form) {
        logger.debug("Preparing to display page");
    }

    @Override
    public void validate(ValidationContext context) {
        MultivaluedMap<String, String> formData = context.getHttpRequest().getDecodedFormParameters();
        List<FormMessage> errors = new ArrayList<>();
        context.getEvent().detail(Details.REGISTER_METHOD, "form");

        String affiliation = formData.getFirst(FIELD_AFFILIATION);
        String title = formData.getFirst(FIELD_TITLE);
        String researchDomain = formData.getFirst(FIELD_RESEARCH_DOMAIN);

        if (Validation.isBlank(affiliation)) {
            errors.add(new FormMessage(FIELD_AFFILIATION, MESSAGE_AFFILIATION_REQUIRED));
        }else{
            //validate if valid affiliation
            if(false){
                errors.add(new FormMessage(FIELD_AFFILIATION, MESSAGE_AFFILIATION_INVALID));
            }
        }

        if (Validation.isBlank(title)) {
            errors.add(new FormMessage(FIELD_TITLE, MESSAGE_TITLE_REQUIRED));
        }else{
            //validate if valid affiliation
            if(false){
                errors.add(new FormMessage(FIELD_TITLE, MESSAGE_TITLE_INVALID));
            }
        }

        if (Validation.isBlank(researchDomain)) {
            errors.add(new FormMessage(FIELD_RESEARCH_DOMAIN, MESSAGE_RESEARCH_DOMAIN_REQUIRED));
        }else{
            //validate if valid affiliation
            if(false){
                errors.add(new FormMessage(FIELD_RESEARCH_DOMAIN, MESSAGE_RESEARCH_DOMAIN_INVALID));
            }
        }

        if (errors.size() > 0) {
            context.error(Errors.INVALID_REGISTRATION);
            context.validationError(formData, errors);
            return;
        } else {
            context.success();
        }
    }

    @Override
    public void success(FormContext context) {

    }

    @Override
    public boolean requiresUser() {
        return false;
    }

    @Override
    public boolean configuredFor(KeycloakSession session, RealmModel realm, UserModel user) {
        return true;
    }

    @Override
    public void setRequiredActions(KeycloakSession session, RealmModel realm, UserModel user) {

    }

    @Override
    public boolean isUserSetupAllowed() {
        return false;
    }


    @Override
    public void close() {

    }

    @Override
    public FormAction create(KeycloakSession session) {
        return this;
    }

    @Override
    public void init(Config.Scope config) {

    }

    @Override
    public void postInit(KeycloakSessionFactory factory) {

    }

}
