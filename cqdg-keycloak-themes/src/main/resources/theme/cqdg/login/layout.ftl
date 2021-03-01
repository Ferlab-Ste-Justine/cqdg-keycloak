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
                    <a href="/">
                    <img src="${url.resourcesPath}/img/logo.svg">
                    </a>
                </div>
                <div class="header__nav">
                </div>
                <div class="header__actions">
                    <a href="http://localhost:3000/login">
                        <button type="button" class="ant-btn ant-btn-text">
                            <svg stroke="currentColor" fill="currentColor" stroke-width="0" viewBox="0 0 1024 1024" class="icon" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg">
                            <defs></defs>
                            <path d="M521.7 82c-152.5-.4-286.7 78.5-363.4 197.7-3.4 5.3.4 12.3 6.7 12.3h70.3c4.8 0 9.3-2.1 12.3-5.8 7-8.5 14.5-16.7 22.4-24.5 32.6-32.5 70.5-58.1 112.7-75.9 43.6-18.4 90-27.8 137.9-27.8 47.9 0 94.3 9.3 137.9 27.8 42.2 17.8 80.1 43.4 112.7 75.9 32.6 32.5 58.1 70.4 76 112.5C865.7 417.8 875 464.1 875 512c0 47.9-9.4 94.2-27.8 137.8-17.8 42.1-43.4 80-76 112.5s-70.5 58.1-112.7 75.9A352.8 352.8 0 0 1 520.6 866c-47.9 0-94.3-9.4-137.9-27.8A353.84 353.84 0 0 1 270 762.3c-7.9-7.9-15.3-16.1-22.4-24.5-3-3.7-7.6-5.8-12.3-5.8H165c-6.3 0-10.2 7-6.7 12.3C234.9 863.2 368.5 942 520.6 942c236.2 0 428-190.1 430.4-425.6C953.4 277.1 761.3 82.6 521.7 82zM395.02 624v-76h-314c-4.4 0-8-3.6-8-8v-56c0-4.4 3.6-8 8-8h314v-76c0-6.7 7.8-10.5 13-6.3l141.9 112a8 8 0 0 1 0 12.6l-141.9 112c-5.2 4.1-13 .4-13-6.3z"></path>
                            </svg>
                            Connexion
                        </button>
                    </a>
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