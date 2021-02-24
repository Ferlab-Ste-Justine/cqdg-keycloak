package ca.cqdg.forms.authenticators;

import org.keycloak.authentication.AuthenticationFlowContext;
import org.keycloak.authentication.authenticators.broker.IdpReviewProfileAuthenticator;
import org.keycloak.authentication.authenticators.broker.util.SerializedBrokeredIdentityContext;
import org.keycloak.broker.provider.BrokeredIdentityContext;

public class CustomReviewProfileAuthenticator extends IdpReviewProfileAuthenticator {

    @Override
    protected void actionImpl(AuthenticationFlowContext context, SerializedBrokeredIdentityContext userCtx, BrokeredIdentityContext brokerContext) {
        System.out.println(">>>>>>>>>>>>>>>>>>>>> VALIDATE MANDATORY CUSTOM FIELDS");
        super.actionImpl(context, userCtx, brokerContext);
    }
}
