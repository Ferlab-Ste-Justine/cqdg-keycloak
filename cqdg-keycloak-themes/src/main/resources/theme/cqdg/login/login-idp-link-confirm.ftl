<#import "layout.ftl" as template>
<#import "fragments.ftl" as fragments>

<@template.layout section>
    <@fragments.page>  
        <form id="kc-register-form" action="${url.loginAction}" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <button type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="submitAction" id="updateProfile" value="updateProfile">${msg("confirmLinkIdpReviewProfile")}</button>
                <button type="submit" class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="submitAction" id="linkAccount" value="linkAccount">${msg("confirmLinkIdpContinue", idpAlias)}</button>
            </div>
        </form>
    </@fragments.page>
</@template.layout>