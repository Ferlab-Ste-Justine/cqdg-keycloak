<#macro serverError>
    <#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
        <div class="alert alert--${message.type}" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">×</span>
            </button>
            <span aria-live="polite">${kcSanitize(message.summary)?no_esc}</span>
        </div>
    </#if>
</#macro>