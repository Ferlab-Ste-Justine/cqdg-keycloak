<#import "layout.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "header">
        <!-- nothing -->
    <#elseif section = "form">
        <section>
            <p class="instruction">${msg("emailVerifyInstruction1")}</p>

            <p class="instruction">
                ${msg("emailVerifyInstruction2")}
                <br/>
                <a href="${url.loginAction}">${msg("doClickHere")}</a> ${msg("emailVerifyInstruction3")}
            </p>
        </section>
    </#if>
</@layout.registrationLayout>