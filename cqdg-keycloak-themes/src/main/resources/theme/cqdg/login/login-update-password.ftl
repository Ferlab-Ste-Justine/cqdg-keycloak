<#import "template.ftl" as layout>
<#import "fragments.ftl" as fragments>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
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
                            <h2>Réinitialisation du mot de passe</h2>
                            <p>Saisissez votre nouveau mot de passe.</p>
                        </div>
                        <div class="notch-content__body">
                            <@fragments.serverError />

                            <form id="kc-passwd-update-form" class="form" action="${url.loginAction}" method="post">
                                <input type="text" id="username" name="username" value="${username}" autocomplete="username"
                                       readonly="readonly" style="display:none;"/>
                                <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

                                <div class="form__group">
                                    <div class="${properties.kcLabelWrapperClass!}">
                                        <label for="password-new" class="${properties.kcLabelClass!}">${msg("passwordNew")}</label>
                                    </div>
                                    <div class="${properties.kcInputWrapperClass!}">
                                        <input type="password" id="password-new" name="password-new" class="${properties.kcInputClass!}"
                                               autofocus autocomplete="new-password"
                                               aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                                        />

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
                                        <input type="password" id="password-confirm" name="password-confirm"
                                               class="${properties.kcInputClass!}"
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
                                    <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                                        <div class="${properties.kcFormOptionsWrapperClass!}">
                                            <#if isAppInitiatedAction??>
                                                <div class="checkbox">
                                                    <label><input type="checkbox" id="logout-sessions" name="logout-sessions" value="on" checked> ${msg("logoutOtherSessions")}</label>
                                                </div>
                                            </#if>
                                        </div>
                                    </div>

                                    <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                                        <#if isAppInitiatedAction??>
                                            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                                            <button class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!}" type="submit" name="cancel-aia" value="true" />${msg("doCancel")}</button>
                                        <#else>
                                            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doSubmit")}" />
                                        </#if>
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