<#import "template.ftl" as layout>
<#import "fragments.ftl" as fragments>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        <!-- nothing -->
    <#elseif section = "form">
        <section class="login">
            <div class="login__form">
                <div class="card--notched">
                    <div aria-hidden="true" class="notch-top">
                        <svg class="notch notch--top" height="24" width="24" xmlns="http://www.w3.org/2000/svg">
                            <g clip-path="url(#clip0)">
                                <path class="notch__triangle" d="M24 24H0L24 0v24z"></path>
                                <path class="notch__border" d="M23.782-1l.707.707L-.292 24.49-1 23.782z"></path>
                            </g>
                            <defs>
                                <clipPath id="clip0">
                                    <path d="M0 0h24v24H0z"></path>
                                </clipPath>
                            </defs>
                        </svg>
                    </div>
                    <div class="notch-content">
                        <div class="notch-content__header">
                            <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                                <p class="u-text-right">
                                    <a href="${url.registrationUrl}">${msg("doRegister")}</a>
                                </p>
                            </#if>
                            <h2>Connexion</h2>
                            <p>Saisissez vos identifiants pour vous connecter</p>
                        </div>
                        <div class="notch-content__body">
                            <#if realm.password>
                                <#if messagesPerField.existsError('username','password')>
                                    <div class="alert alert--error" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                        <span aria-live="polite">${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}</span>
                                    </div>
                                <#else>
                                    <@fragments.serverError />
                                </#if>

                                <form id="kc-form-login" class="form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                                    <div class="form__group">
                                        <label for="username" class="${properties.kcLabelClass!}">
                                            <#if !realm.loginWithEmailAllowed>
                                                ${msg("username")}
                                            <#elseif !realm.registrationEmailAsUsername>
                                                ${msg("usernameOrEmail")}
                                            <#else>
                                                ${msg("email")}
                                            </#if>
                                        </label>

                                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"
                                               type="text" autofocus autocomplete="off" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                                    </div>

                                    <div class="form__group">
                                        <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>

                                        <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="off"
                                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                                    </div>

                                    <div class="form__group">
                                        <div id="kc-form-options">
                                            <#if realm.rememberMe && !usernameEditDisabled??>
                                                <div class="checkbox">
                                                    <label>
                                                        <#if login.rememberMe??>
                                                            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                                        <#else>
                                                            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                                        </#if>
                                                    </label>
                                                </div>
                                            </#if>
                                        </div>
                                        <div class="${properties.kcFormOptionsWrapperClass!}">
                                            <#if realm.resetPasswordAllowed>
                                                <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                                            </#if>
                                        </div>
                                    </div>

                                    <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                                        <input tabindex="4" class="btn" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                                    </div>
                                </form>
                            </#if>
                        </div>
                    </div>
                    <div aria-hidden="true" class="notch-btm">
                        <svg class="notch notch--btm" height="24" width="24" xmlns="http://www.w3.org/2000/svg">
                            <g clip-path="url(#clip0)">
                                <path class="notch__triangle" d="M0 0h24L0 24V0z"></path>
                                <path class="notch__border" d="M.219 25l-.708-.707L24.293-.49 25 .218.219 25z"></path>
                            </g>
                            <defs>
                                <clipPath id="clip0">
                                    <path d="M0 0h24v24H0z"></path>
                                </clipPath>
                            </defs>
                        </svg>
                    </div>
                </div>
            </div>
            <div class="login__text">
                <h2>Le centre québécois de données génomiques</h2>
                <h1>Portail de données</h1>
                <p>Le Centre québécois de données génomiques est une plateforme d'harmonisation et de diffusion des données génomiques générées par les études cliniques et de recherche du Québec.</p>
            </div>
        </section>


    </#if>

</@layout.registrationLayout>