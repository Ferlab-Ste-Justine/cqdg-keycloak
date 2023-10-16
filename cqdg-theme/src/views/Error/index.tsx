import { Button, Space, Typography } from 'antd';
import { I18n } from 'keycloak/i18n';
import { KcContext } from 'keycloak/kcContext';
import { PageProps } from 'keycloakify/login';
import SideImageLayout from 'layout/SideImage';

import ErrorIcon from 'assets/ErrorIcon';
import MainSideImage from 'assets/side-img-svg.svg';

import styles from './index.module.scss';

const { Title, Text } = Typography;

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
  const { client } = kcContext;
  const { advancedMsgStr } = i18n;

  return (
    <SideImageLayout sideImgSrc={MainSideImage} className={styles.errorPage}>
      <ErrorContainer redirectUrl={client.baseUrl || ''} advancedMsg={advancedMsgStr} />
    </SideImageLayout>
  );
};

export { Error, ErrorContainer };
