<#import "layout.ftl" as template>
<#import "fragments.ftl" as fragments>

<@template.layout section>
    <@fragments.page>  
        <@fragments.error />
        <p id="instruction1" class="instruction">
            <a class="ant-btn ant-btn-link link bottom-link"  href="${url.loginRestartFlowUrl}">${msg("backToLogin")}</a>
        </p>
    </@fragments.page>
</@template.layout>