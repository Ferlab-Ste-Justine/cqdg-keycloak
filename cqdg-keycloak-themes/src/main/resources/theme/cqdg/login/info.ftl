<#import "layout.ftl" as template>
<#import "fragments.ftl" as fragments>

<@template.layout>
    <@fragments.page>  
        <div id="kc-info-message">
            <p class="instruction">${message.summary}<#if requiredActions??><#list requiredActions>: <b><#items as reqActionItem>${msg("requiredAction.${reqActionItem}")}<#sep>, </#items></b></#list><#else></#if></p>
            <#if skipLink??>
            <#else>
                <#if pageRedirectUri?has_content>
                    <p><a class="ant-btn ant-btn-link link bottom-link" href="${pageRedirectUri}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
                <#elseif actionUri?has_content>
                    <p><a class="ant-btn ant-btn-link link bottom-link" href="${actionUri}">${kcSanitize(msg("proceedWithAction"))?no_esc}</a></p>
                <#elseif (client.baseUrl)?has_content>
                    <p><a class="ant-btn ant-btn-link link bottom-link" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
                </#if>
            </#if>
        </div>
    </@fragments.page>
</@template.layout>