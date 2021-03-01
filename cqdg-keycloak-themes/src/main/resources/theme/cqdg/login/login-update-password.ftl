<#import "layout.ftl" as template>
<#import "fragments.ftl" as fragments>
<@template.layout>
    <@fragments.page>
        <div class="notch-content__header">
            <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                <div class="text-right">
                    <a href="${url.registrationUrl}" class="ant-btn ant-btn-link link top-link">${msg("doRegister")}</a>
                </div>
            </#if>
            <@fragments.error />
            <h2>${msg("doResetPassword")}</h2>
            <p>${msg("resetPasswordHeadLine")}</p>
        </div>
        <div class="notch-content__body">
            <form id="kc-passwd-update-form" class="reset-password" class="form" action="${url.loginAction}" method="post">
                <input type="text" id="username" name="username" value="${username}" autocomplete="username"
                        readonly="readonly" style="display:none;"/>
                <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

                <div class="form__group">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="password-new" class="${properties.kcLabelClass!}">${msg("passwordNew")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input class="ant-input" type="password" id="password-new" name="password-new"
                                autofocus autocomplete="new-password"
                                aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                        />
                        <span class="sub-text">${msg("invalidPasswordCustomMessage", 8)}</span>

                        <#if messagesPerField.existsError('password')>
                            <span id="input-error-password" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('password'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </div>

                <div class="form__group">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input class="ant-input" type="password" id="password-confirm" name="password-confirm"
                                autocomplete="new-password"
                                aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                        />

                        <#if messagesPerField.existsError('password-confirm')>
                            <span id="input-error-password-confirm" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                            </span>
                        </#if>

                    </div>
                </div>
                <div class="form__group">
                    <a class="ant-btn ant-btn-link link bottom-link" href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a>
                </div>
                <div class="form__group">
                    <button type="submit" tabindex="4" class="ant-btn ant-btn-primary" id="kc-login">${kcSanitize(msg("doResetPassword"))}</button>
                </div>
            </form>
        </div>
    </@fragments.page>
</@template.layout>