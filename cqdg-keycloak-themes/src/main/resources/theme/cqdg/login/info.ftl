<#import "template.ftl" as layout>
<#import "fragments.ftl" as fragments>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "form">
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
                            <h2>Information</h2>
                        </div>
                        <div class="notch-content__body">
                            <div id="kc-info-message">
                                <p class="instruction">
                                    ${message.summary}
                                    <#if requiredActions??>
                                        <#list requiredActions>
                                            : <b><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}<#sep>, </#items></b>
                                        </#list>
                                    </#if>
                                </p>
                                <#if pageRedirectUri?has_content>
                                    <p><a href="${pageRedirectUri}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
                                <#elseif actionUri?has_content>
                                    <p><a href="${actionUri}">${kcSanitize(msg("proceedWithAction"))?no_esc}</a></p>
                                <#elseif (client.baseUrl)?has_content>
                                    <p><a href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
                                </#if>
                            </div>
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