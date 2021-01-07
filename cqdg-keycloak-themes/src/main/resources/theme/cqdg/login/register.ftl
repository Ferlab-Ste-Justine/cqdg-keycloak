<#import "template.ftl" as layout>
<#import "fragments.ftl" as fragments>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>
    <#if section = "header">
        <!-- nothing -->
    <#elseif section = "form">
        <section class="register">
            <div class="register__form">
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
                            <h2>Création de compte</h2>
                            <p>* Notez que tous les champs sont requis.</p>
                        </div>
                        <div class="notch-content__body">
                            <@fragments.serverError />

                            <form id="kc-register-form" class="form" action="${url.registrationAction}" method="post">
                                <div class="form__row">
                                    <div class="form__group">
                                        <div class="${properties.kcLabelWrapperClass!}">
                                            <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                                        </div>
                                        <div class="${properties.kcInputWrapperClass!}">
                                            <input type="text" id="firstName" class="${properties.kcInputClass!}" name="firstName"
                                                   value="${(register.formData.firstName!'')}"
                                                   aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>"
                                            />

                                            <#if messagesPerField.existsError('firstName')>
                                                <span id="input-error-firstname" aria-live="polite">
                                                    ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                                                </span>
                                            </#if>
                                        </div>
                                    </div>

                                    <div class="form__group">
                                        <div class="${properties.kcLabelWrapperClass!}">
                                            <label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}</label>
                                        </div>
                                        <div class="${properties.kcInputWrapperClass!}">
                                            <input type="text" id="lastName" class="${properties.kcInputClass!}" name="lastName"
                                                   value="${(register.formData.lastName!'')}"
                                                   aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>"
                                            />

                                            <#if messagesPerField.existsError('lastName')>
                                                <span id="input-error-lastname" aria-live="polite">
                                                ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                                            </span>
                                            </#if>
                                        </div>
                                    </div>
                                </div>

                                <div class="form__row">
                                    <div class="form__group">
                                        <div class="${properties.kcLabelWrapperClass!}">
                                            <label for="email" class="${properties.kcLabelClass!}">${msg("email")}</label>
                                        </div>
                                        <div class="${properties.kcInputWrapperClass!}">
                                            <input type="text" id="email" class="${properties.kcInputClass!}" name="email"
                                                   value="${(register.formData.email!'')}" autocomplete="email"
                                                   aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                                            />

                                            <#if messagesPerField.existsError('email')>
                                                <span id="input-error-email"  aria-live="polite">
                                                ${kcSanitize(messagesPerField.get('email'))?no_esc}
                                            </span>
                                            </#if>
                                        </div>
                                    </div>

                                    <#if !realm.registrationEmailAsUsername>
                                        <div class="form__group">
                                            <div class="${properties.kcLabelWrapperClass!}">
                                                <label for="username" class="${properties.kcLabelClass!}">${msg("username")}</label>
                                            </div>
                                            <div class="${properties.kcInputWrapperClass!}">
                                                <input type="text" id="username" class="${properties.kcInputClass!}" name="username"
                                                       value="${(register.formData.username!'')}" autocomplete="username"
                                                       aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                                                />

                                                <#if messagesPerField.existsError('username')>
                                                    <span id="input-error-username" aria-live="polite">
                                                    ${kcSanitize(messagesPerField.get('username'))?no_esc}
                                                </span>
                                                </#if>
                                            </div>
                                        </div>
                                    </#if>
                                </div>

                                <div class="form__row">
                                    <#if passwordRequired??>
                                        <div class="form__group">
                                            <div class="${properties.kcLabelWrapperClass!}">
                                                <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                                            </div>
                                            <div class="${properties.kcInputWrapperClass!}">
                                                <input type="password" id="password" class="${properties.kcInputClass!}" name="password"
                                                       autocomplete="new-password"
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
                                                <label for="password-confirm"
                                                       class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label>
                                            </div>
                                            <div class="${properties.kcInputWrapperClass!}">
                                                <input type="password" id="password-confirm" class="${properties.kcInputClass!}"
                                                       name="password-confirm"
                                                       aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                                                />

                                                <#if messagesPerField.existsError('password-confirm')>
                                                    <span id="input-error-password-confirm" aria-live="polite">
                                                        ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                                                    </span>
                                                </#if>
                                            </div>
                                        </div>
                                    </#if>
                                </div>

                                <div class="form__row">
                                    <div class="form__group">
                                        <div class="${properties.kcLabelWrapperClass!}">
                                            <label for="user.attributes.affiliation" class="${properties.kcLabelClass!}">${msg("affiliation")}</label>
                                        </div>
                                        <div class="${properties.kcInputWrapperClass!}">
                                            <select name="user.attributes.affiliation"
                                                    id="user.attributes.affiliation"
                                                    aria-invalid="<#if messagesPerField.existsError('user.attributes.affiliation')>true</#if>"
                                            >
                                                <#list affiliations?keys as key>
                                                    <option value="${key}">${msg(affiliations[key])}</option>
                                                </#list>
                                            </select>


                                            <#if messagesPerField.existsError('user.attributes.affiliation')>
                                                <span id="input-error-password" aria-live="polite">
                                                    ${kcSanitize(messagesPerField.get('user.attributes.affiliation'))?no_esc}
                                                </span>
                                            </#if>
                                        </div>
                                    </div>

                                    <div class="form__group">
                                        <div class="${properties.kcLabelWrapperClass!}">
                                            <label for="user.attributes.title" class="${properties.kcLabelClass!}">${msg("title")}</label>
                                        </div>
                                        <div class="${properties.kcInputWrapperClass!}">
                                            <select name="user.attributes.title"
                                                    id="user.attributes.title"
                                                    aria-invalid="<#if messagesPerField.existsError('user.attributes.title')>true</#if>"
                                            >
                                                <#list titles?keys as key>
                                                    <option value="${key}">${msg(titles[key])}</option>
                                                </#list>
                                            </select>

                                            <#if messagesPerField.existsError('user.attributes.title')>
                                                <span id="input-error-password" aria-live="polite">
                                                    ${kcSanitize(messagesPerField.get('user.attributes.title'))?no_esc}
                                                </span>
                                            </#if>
                                        </div>
                                    </div>
                                </div>

                                <div class="form__row">
                                    <div class="form__group">
                                        <div class="${properties.kcLabelWrapperClass!}">
                                            <label for="user.attributes.researchDomain" class="${properties.kcLabelClass!}">${msg("researchDomain")}</label>
                                        </div>
                                        <div class="${properties.kcInputWrapperClass!}">
                                            <select name="user.attributes.researchDomain"
                                                    id="user.attributes.researchDomain"
                                                    aria-invalid="<#if messagesPerField.existsError('user.attributes.researchDomain')>true</#if>"
                                            >
                                                <#list researchDomains?keys as key>
                                                    <option value="${key}">${msg(researchDomains[key])}</option>
                                                </#list>
                                            </select>

                                            <#if messagesPerField.existsError('user.attributes.researchDomain')>
                                                <span id="input-error-password" aria-live="polite">
                                                    ${kcSanitize(messagesPerField.get('user.attributes.researchDomain'))?no_esc}
                                                </span>
                                            </#if>
                                        </div>
                                    </div>
                                </div>

                                <div class="form__row">
                                    <#if recaptchaRequired??>
                                        <div class="form__group">
                                            <div class="${properties.kcInputWrapperClass!}">
                                                <div class="g-recaptcha" data-size="normal" data-sitekey="${recaptchaSiteKey}"></div>
                                            </div>
                                        </div>
                                    </#if>
                                </div>

                                <div class="form__row">
                                    <div class="form__group" style="min-width: 20.5rem;">
                                        <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                                            <div class="${properties.kcFormOptionsWrapperClass!}">
                                                <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                                            </div>
                                        </div>

                                        <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                                            <input class="btn" type="submit" value="${msg("doRegister")}"/>
                                        </div>
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