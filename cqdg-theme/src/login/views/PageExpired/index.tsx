import Text from 'antd/lib/typography/Text';
import Title from 'antd/lib/typography/Title';
import { PageProps } from 'keycloakify/login';
import SideImageLayout from 'layout/SideImage';
import type { I18n } from 'login/keycloak/i18n';
import { KcContext } from 'login/keycloak/kcContext';

import MainSideImage from 'assets/side-img-svg.svg';
import WarningIcon from 'assets/WarningIcon';

import styles from './index.module.scss';

const PageExpired = (
  props: PageProps<Extract<KcContext, { pageId: 'login-page-expired.ftl' }>, I18n>,
) => {
  const { kcContext, i18n } = props;
  const { url } = kcContext;
  const { advancedMsgStr } = i18n;

  return (
    <SideImageLayout sideImgSrc={MainSideImage}>
      <div className={styles.expiryContainer}>
        <WarningIcon className={styles.icon} />
        <Title className={styles.title} level={4}>
          {advancedMsgStr('pageExpiredTitle')}
        </Title>
        <div className={styles.message}>
          <Text>{advancedMsgStr('pageExpiredMsg1')}</Text>
          <a id="loginRestartLink" href={url.loginRestartFlowUrl}>
            {advancedMsgStr('doClickHere')}
          </a>
        </div>
        <div className={styles.message}>
          <Text>{advancedMsgStr('pageExpiredMsg2')}</Text>
          <a id="loginContinueLink" href={url.loginAction}>
            {advancedMsgStr('doClickHere')}
          </a>
        </div>
      </div>
    </SideImageLayout>
  );
};

export default PageExpired;
