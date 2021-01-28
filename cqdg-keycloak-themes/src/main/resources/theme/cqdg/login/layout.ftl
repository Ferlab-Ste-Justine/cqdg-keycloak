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
        <header class="header">
            <div class="header__logo">
                <a href="/">
                <img src="${url.resourcesPath}/img/logo.svg">
                </a>
            </div>
            <div class="header__nav">
                <a href="/files">
                    <button type="button" class="ant-btn menu-item ">
                        <svg class="menu-item-icon" fill="currentColor" height="18" viewBox="0 0 18 18" width="18" xmlns="http://www.w3.org/2000/svg">
                        <path clip-rule="evenodd" d="M8.71875 16.0312V14.3438H9.28125V16.0312H8.71875Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M9 16.3125C8.68934 16.3125 8.4375 16.5643 8.4375 16.875C8.4375 17.1857 8.68934 17.4375 9 17.4375C9.31066 17.4375 9.5625 17.1857 9.5625 16.875C9.5625 16.5643 9.31066 16.3125 9 16.3125ZM7.875 16.875C7.875 16.2537 8.37868 15.75 9 15.75C9.62132 15.75 10.125 16.2537 10.125 16.875C10.125 17.4963 9.62132 18 9 18C8.37868 18 7.875 17.4963 7.875 16.875Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M0 16.5938H8.15625V17.1562H0V16.5938Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M9.84375 16.5938H18V17.1562H9.84375V16.5938Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M3.20387 1.71197C2.9049 1.92709 2.8125 2.11267 2.8125 2.25C2.8125 2.38733 2.9049 2.57291 3.20387 2.78803C3.49619 2.99838 3.93734 3.19944 4.50779 3.37305C5.64519 3.71922 7.23349 3.9375 9 3.9375C10.7665 3.9375 12.3548 3.71922 13.4922 3.37305C14.0627 3.19944 14.5038 2.99838 14.7961 2.78803C15.0951 2.57291 15.1875 2.38733 15.1875 2.25C15.1875 2.11267 15.0951 1.92709 14.7961 1.71197C14.5038 1.50162 14.0627 1.30056 13.4922 1.12695C12.3548 0.780784 10.7665 0.5625 9 0.5625C7.23349 0.5625 5.64519 0.780784 4.50779 1.12695C3.93734 1.30056 3.49619 1.50162 3.20387 1.71197ZM4.34401 0.588819C5.54784 0.222436 7.19392 0 9 0C10.8061 0 12.4522 0.222436 13.656 0.588819C14.2562 0.771478 14.7623 0.994649 15.1247 1.25538C15.4804 1.51134 15.75 1.84367 15.75 2.25C15.75 2.65633 15.4804 2.98866 15.1247 3.24462C14.7623 3.50535 14.2562 3.72852 13.656 3.91118C12.4522 4.27756 10.8061 4.5 9 4.5C7.19392 4.5 5.54784 4.27756 4.34401 3.91118C3.74385 3.72852 3.23768 3.50535 2.87533 3.24462C2.51962 2.98866 2.25 2.65633 2.25 2.25C2.25 1.84367 2.51962 1.51134 2.87533 1.25538C3.23768 0.994649 3.74385 0.771478 4.34401 0.588819Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M2.8125 3.65625V5.625C2.8125 5.76233 2.9049 5.94792 3.20385 6.16304C3.49616 6.37338 3.9373 6.57444 4.50775 6.74805C5.64513 7.09422 7.23343 7.3125 9 7.3125C10.7666 7.3125 12.3549 7.09422 13.4923 6.74805C14.0627 6.57444 14.5038 6.37338 14.7961 6.16304C15.0951 5.94792 15.1875 5.76233 15.1875 5.625V3.65625H15.75V5.625C15.75 6.03132 15.4804 6.36366 15.1247 6.61962C14.7624 6.88035 14.2562 7.10352 13.656 7.28618C12.4522 7.65256 10.8061 7.875 9 7.875C7.19385 7.875 5.54778 7.65256 4.34397 7.28618C3.74381 7.10352 3.23765 6.88035 2.87531 6.61962C2.5196 6.36366 2.25 6.03132 2.25 5.625V3.65625H2.8125Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M2.8125 7.03125V9C2.8125 9.13733 2.9049 9.32292 3.20385 9.53804C3.49616 9.74838 3.9373 9.94944 4.50775 10.1231C5.64513 10.4692 7.23343 10.6875 9 10.6875C10.7666 10.6875 12.3549 10.4692 13.4923 10.1231C14.0627 9.94944 14.5038 9.74838 14.7961 9.53804C15.0951 9.32292 15.1875 9.13733 15.1875 9V7.03125H15.75V9C15.75 9.40632 15.4804 9.73866 15.1247 9.99462C14.7624 10.2554 14.2562 10.4785 13.656 10.6612C12.4522 11.0276 10.8061 11.25 9 11.25C7.19385 11.25 5.54778 11.0276 4.34397 10.6612C3.74381 10.4785 3.23765 10.2554 2.87531 9.99462C2.5196 9.73866 2.25 9.40632 2.25 9V7.03125H2.8125Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M2.8125 10.4062V12.375C2.8125 12.5123 2.9049 12.6979 3.20385 12.913C3.49616 13.1234 3.9373 13.3244 4.50775 13.4981C5.64513 13.8442 7.23343 14.0625 9 14.0625C10.7666 14.0625 12.3549 13.8442 13.4923 13.4981C14.0627 13.3244 14.5038 13.1234 14.7961 12.913C15.0951 12.6979 15.1875 12.5123 15.1875 12.375V10.4062H15.75V12.375C15.75 12.7813 15.4804 13.1137 15.1247 13.3696C14.7624 13.6304 14.2562 13.8535 13.656 14.0362C12.4522 14.4026 10.8061 14.625 9 14.625C7.19385 14.625 5.54778 14.4026 4.34397 14.0362C3.74381 13.8535 3.23765 13.6304 2.87531 13.3696C2.5196 13.1137 2.25 12.7813 2.25 12.375V10.4062H2.8125Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M9.28125 12.9375H8.71875V12.375H9.28125V12.9375Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M8.15625 12.9375H7.59375V12.375H8.15625V12.9375Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M10.4062 12.9375H9.84375V12.375H10.4062V12.9375Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M9.28125 9.5625H8.71875V9H9.28125V9.5625Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M8.15625 9.5625H7.59375V9H8.15625V9.5625Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M10.4062 9.5625H9.84375V9H10.4062V9.5625Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M9.28125 6.1875H8.71875V5.625H9.28125V6.1875Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M8.15625 6.1875H7.59375V5.625H8.15625V6.1875Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M10.4062 6.1875H9.84375V5.625H10.4062V6.1875Z" fill-rule="evenodd"></path>
                        </svg>
                        Répertoire de fichiers
                    </button>
                </a>
                <a href="/studies">
                    <button type="button" class="ant-btn menu-item ">
                        <svg class="menu-item-icon" fill="currentColor" height="18" viewBox="0 0 18 18" width="18" xmlns="http://www.w3.org/2000/svg">
                        <path clip-rule="evenodd" d="M0 10.4062C0 10.2509 0.12592 10.125 0.28125 10.125H17.7188C17.8741 10.125 18 10.2509 18 10.4062V17.7188C18 17.8741 17.8741 18 17.7188 18H0.28125C0.12592 18 0 17.8741 0 17.7188V10.4062ZM0.5625 10.6875V17.4375H17.4375V10.6875H0.5625Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M15.822 5.0625H15.4688V4.5H16.2405L17.9881 10.3254L17.4494 10.4871L15.822 5.0625Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M1.75935 4.5H2.53111V5.0625H2.17787L0.550496 10.4871L0.0117188 10.3254L1.75935 4.5Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M8.35234 0H14.3438V3.9375H13.7812V0.5625H8.52266L6.83516 1.6875H4.21875V3.9375H3.65625V1.125H6.66484L8.35234 0Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M3.09375 4.5H14.9062V5.90625H14.3438V5.0625H3.65625V5.90625H3.09375V4.5Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M2.53125 6.46875H15.4688V7.59375H14.9062V7.03125H3.09375V7.59375H2.53125V6.46875Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M1.96875 8.15625H16.0312V9.5625H15.4688V8.71875H2.53125V9.5625H1.96875V8.15625Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M4.78125 12.6562H13.2188V14.3438C13.2188 14.9648 12.7152 15.4688 12.0938 15.4688H5.90625C5.28523 15.4688 4.78125 14.9652 4.78125 14.3438V12.6562ZM5.34375 13.2188V14.3438C5.34375 14.6544 5.59577 14.9062 5.90625 14.9062H12.0938C12.4044 14.9062 12.6562 14.6542 12.6562 14.3438V13.2188H5.34375Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M3.09375 13.7812H3.65625V14.3438H3.09375V13.7812Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M14.3438 13.7812H14.9062V14.3438H14.3438V13.7812Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M11.5312 14.3438H6.46875V13.7812H11.5312V14.3438Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M13.2188 2.25H10.4062V1.6875H13.2188V2.25Z" fill-rule="evenodd"></path>
                        <path clip-rule="evenodd" d="M13.2188 3.375H4.78125V2.8125H13.2188V3.375Z" fill-rule="evenodd"></path>
                        </svg>
                        Études
                    </button>
                </a>
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
    </body>
    </html>
</#macro>