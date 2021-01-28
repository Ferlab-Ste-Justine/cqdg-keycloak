<#import "template.ftl" as template>
<#import "fragments.ftl" as fragments>
<@template.layout>
    <@fragments.page>
        <p id="instruction1" class="instruction">
            ${msg("pageExpiredMsg1")} <a id="loginRestartLink" href="${url.loginRestartFlowUrl}">${msg("doClickHere")}</a> .<br/>
            ${msg("pageExpiredMsg2")} <a id="loginContinueLink" href="${url.loginAction}">${msg("doClickHere")}</a> .
        </p>
    </@fragments.page>
</@template.layout>