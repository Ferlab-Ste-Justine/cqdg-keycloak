<#import "layout.ftl" as template>
<#import "fragments.ftl" as fragments>
<@template.layout>
    <@fragments.page>
        <div class="notch-content__header">
            <h2>${msg("loginProfileTitle")}</h2>
            <p>${msg("isMandatory")}</p>
        </div>
        <div class="notch-content__body">
            <form id="kc-update-profile-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
                <div class="form__group form__row">
                    <div class="form__row__item">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="firstName" class="${properties.kcLabelClass!}">${msg("firstName")}</label>
                        </div>
                        <div class="${properties.kcInputWrapperClass!}">
                            <input class="ant-input" type="text" id="firstName" class="${properties.kcInputClass!}" name="firstName"
                                value="${(user.firstName!'')}"
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
                                value="${(user.lastName!'')}"
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
                        <input type="text" id="email" name="email" value="${(user.email!'')}"
                            class="ant-input"
                            aria-invalid="<#if messagesPerField.existsError('email')>true</#if>"
                        />

                        <#if messagesPerField.existsError('email')>
                            <span id="input-error-email" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('email'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </div>

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
                                <#list affiliations?keys as key>
                                    <option value="${key}" <#if key == user.attributes['affiliation']!'notfound'>selected = "selected"</#if>>
                                        ${msg(affiliations[key])}
                                    </option>
                                </#list>
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
                                <#list titles?keys as key>
                                    <option value="${key}" <#if key == user.attributes['title']!'notfound'>selected = "selected"</#if>>
                                        ${msg(titles[key])}
                                    </option>
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

                <div class="form__group">
                    <div class="${properties.kcLabelWrapperClass!}">
                        <label for="user.attributes.researchDomain" class="${properties.kcLabelClass!}">${msg("researchDomain")}</label>
                    </div>
                    <div class="${properties.kcInputWrapperClass!}">
                        <select class="ant-input"  name="user.attributes.researchDomain"
                                id="user.attributes.researchDomain"
                                aria-invalid="<#if messagesPerField.existsError('user.attributes.researchDomain')>true</#if>"
                        >
                            <#list researchDomains?keys as key>
                                <option value="${key}" <#if key == user.attributes['researchDomain']!'notfound'>selected = "selected"</#if>>
                                    ${msg(researchDomains[key])}
                                </option>
                            </#list>
                        </select>

                        <#if messagesPerField.existsError('user.attributes.researchDomain')>
                            <span id="input-error-password" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('user.attributes.researchDomain'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </div>


                <div class="form__group">
                    <a class="ant-btn ant-btn-link link bottom-link" href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a>
                </div>
                <div class="form__group">
                    <button type="submit" tabindex="4" class="ant-btn ant-btn-primary">${kcSanitize(msg("doSubmit"))}</button>
                </div>
            </form>
        </div>
    </@fragments.page>
</@template.layout>