import { memo, useEffect } from "react";
import { assert, getBestMatchAmongKcLanguageTag, KcProps, useKcLanguageTag, useKcMessage } from "keycloakify";
import { KcContext } from "keycloak/kcContext";
import CQDGLogoFull from "assets/CQDGLogoFull";
import SideImageLayout from "layout/SideImage";
import MainSideImage from "assets/side-img-svg.svg";
import GoogleIcon from "assets/GoogleIcon";
import OrcidIcon from "assets/ORCIDIcon";
import { Button, Space, Typography } from "antd";
import cx from "classnames";

import styles from "./index.module.scss";

type KcContext_Login = Extract<KcContext, { pageId: "login.ftl" }>;

const { Title, Text } = Typography;

const LOCALE_PARAM = 'ui_locales';

const Login = memo(
  ({ kcContext, ...props }: { kcContext: KcContext_Login } & KcProps) => {
    const { social, realm, locale } = kcContext;

    const { advancedMsg } = useKcMessage();
    const { kcLanguageTag, setKcLanguageTag } = useKcLanguageTag();

    const localeFromUrl = getBestMatchAmongKcLanguageTag(new URLSearchParams(window.location.search).get(LOCALE_PARAM) || 'en');

    useEffect(() => {
      if(localeFromUrl !== kcLanguageTag) {
        setKcLanguageTag(localeFromUrl);
      }
    // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [setKcLanguageTag]);

    const socialImageMapping: any = {
      google: <GoogleIcon />,
      orcid: <OrcidIcon />,
    };

    const socialProviders = social.providers || [];

    return (
      <SideImageLayout sideImgSrc={MainSideImage} className={styles.loginPage}>
        <div className={styles.loginContainer}>
          <div className={styles.switchLang}>
            {realm.internationalizationEnabled &&
                (assert(locale !== undefined), true) &&
                locale.supported.length > 1 && (
                    <div
                      id="kc-locale-wrapper"
                      className={cx(props.kcLocaleWrapperClass)}
                    >
                      <div className="kc-dropdown" id="kc-locale-dropdown">
                          {locale.supported.map(({ languageTag }) => (
                              <Button
                                id={languageTag}
                                key={languageTag}
                                hidden={languageTag === kcLanguageTag}
                                onClick={() => setKcLanguageTag(languageTag)}
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
                {advancedMsg("login_title")}
              </Title>
              <div
                id="kc-form"
                className={cx(
                  realm.password &&
                    props.kcContentWrapperClass
                )}
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
                        <div className={styles.socialIcon}>
                          {socialImageMapping[p.alias]}
                        </div>
                        <span className="sr-only">{advancedMsg("login_title")}</span>
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
);

export default Login;
