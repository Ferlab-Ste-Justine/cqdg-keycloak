<#import "layout.ftl" as template>
<#import "fragments.ftl" as fragments>

<@template.layout section>
    <@fragments.page>
        <div class="link-account">
            <div data-show="true" class="ant-alert ant-alert-info ant-alert-with-description ant-alert-no-icon" role="alert">
                <div class="ant-alert-content">
                    <div class="ant-alert-message">${msg("emailLinkIdpTitle", idpAlias)}</div>
                    <div class="ant-alert-description">${msg("emailLinkIdp1", idpAlias, realm.displayName)} <span class="email">${brokerContext.username}</span></div>
                </div>
            </div>

            <div class="form__group">
                <h3>${msg("emailLinkIdp2")}</h3>
                <a class="ant-btn ant-btn-link inline-link" href="${url.loginAction}">${msg("doClickHere")}</a> ${msg("emailLinkIdp3")}
            </div>
            <div class="form__group">
                <h3>${msg("emailLinkIdp4")}</h3>
                <a class="ant-btn ant-btn-link inline-link" href="${url.loginAction}">${msg("doClickHere")}</a> ${msg("emailLinkIdp5")}
            </div>
            <div class="form__group">
                <a class="ant-btn ant-btn-link link bottom-link" href="${url.loginRestartFlowUrl}">${msg("doBacklogin")}</a>
            </div>
        </div>
    </@fragments.page>
</@template.layout>