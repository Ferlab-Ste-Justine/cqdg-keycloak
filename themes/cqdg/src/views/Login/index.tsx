import { memo } from "react";
import { assert, KcProps, useKcLanguageTag, useKcMessage } from "keycloakify";
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

const Login = memo(
  ({ kcContext, ...props }: { kcContext: KcContext_Login } & KcProps) => {
    const { social, realm, locale } = kcContext;

    const { msg } = useKcMessage();
    const { kcLanguageTag, setKcLanguageTag } = useKcLanguageTag();

    const socialImageMapping: any = {
      google: <GoogleIcon />,
      orcid: <OrcidIcon />,
    };

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
                {msg("loginTitle")}
              </Title>
              <div
                id="kc-form"
                className={cx(
                  realm.password &&
                    social.providers !== undefined &&
                    props.kcContentWrapperClass
                )}
              >
                {realm.password && social.providers !== undefined && (
                  <Space
                    id="kc-social-providers"
                    className={styles.socialProviders}
                    direction="vertical"
                    size={16}
                  >
                    {social.providers.map((p) => (
                      <a
                        href={p.loginUrl}
                        id={`social-${p.alias}`}
                        className={cx(styles.socialLoginBtn, p.providerId)}
                      >
                        <div className={styles.socialIcon}>
                          {socialImageMapping[p.alias]}
                        </div>
                        <span className="sr-only">{msg("loginTitle")}</span>
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
