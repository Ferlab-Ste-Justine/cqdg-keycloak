import { useEffect } from 'react';
import { Button, Space, Typography } from 'antd';
import cx from 'classnames';
import { PageProps } from 'keycloakify/login';
import { useGetClassName } from 'keycloakify/login/lib/useGetClassName';
import { assert } from 'keycloakify/tools/assert';
import SideImageLayout from 'layout/SideImage';
import type { I18n } from 'login/keycloak/i18n';
import { KcContext } from 'login/keycloak/kcContext';

import CiLogonIcon from 'assets/CiLogonIcon';
import CQDGLogoFull from 'assets/CQDGLogoFull';
import GoogleIcon from 'assets/GoogleIcon';
import MicrosoftIcon from 'assets/MicrosoftIcon';
import OrcidIcon from 'assets/ORCIDIcon';
import MainSideImage from 'assets/side-img-svg.svg';

import styles from './index.module.scss';

const { Title, Text } = Typography;

export default function Login(props: PageProps<Extract<KcContext, { pageId: 'login.ftl' }>, I18n>) {
  const { kcContext, i18n, doUseDefaultCss, classes } = props;

  const { getClassName } = useGetClassName({
    doUseDefaultCss,
    classes,
  });

  const { realm, locale, social } = kcContext;

  const { currentLanguageTag, changeLocale, advancedMsg } = i18n;

  const socialImageMapping: any = {
    google: <GoogleIcon />,
    orcid: <OrcidIcon />,
    microsoft: <MicrosoftIcon />,
    cilogon: <CiLogonIcon />,
  };

  const socialProviders = social.providers || [];

  //CQDG-480 replace url params 'ui_locales' to 'kc_locale'
  useEffect(() => {
    const uiLocales = new URLSearchParams(window.location.search).get('ui_locales');
    const isSupported = locale?.supported.find(({ languageTag }) => languageTag === uiLocales);
    if (uiLocales && isSupported) {
      changeLocale(uiLocales);
    }
  }, [changeLocale, locale?.supported]);

  return (
    <SideImageLayout sideImgSrc={MainSideImage} className={styles.loginPage}>
      <div className={styles.loginContainer}>
        <div className={styles.switchLang}>
          {realm.internationalizationEnabled &&
            (assert(locale !== undefined), true) &&
            locale.supported.length > 1 && (
              <div id="kc-locale-wrapper" className={getClassName('kcLocaleWrapperClass')}>
                <div className="kc-dropdown" id="kc-locale-dropdown">
                  {locale.supported.map(({ languageTag }) => (
                    <Button
                      id={languageTag}
                      key={languageTag}
                      hidden={languageTag === currentLanguageTag}
                      onClick={() => {
                        changeLocale(languageTag);
                      }}
                      type="primary"
                    >
                      {languageTag.toUpperCase()}
                    </Button>
                  ))}
                </div>
              </div>
            )}
        </div>
        <div className={styles.loginCard}>
          <div className={styles.logoContainer}>
            <CQDGLogoFull className={styles.logo} />
          </div>
          <div className={styles.loginFormContent}>
            <Title level={4} className={styles.loginTitle}>
              {advancedMsg('login_title')}
            </Title>
            <div
              id="kc-form"
              className={cx(realm.password && getClassName('kcLocaleWrapperClass'))}
            >
              {realm.password && (
                <Space
                  id="kc-social-providers"
                  className={styles.socialProviders}
                  direction="vertical"
                  size={16}
                >
                  {socialProviders.map((p) => (
                    <a
                      href={p.loginUrl}
                      id={`social-${p.alias}`}
                      className={cx(styles.socialLoginBtn, p.providerId)}
                      key={p.providerId}
                    >
                      <div className={styles.socialIcon}>{socialImageMapping[p.alias]}</div>
                      <span className="sr-only">{advancedMsg('login_title')}</span>
                      <Text>{p.displayName}</Text>
                    </a>
                  ))}
                </Space>
              )}
            </div>
          </div>
        </div>
      </div>
    </SideImageLayout>
  );
}
