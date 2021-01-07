<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="robots" content="noindex, nofollow">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>
        <title>${msg("loginTitle",(realm.displayName!''))}</title>
        <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
        <#if properties.stylesCommon?has_content>
            <#list properties.stylesCommon?split(' ') as style>
                <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <#if properties.styles?has_content>
            <#list properties.styles?split(' ') as style>
                <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <#if properties.scripts?has_content>
            <#list properties.scripts?split(' ') as script>
                <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <#if scripts??>
            <#list scripts as script>
                <script src="${script}" type="text/javascript"></script>
            </#list>
        </#if>
    </head>

    <body class="${properties.kcBodyClass!}">
        <header class="header">

            <div class="header__logo">
                <a href="/"><img src="${url.resourcesPath}/img/logo.svg"></a>
            </div>

            <div class="header__nav">
                <a class="btn btn">
                    <svg fill="currentColor" preserveAspectRatio="xMidYMid meet" height="1em" width="1em" viewBox="0 0 40 40" style="vertical-align: middle;">
                        <g>
                            <path d="m35.8 10.6q0.3 0.3 0.6 0.8h-10.5v-10.5q0.4 0.3 0.8 0.6z m-10.7 3.7h12.2v23.6q0 0.9-0.6 1.5t-1.6 0.6h-30q-0.8 0-1.5-0.6t-0.6-1.5v-35.8q0-0.8 0.6-1.5t1.5-0.6h17.9v12.1q0 0.9 0.6 1.6t1.5 0.6z m3.6 16.4v-1.4q0-0.3-0.2-0.5t-0.5-0.2h-15.7q-0.3 0-0.5 0.2t-0.2 0.5v1.4q0 0.3 0.2 0.5t0.5 0.2h15.7q0.3 0 0.5-0.2t0.2-0.5z m0-5.7v-1.4q0-0.3-0.2-0.5t-0.5-0.2h-15.7q-0.3 0-0.5 0.2t-0.2 0.5v1.4q0 0.3 0.2 0.5t0.5 0.2h15.7q0.3 0 0.5-0.2t0.2-0.5z m0-5.7v-1.4q0-0.4-0.2-0.6t-0.5-0.2h-15.7q-0.3 0-0.5 0.2t-0.2 0.6v1.4q0 0.3 0.2 0.5t0.5 0.2h15.7q0.3 0 0.5-0.2t0.2-0.5z"></path>
                        </g>
                    </svg>
                    Répertoire de fichiers
                </a>
                <a class="btn">
                    <svg fill="currentColor" preserveAspectRatio="xMidYMid meet" height="1em" width="1em" viewBox="0 0 40 40" style="vertical-align: middle;">
                        <g>
                            <path d="m32.5 7.5h-25l-2.5 15v10h30v-10l-2.5-15z m-5 15l-2.5 5h-10l-2.5-5h-4.4l1.9-12.5h20l1.9 12.5h-4.4z"></path>
                        </g>
                    </svg>
                    Études
                </a>
            </div>

            <div class="header__actions">
                <a class="btn btn--text">
                    <svg fill="currentColor" preserveAspectRatio="xMidYMid meet" height="1em" width="1em" viewBox="0 0 40 40" class="big">
                        <g>
                            <path d="m14.1 17.1h11.5v-4.2q0-2.4-1.7-4.1t-4-1.7-4.1 1.7-1.7 4.1v4.2z m18.6 2.2v12.8q0 0.9-0.6 1.6t-1.5 0.6h-21.5q-0.8 0-1.5-0.6t-0.6-1.6v-12.8q0-0.9 0.6-1.5t1.5-0.7h0.8v-4.2q0-4.1 2.9-7.1t7.1-2.9 7 2.9 3 7.1v4.2h0.7q0.9 0 1.5 0.7t0.6 1.5z"></path>
                        </g>
                    </svg>
                    Connexion
                </a>
                <div class="u-separator"></div>
                <a class="btn btn--text">
                    <svg class="big cart" width="16px" height="16px" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M0.666656 1.33334V2.66668H1.99999L4.39999 7.72668L3.49999 9.35334C3.01332 10.2467 3.65332 11.3333 4.66666 11.3333H12.6667V10H4.66666L5.39999 8.66668H10.3667C10.8667 8.66668 11.3067 8.39334 11.5333 7.98001L13.92 3.65334C14.1667 3.21334 13.8467 2.66668 13.34 2.66668H3.47332L2.84666 1.33334H0.666656ZM4.66666 12C3.93332 12 3.33999 12.6 3.33999 13.3333C3.33999 14.0667 3.93332 14.6667 4.66666 14.6667C5.39999 14.6667 5.99999 14.0667 5.99999 13.3333C5.99999 12.6 5.39999 12 4.66666 12ZM10.0067 13.3333C10.0067 12.6 10.6 12 11.3333 12C12.0667 12 12.6667 12.6 12.6667 13.3333C12.6667 14.0667 12.0667 14.6667 11.3333 14.6667C10.6 14.6667 10.0067 14.0667 10.0067 13.3333Z"></path>
                    </svg>
                    Panier
                </a>
                <div class="u-separator"></div>
                <a class="link" href="https://docs.qa.cqdg.ferlab.bio/">
                    Documentation
                    <svg fill="currentColor" preserveAspectRatio="xMidYMid meet" height="1em" width="1em" viewBox="0 0 40 40" class="link__icon">
                        <g>
                            <path d="m31.4 20.7v7.2q0 2.6-1.9 4.5t-4.5 1.9h-18.6q-2.6 0-4.5-1.9t-1.9-4.5v-18.6q0-2.7 1.9-4.6t4.5-1.8h15.7q0.4 0 0.6 0.2t0.2 0.5v1.4q0 0.3-0.2 0.5t-0.6 0.2h-15.7q-1.4 0-2.5 1.1t-1 2.5v18.6q0 1.4 1 2.5t2.5 1h18.6q1.5 0 2.5-1t1.1-2.5v-7.2q0-0.3 0.2-0.5t0.5-0.2h1.4q0.3 0 0.5 0.2t0.2 0.5z m8.6-19.3v11.5q0 0.5-0.4 1t-1 0.4-1-0.4l-4-4-14.5 14.6q-0.2 0.2-0.5 0.2t-0.5-0.2l-2.6-2.6q-0.2-0.2-0.2-0.5t0.2-0.5l14.6-14.5-4-4q-0.4-0.4-0.4-1t0.4-1 1-0.4h11.5q0.6 0 1 0.4t0.4 1z"></path>
                        </g>
                    </svg>
                </a>
                <a class="link" href="https://cqdg.ca/en.html">
                    Site Web
                    <svg fill="currentColor" preserveAspectRatio="xMidYMid meet" height="1em" width="1em" viewBox="0 0 40 40" class="link__icon">
                        <g>
                            <path d="m31.4 20.7v7.2q0 2.6-1.9 4.5t-4.5 1.9h-18.6q-2.6 0-4.5-1.9t-1.9-4.5v-18.6q0-2.7 1.9-4.6t4.5-1.8h15.7q0.4 0 0.6 0.2t0.2 0.5v1.4q0 0.3-0.2 0.5t-0.6 0.2h-15.7q-1.4 0-2.5 1.1t-1 2.5v18.6q0 1.4 1 2.5t2.5 1h18.6q1.5 0 2.5-1t1.1-2.5v-7.2q0-0.3 0.2-0.5t0.5-0.2h1.4q0.3 0 0.5 0.2t0.2 0.5z m8.6-19.3v11.5q0 0.5-0.4 1t-1 0.4-1-0.4l-4-4-14.5 14.6q-0.2 0.2-0.5 0.2t-0.5-0.2l-2.6-2.6q-0.2-0.2-0.2-0.5t0.2-0.5l14.6-14.5-4-4q-0.4-0.4-0.4-1t0.4-1 1-0.4h11.5q0.6 0 1 0.4t0.4 1z"></path>
                        </g>
                    </svg>
                </a>
            </div>

            <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                <#list locale.supported as l>
                    <#if locale.current != l.label>
                        <div class="header__language-switch">
                            <div class="header__language-switch--link">
                                <a href="${l.url}">${l.label[0..1]}</a>
                            </div>
                        </div>
                    </#if>
                </#list>
            </#if>

            <#--
            <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
                <#if displayRequiredFields>
                    <div class="${properties.kcContentWrapperClass!}">
                        <div class="${properties.kcLabelWrapperClass!} subtitle">
                            <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                        </div>
                        <div class="col-md-10">
                            <h1 id="kc-page-title"><#nested "header"></h1>
                        </div>
                    </div>
                <#else>
                    <h1 id="kc-page-title"><#nested "header"></h1>
                </#if>
            <#else>
                <#if displayRequiredFields>
                    <div class="${properties.kcContentWrapperClass!}">
                        <div class="${properties.kcLabelWrapperClass!} subtitle">
                            <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                        </div>
                        <div class="col-md-10">
                            <#nested "show-username">
                            <div id="kc-username" class="${properties.kcFormGroupClass!}">
                                <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                                <a id="reset-login" href="${url.loginRestartFlowUrl}">
                                    <div class="kc-login-tooltip">
                                        <i class="${properties.kcResetFlowIcon!}"></i>
                                        <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                <#else>
                    <#nested "show-username">
                    <div id="kc-username" class="${properties.kcFormGroupClass!}">
                        <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                        <a id="reset-login" href="${url.loginRestartFlowUrl}">
                            <div class="kc-login-tooltip">
                                <i class="${properties.kcResetFlowIcon!}"></i>
                                <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                            </div>
                        </a>
                    </div>
                </#if>
            </#if>
            -->
        </header>

        <main class="${properties.kcFormCardClass!}">
            <#nested "form">

            <#--
            <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                    <div class="${properties.kcFormGroupClass!}">
                        <input type="hidden" name="tryAnotherWay" value="on"/>
                        <a href="#" id="try-another-way"
                           onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                    </div>
                </form>
            </#if>
            -->
            <#if displayInfo>
                <div id="kc-info" class="${properties.kcSignUpClass!}">
                    <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                        <#nested "info">
                    </div>
                </div>
            </#if>
        </main>

        <footer class="footer">
            <div class="footer__text">
                <h3>Vous ne trouvez pas ce que vous chercher?</h3>
                <p class="footer__info">
                    Pour plus d'informations contactez: <a href="mailto:support@cqdg.ca">support@cqdg.ca</a>
                </p>
            </div>
            <div class="footer__partners">
                <a class=" " href="http://www.genomequebec.com/accueil/" target="_blank">
                    <img alt="Génome Québec" src="${url.resourcesPath}/img/genome_qc_logo_RS_icon.svg">
                </a>
                <a class=" " href="https://recherche.chusj.org/fr/accueil" target="_blank">
                    <img alt="Centre Hospitalier Universitaire Sainte-Justine" src="${url.resourcesPath}/img/chusj_logo_icon.svg">
                </a>
            </div>
        </footer>
    </body>
    </html>
</#macro>