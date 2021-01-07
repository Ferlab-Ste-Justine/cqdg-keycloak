<#import "template.ftl" as layout>
<#import "fragments.ftl" as fragments>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        <!-- nothing -->
    <#elseif section = "form">
        <section class="reset-password">
            <div class="reset-password__form">
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
                            <h2>Mot de passe oublié ?</h2>
                            <p>Saisissez l'adresse courriel de votre compte utilisateur et nous vous enverrons un lien de réinitialisation de mot de passe.</p>
                        </div>
                        <div class="notch-content__body">
                            <@fragments.serverError />

                            <form id="kc-reset-password-form" class="form" action="${url.loginAction}" method="post">
                                <div class="form__group">
                                    <div class="${properties.kcLabelWrapperClass!}">
                                        <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                                    </div>
                                    <div class="${properties.kcInputWrapperClass!}">
                                        <#if auth?has_content && auth.showUsername()>
                                            <input type="text" id="username" name="username" class="${properties.kcInputClass!}" autofocus value="${auth.attemptedUsername}" aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                                        <#else>
                                            <input type="text" id="username" name="username" class="${properties.kcInputClass!}" autofocus aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
                                        </#if>

                                        <#if messagesPerField.existsError('username')>
                                            <span id="input-error-username" aria-live="polite">
                                                ${kcSanitize(messagesPerField.get('username'))?no_esc}
                                            </span>
                                        </#if>
                                    </div>
                                </div>
                                <div class="form__group">
                                    <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                                        <div class="${properties.kcFormOptionsWrapperClass!}">
                                            <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                                        </div>
                                    </div>

                                    <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                                        <input class="btn" type="submit" value="${msg("doSubmit")}"/>
                                    </div>
                                </div>
                            </form>
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