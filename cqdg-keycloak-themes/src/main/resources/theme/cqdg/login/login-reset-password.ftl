<#import "template.ftl" as template>
<#import "fragments.ftl" as fragments>
<@template.layout>
    <@fragments.page>
        <div class="notch-content__header">
            <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                <div class="text-right">
                    <a href="${url.registrationUrl}" class="ant-btn ant-btn-link link top-link">${kcSanitize(msg("doRegister"))}</a>
                </div>
            </#if>
            <@fragments.error />

            <h2>Mot de passe oublié ?</h2>
            <p>Saisissez l'adresse courriel de votre compte utilisateur et nous vous enverrons un lien de réinitialisation de mot de passe.</p>
        </div>
        <div class="notch-content__body">
            <form id="kc-reset-password-form" class="form" action="${url.loginAction}" method="post">
                <div class="form__group">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="username" class="${properties.kcLabelClass!}">${msg("email")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <#if auth?has_content && auth.showUsername()>
                            <input class="ant-input" type="text" id="username" name="username" class="${properties.kcInputClass!}" autofocus value="${auth.attemptedUsername}" aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                        <#else>
                            <input class="ant-input" type="text" id="username" name="username" class="${properties.kcInputClass!}" autofocus aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                        </#if>
                    </div>
                </div>
                <div class="form__group">
                    <a class="ant-btn ant-btn-link link bottom-link" href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a>
                </div>
                <div class="form__group">
                    <button type="submit" tabindex="4" class="ant-btn ant-btn-primary" id="kc-login">${kcSanitize(msg("doSubmit"))}</button>
                </div>
            </form>
        </div>
    </@fragments.page>
</@template.layout>