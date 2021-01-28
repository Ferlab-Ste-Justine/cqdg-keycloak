<#import "template.ftl" as template>
<#import "fragments.ftl" as fragments>
<@template.layout>
    <@fragments.page>
        <div class="notch-content__header">
            <h2>Création de compte</h2>
            <p>* Notez que tous les champs sont requis.</p>
        </div>
        <div class="notch-content__body">
            <@fragments.error />

            <form id="kc-register-form" class="register" action="${url.registrationAction}" method="post">
                <div class="form__group form__row">
                    <div class="form__row__item">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                            <input class="ant-input" type="text" id="firstName" class="${properties.kcInputClass!}" name="firstName"
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
                    <div class="form__row__item">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="lastName" class="${properties.kcLabelClass!}">${msg("lastName")}</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                            <input class="ant-input" type="text" id="lastName" class="${properties.kcInputClass!}" name="lastName"
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
                <div class="form__group">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="email" class="${properties.kcLabelClass!}">${msg("email")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <input class="ant-input" type="text" id="email" class="${properties.kcInputClass!}" name="email"
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

                <#if passwordRequired??>
                    <div class="form__group">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                            <input class="ant-input" type="password" id="password" class="${properties.kcInputClass!}" name="password"
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
                            <input class="ant-input" type="password" id="password-confirm" class="${properties.kcInputClass!}"
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

                <div class="form__group form__row">
                    <div class="form__row__item">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="user.attributes.affiliation" class="${properties.kcLabelClass!}">${msg("affiliation")}</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                            <select class="ant-input" name="user.attributes.affiliation"
                                    id="user.attributes.affiliation"
                                    aria-invalid="<#if messagesPerField.existsError('user.attributes.affiliation')>true</#if>"
                            >
                                <#--<#list affiliations?keys as key> -->
                                    <option value="affiliation 1">Affiliation 1</option>
                                    <option value="affiliation 2">Affiliation 2</option>
                                    <option value="affiliation 3">Affiliation 3</option>
                                    <option value="affiliation 4">Affiliation 4</option>
                                    <option value="affiliation 5">Affiliation 5</option>
                                <#--</#list>-->
                            </select>
                            <#if messagesPerField.existsError('user.attributes.affiliation')>
                                <span id="input-error-password" aria-live="polite">
                                    ${kcSanitize(messagesPerField.get('user.attributes.affiliation'))?no_esc}
                                </span>
                            </#if>
                        </div>
                    </div>

                    <div class="form__row__item">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="user.attributes.title" class="${properties.kcLabelClass!}">${msg("title")}</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                            <select class="ant-input" name="user.attributes.title"
                                    id="user.attributes.title"
                                    aria-invalid="<#if messagesPerField.existsError('user.attributes.title')>true</#if>"
                            >
                                <#-- <#list titles?keys as key> 
                                    <option value="${key}">${msg(titles[key])}</option>-->
                                    <option value="title 1">title 1</option>
                                    <option value="title 2">title 2</option>
                                    <option value="title 3">title 3</option>
                                    <option value="title 4">title 4</option>
                                    <option value="title 5">title 5</option>
                                <#-- </#list> -->
                            </select>

                            <#if messagesPerField.existsError('user.attributes.title')>
                                <span id="input-error-password" aria-live="polite">
                                    ${kcSanitize(messagesPerField.get('user.attributes.title'))?no_esc}
                                </span>
                            </#if>
                        </div>
                    </div>
                </div>

                <div class="form__group">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="user.attributes.researchDomain" class="${properties.kcLabelClass!}">${msg("researchDomain")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <select class="ant-input"  name="user.attributes.researchDomain"
                                id="user.attributes.researchDomain"
                                aria-invalid="<#if messagesPerField.existsError('user.attributes.researchDomain')>true</#if>"
                        >
                            <#--<#list researchDomains?keys as key>
                                <option value="${key}">${msg(researchDomains[key])}</option>-->
                                <option value="domain 1">domain 1</option>
                                <option value="domain 2">domain 2</option>
                                <option value="domain 3">domain 3</option>
                                <option value="domain 4">domain 4</option>
                                <option value="domain 5">domain 5</option>

                            <#--</#list>-->
                        </select>

                        <#if messagesPerField.existsError('user.attributes.researchDomain')>
                            <span id="input-error-password" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('user.attributes.researchDomain'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </div>

                <#if recaptchaRequired??>
                    <div class="form__group">
                        <div class="${properties.kcInputWrapperClass!}">
                            <div class="g-recaptcha" data-size="normal" data-sitekey="${recaptchaSiteKey}"></div>
                        </div>
                    </div>
                </#if>
                <div class="form__group" style="min-width: 20.5rem;">
                    <button type="submit" tabindex="4" class="ant-btn ant-btn-primary">${msg("doRegister")}</button>
                </div>
                <div class="form__group">
                    <a class="ant-btn ant-btn-link link bottom-link" href="${url.loginUrl}">${msg("alreadyAnAccount")}</a>
                </div>
            </form>
        </div>
    </@fragments.page>
</@template.layout>