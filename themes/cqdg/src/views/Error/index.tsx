import { memo } from "react";
import { KcProps, useKcMessage } from "keycloakify";
import SideImageLayout from "layout/SideImage";
import { KcContext } from "keycloak/kcContext";
import MainSideImage from "assets/side-img-svg.svg";
import { Button, Space, Typography } from "antd";
import ErrorIcon from "assets/ErrorIcon";

import styles from "./index.module.scss";

type KcContext_Error = Extract<KcContext, { pageId: "error.ftl" }>;

const { Title, Text } = Typography;

const ErrorContainer = ({
    redirectUrl,
  }: {
    redirectUrl: string;
  }) => {
    const { advancedMsg } = useKcMessage();

    return (
        <div className={styles.errorContainer}>
              <ErrorIcon className={styles.errorIcon}/>
              <Title level={4}>{advancedMsg("error_title")}</Title>
              <Text className={styles.errorMessage}>{advancedMsg("error_message")}</Text>
              <Space>
                  <Button type="primary" onClick={() =>  window.location.href=redirectUrl}>{advancedMsg("try_again")}</Button>
              </Space>
          </div>
    );
  };

const Error = memo(
  ({ kcContext, ...props }: { kcContext: KcContext_Error } & KcProps) => {

    const { client } = kcContext;

    return (
      <SideImageLayout sideImgSrc={MainSideImage} className={styles.errorPage}>
        <ErrorContainer redirectUrl={client.baseUrl || ""}/>
        
      </SideImageLayout>
    );
  }
);

export {Error, ErrorContainer};
