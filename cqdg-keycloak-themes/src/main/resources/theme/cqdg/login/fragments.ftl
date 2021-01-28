<#macro error>
    <#if message?has_content && message.type == 'error'>
        <script type="text/javascript">
            function closeAlert() {
                var alert = document.getElementById("alert");
                alert.parentNode.removeChild(alert);
            }
        </script>
        <div id="alert" data-show="true" class="ant-alert ant-alert-error ant-alert-with-description ant-alert-no-icon" role="alert">
            <div class="ant-alert-content">
                <div class="ant-alert-message">Connexion échouée</div>
                <div class="ant-alert-description">${kcSanitize(message.summary)?no_esc}</div>
            </div>
            <button onclick="closeAlert()" type="button" class="ant-alert-close-icon" tabindex="0">
                <span role="img" aria-label="close" class="anticon anticon-close">
                    <svg viewBox="64 64 896 896" focusable="false" data-icon="close" width="1em" height="1em" fill="currentColor" aria-hidden="true">
                        <path
                            d="M563.8 512l262.5-312.9c4.4-5.2.7-13.1-6.1-13.1h-79.8c-4.7 0-9.2 2.1-12.3 5.7L511.6 449.8 295.1 191.7c-3-3.6-7.5-5.7-12.3-5.7H203c-6.8 0-10.5 7.9-6.1 13.1L459.4 512 196.9 824.9A7.95 7.95 0 00203 838h79.8c4.7 0 9.2-2.1 12.3-5.7l216.5-258.1 216.5 258.1c3 3.6 7.5 5.7 12.3 5.7h79.8c6.8 0 10.5-7.9 6.1-13.1L563.8 512z"
                        ></path>
                    </svg>
                </span>
            </button>
        </div>
    </#if>
</#macro>
<#macro success>
    <#if message?has_content && message.type == 'success'>
        <div data-show="true" class="ant-alert ant-alert-success ant-alert-with-description ant-alert-no-icon" role="alert">
            <div class="ant-alert-content">
                <div class="ant-alert-message">Success</div>
                <div class="ant-alert-description">${kcSanitize(message.summary)?no_esc}</div>
            </div>
        </div>
    </#if>
</#macro>
<#macro page>
    <section class="page-container">
        <div class="page-content-container">
            <div class="form-container">
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
                        <#nested>
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
            <div class="text-container">
                <h2>Le centre québécois de données génomiques</h2>
                <h1>Portail de données</h1>
                <p>Le Centre québécois de données génomiques est une plateforme d'harmonisation et de diffusion des données génomiques générées par les études cliniques et de recherche du Québec.</p>
            </div>
        </div>
    </section>
</#macro>
<#macro idpButton type>
    <#if type == 'google'>
        <div class="social-button">
            <img class="idp-icon" src="${url.resourcesPath}/img/google-icon.svg" />
            <div class="idp-text">Sign in with Google</div>
        </div>
    </#if>
</#macro>