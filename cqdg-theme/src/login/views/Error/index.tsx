import { Button, Space, Typography } from 'antd';
import { PageProps } from 'keycloakify/login';
import SideImageLayout from 'layout/SideImage';
import { I18n } from 'login/keycloak/i18n';
import { KcContext } from 'login/keycloak/kcContext';

import ErrorIcon from 'assets/ErrorIcon';
import MainSideImage from 'assets/side-img-svg.svg';

import styles from './index.module.scss';

const { Title, Text } = Typography;

const OAUTH2_DEVICE_AUTHORIZATION_GRANT_DISABLED = 'OAUTH2_DEVICE_AUTHORIZATION_GRANT_DISABLED';

const ErrorContainer = ({
  redirectUrl,
  advancedMsg,
}: {
  redirectUrl: string;
  advancedMsg: any;
}) => (
  <div className={styles.errorContainer}>
    <ErrorIcon className={styles.errorIcon} />
    <Title level={4}>{advancedMsg('error_title')}</Title>
    <Text className={styles.errorMessage}>{advancedMsg('error_message')}</Text>
    <Space>
      <Button type="primary" onClick={() => (window.location.href = redirectUrl)}>
        {advancedMsg('try_again')}
      </Button>
    </Space>
  </div>
);

const Error = (props: PageProps<Extract<KcContext, { pageId: 'error.ftl' }>, I18n>) => {
  const { kcContext, i18n } = props;
  const { client, message } = kcContext;
  const { advancedMsgStr } = i18n;

  if (message && advancedMsgStr(message?.summary) === OAUTH2_DEVICE_AUTHORIZATION_GRANT_DISABLED) {
    return (
      <SideImageLayout sideImgSrc={MainSideImage}>
        <div className={styles.infoContainer}>
          <ErrorIcon className={styles.icon} />
          <Title level={4}>{advancedMsgStr('device_flow_disabled_title')}</Title>
          <Text>{advancedMsgStr('device_flow_disabled_message')}</Text>
          <Text>[Support info TBD]</Text>
        </div>
      </SideImageLayout>
    );
  }

  return (
    <SideImageLayout sideImgSrc={MainSideImage} className={styles.errorPage}>
      <ErrorContainer redirectUrl={client.baseUrl || ''} advancedMsg={advancedMsgStr} />
    </SideImageLayout>
  );
};

export { Error, ErrorContainer };
