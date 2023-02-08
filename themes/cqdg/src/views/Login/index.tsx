import { memo } from "react";
import type { KcProps } from "keycloakify";
import { KcContext } from "keycloak/kcContext";
import IncludeLogo from "assets/IncludeLogo";
import SideImageLayout from "layout/SideImage";
import MainSideImage from "assets/mainSideImage.jpg";
import GoogleIcon from "assets/GoogleIcon";
import OrcidIcon from "assets/ORCIDIcon";
import { Space, Typography } from "antd";
import cx from "classnames";

import styles from "./index.module.scss";

type KcContext_Login = Extract<KcContext, { pageId: "login.ftl" }>;

const { Title, Text } = Typography;

const Login = memo(
  ({ kcContext, ...props }: { kcContext: KcContext_Login } & KcProps) => {
    const { social, realm } = kcContext;

    const socialImageMapping: any = {
      google: <GoogleIcon />,
      orcid: <OrcidIcon />,
    };

    return (
      <SideImageLayout sideImgSrc={MainSideImage} className={styles.loginPage}>
        <div className={styles.loginCard}>
          <div className={styles.logoContainer}>
            <a href="https://portal.includedcc.org">
              <IncludeLogo />
            </a>
          </div>
          <a href="https://portal.includedcc.org">
            <Title level={5} className={styles.realm}>
              INCLUDE DCC
            </Title>
          </a>
          <div className={styles.loginFormContent}>
            <Title level={3} className={styles.loginTitle}>
              Log in with
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
                      <span className="sr-only">Log in with</span>
                      <Text>{p.displayName}</Text>
                    </a>
                  ))}
                </Space>
              )}
            </div>
          </div>
        </div>
      </SideImageLayout>
    );
  }
);

export default Login;
