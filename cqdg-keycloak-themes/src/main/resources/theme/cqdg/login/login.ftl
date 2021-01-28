<#import "template.ftl" as template>
<#import "fragments.ftl" as fragments>
<@template.layout>
    <script type="text/javascript">
        function clickCheckbox(el) {
            el.parentNode.classList.toggle("ant-checkbox-checked");
        }
    </script>
    <@fragments.page>
        <div class="notch-content__header">
            <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                <div class="text-right">
                    <a href="${url.registrationUrl}" class="ant-btn ant-btn-link link top-link">${msg("doRegister")}</a>
                </div>
            </#if>
            <@fragments.error />
            <@fragments.success />
            <h2>Connexion</h2>
            <p>Saisissez vos identifiants pour vous connecter</p>
        </div>
        <div class="notch-content__body">
            <#if realm.password>
                <form id="kc-form-login" class="form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                    <div class="form__group">
                        <div class="g-signin2 btn-google" data-width="350" data-theme="dark" data-longtitle="true" data-onsuccess="onSignIn"></div>
                    </div>
                    <div class="form__group">
                        <div class="g-signin2 btn-google" data-width="350" data-theme="dark" data-longtitle="true" data-onsuccess="onSignIn"></div>
                    </div>
                    <div class="form__group text-center">
                        <span>Or</span>
                    </div>
                    <div class="form__group">
                        <label for="username" class="${properties.kcLabelClass!}">
                            ${msg("email")}
                        </label>

                        <input tabindex="1" id="username" class="ant-input" name="username" value="${(login.username!'')}"
                            type="text" autofocus autocomplete="off" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                    </div>

                    <div class="form__group">
                        <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>

                        <input tabindex="2" id="password" class="ant-input" name="password" type="password" autocomplete="off"
                            aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                            <#if realm.resetPasswordAllowed>
                                <a tabindex="5" class="ant-btn ant-btn-link link bottom-link" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                            </#if>
                    </div>

                    <div class="form__group">
                        <div id="kc-form-options">
                            <#if realm.rememberMe && !usernameEditDisabled??>
                                <div class="checkbox">
                                    <label class="ant-checkbox-wrapper">
                                        <#if login.rememberMe??>
                                            <span class="ant-checkbox ant-checkbox-checked">
                                                <input type="checkbox" class="ant-checkbox-input" value="">
                                                <span class="ant-checkbox-inner"></span>
                                            </span>
                                            <span>${msg("rememberMe")}</span>
                                        <#else>
                                        <span class="ant-checkbox">
                                            <input onclick="clickCheckbox(this)" type="checkbox" class="ant-checkbox-input" value="">
                                            <span class="ant-checkbox-inner"></span>
                                        </span>
                                        <span>${msg("rememberMe")}</span>
                                        </#if>
                                    </label>
                                </div>
                            </#if>
                        </div>
                    </div>

                    <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                        <button type="submit" tabindex="4" class="ant-btn ant-btn-primary" id="kc-login">${msg("doLogIn")}</button>
                    </div>
                </form>
            </#if>
        </div>
    </@fragments.page>
</@template.layout>