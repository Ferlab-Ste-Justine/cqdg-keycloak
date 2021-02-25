package ca.cqdg.forms.authenticators;

import ca.cqdg.forms.FormUtils;
import org.jboss.logging.Logger;
import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.authenticators.broker.IdpReviewProfileAuthenticator;
import org.keycloak.authentication.authenticators.broker.util.SerializedBrokeredIdentityContext;
import org.keycloak.broker.provider.BrokeredIdentityContext;
import org.keycloak.forms.login.LoginFormsProvider;
import org.keycloak.models.UserModel;
import org.keycloak.models.utils.FormMessage;
import org.keycloak.services.resources.AttributeFormDataProcessor;
import org.keycloak.userprofile.profile.representations.AttributeUserProfile;

import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;
import java.util.List;

public class CustomReviewProfileAuthenticator extends IdpReviewProfileAuthenticator {
    private static final Logger logger = Logger.getLogger(CustomReviewProfileAuthenticator.class);

    @Override
    protected void actionImpl(AuthenticationFlowContext context, SerializedBrokeredIdentityContext userCtx, BrokeredIdentityContext brokerContext) {

        super.actionImpl(context, userCtx, brokerContext);

        MultivaluedMap<String, String> formData = context.getHttpRequest().getDecodedFormParameters();
        List<FormMessage> errors = FormUtils.validate(formData);

        if (errors != null && !errors.isEmpty()) {
            // Merge with errors that were potentially added by super.actionImpl()
            errors.forEach(error -> context.form().addError(error));

            Response challenge = context.form()
                    .setAttribute(LoginFormsProvider.UPDATE_PROFILE_CONTEXT_ATTR, userCtx)
                    .setFormData(formData)
                    .createUpdateProfilePage();

            context.challenge(challenge);
            return;
        }

        // Update user extended attributes.
        try{
            String email = context.getHttpRequest().getDecodedFormParameters().getFirst("email");
            UserModel userModel = context.getSession().users().getUserByEmail(email, context.getRealm());
            AttributeUserProfile updatedProfile = AttributeFormDataProcessor.toUserProfile(formData);
            FormUtils.updateUserAttributes(userModel, updatedProfile);
        }catch(Exception e){
            logger.error("Failed to update user attributes.", e);
        }
    }
}
