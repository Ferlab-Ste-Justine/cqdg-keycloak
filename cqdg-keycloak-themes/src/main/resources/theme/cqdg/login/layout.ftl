<#macro layout bodyClass="">
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
        <script src="https://apis.google.com/js/platform.js" async defer></script>
    </head>

    <body class="${properties.kcBodyClass!}">
        <div class="wrapper">
            <header class="header">
                <div class="header__logo">
                    <a href="${properties.home_link}">
                        <img src="${url.resourcesPath}/img/logo.svg">
                    </a>
                </div>
                <div class="header__nav">
                </div>
                <div class="header__actions">
                    <div class="ant-divider ant-divider-vertical separator" role="separator"></div>
                    <a href="https://docs.qa.cqdg.ferlab.bio/" target="_blank" class="ant-btn ant-btn-link link">
                        Documentation
                        <svg class="link--icon" fill="currentColor" height="10" viewBox="0 0 10 10" width="10" xmlns="http://www.w3.org/2000/svg">
                            <path clip-rule="evenodd" d="M1.5 1.5V8.5H8.5V5H9.5V8.5C9.5 9.05 9.05 9.5 8.5 9.5H1.5C0.945 9.5 0.5 9.05 0.5 8.5V1.5C0.5 0.95 0.945 0.5 1.5 0.5H5V1.5H1.5ZM6 1.5V0.5H9.5V4H8.5V2.205L3.585 7.12L2.88 6.415L7.795 1.5H6Z" fill-rule="evenodd"></path>
                        </svg>
                    </a>
                    <a href="https://cqdg.ca/en.html" target="_blank" class="ant-btn ant-btn-link link">
                        Site Web
                        <svg class="link--icon" fill="currentColor" height="10" viewBox="0 0 10 10" width="10" xmlns="http://www.w3.org/2000/svg">
                            <path clip-rule="evenodd" d="M1.5 1.5V8.5H8.5V5H9.5V8.5C9.5 9.05 9.05 9.5 8.5 9.5H1.5C0.945 9.5 0.5 9.05 0.5 8.5V1.5C0.5 0.95 0.945 0.5 1.5 0.5H5V1.5H1.5ZM6 1.5V0.5H9.5V4H8.5V2.205L3.585 7.12L2.88 6.415L7.795 1.5H6Z" fill-rule="evenodd"></path>
                        </svg>
                    </a>
                    <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                        <#list locale.supported as l>
                            <#if locale.current != l.label>
                                <a href="${l.url}"><button class="ant-btn ant-btn-circle locale"><span>${l.label[0..1]}</span></button></a>
                            </#if>
                        </#list>
                    </#if>
                </div>
            </header>
            <main class="main-content">
                <#nested>
            </main>
            <footer class="footer">
                <div class="footer__wrapper">
                    <div class="footer__wrapper__text">
                        <h3 class="title">Vous ne trouvez pas ce que vous chercher?</h3>
                        <p class="more-info">
                            Pour plus d'informations contactez: <a href="mailto:support@cqdg.ca" class="ant-btn ant-btn-link"><span>support@cqdg.ca</span></a>
                        </p>
                    </div>
                    <div class="footer__wrapper__logos">
                        <a href="http://www.genomequebec.com/accueil/" target="_blank" class="ant-btn ant-btn-link">
                            <img alt="genome" src="${url.resourcesPath}/img/genome_qc_logo_RS_icon.svg">
                        </a>
                        <a href="https://recherche.chusj.org/fr/accueil" target="_blank" class="ant-btn ant-btn-link">
                            <img alt="chusj" src="${url.resourcesPath}/img/chusj_logo_icon.svg">
                        </a>
                    </div>
                </div>
            </footer>
        </div>
    </body>
    </html>
</#macro>