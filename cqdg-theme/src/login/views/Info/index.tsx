import Text from 'antd/lib/typography/Text';
import Title from 'antd/lib/typography/Title';
import { PageProps } from 'keycloakify/login';
import SideImageLayout from 'layout/SideImage';
import { I18n } from 'login/keycloak/i18n';
import { KcContext } from 'login/keycloak/kcContext';

import ErrorIcon from 'assets/ErrorIcon';
import InfoIcon from 'assets/InfoIcon';
import MainSideImage from 'assets/side-img-svg.svg';
import SuccessIcon from 'assets/SuccessIcon';
import WarningIcon from 'assets/WarningIcon';

import styles from './index.module.scss';

const OAUTH2_DEVICE_EXPIRED_USER_CODE = 'OAUTH2_DEVICE_EXPIRED_USER_CODE';
const ALREADY_LOGGED_IN = 'ALREADY_LOGGED_IN';
const OAUTH2_DEVICE_VERIFICATION_COMPLETE = 'OAUTH2_DEVICE_VERIFICATION_COMPLETE';
const OAUTH2_DEVICE_VERIFICATION_FAILED = 'OAUTH2_DEVICE_VERIFICATION_FAILED';
const OAUTH2_DEVICE_CONSENT_DENIED = 'OAUTH2_DEVICE_CONSENT_DENIED';

const Info = (props: PageProps<Extract<KcContext, { pageId: 'info.ftl' }>, I18n>) => {
  const { kcContext, i18n } = props;
  const { message, messageHeader } = kcContext;
  const { advancedMsgStr } = i18n;

  const messageSummary = message ? message.summary : '';

  switch (messageSummary) {
    case OAUTH2_DEVICE_VERIFICATION_FAILED:
      return (
        <InfoContainer
          iconType="error"
          title={advancedMsgStr('device_flow_error_title')}
          message={advancedMsgStr('device_flow_error_message')}
        />
      );

    case OAUTH2_DEVICE_EXPIRED_USER_CODE:
      return (
        <InfoContainer
          iconType="error"
          title={advancedMsgStr('device_flow_code_expired_title')}
          message={advancedMsgStr('device_flow_code_expired_message')}
        />
      );

    case OAUTH2_DEVICE_CONSENT_DENIED:
      return (
        <InfoContainer
          iconType="warning"
          title={advancedMsgStr('device_flow_consent_denied_title')}
          message={advancedMsgStr('device_flow_consent_denied_message')}
        />
      );

    case ALREADY_LOGGED_IN:
      return (
        <InfoContainer
          iconType="info"
          title={advancedMsgStr('already_logged_in_title')}
          message={advancedMsgStr('already_logged_in_message')}
        />
      );

    case OAUTH2_DEVICE_VERIFICATION_COMPLETE:
      return (
        <InfoContainer
          iconType="success"
          title={advancedMsgStr('device_flow_success_title')}
          message={advancedMsgStr('device_flow_success_message_1')}
          optionalSecondMessage={advancedMsgStr('device_flow_success_message_2')}
        />
      );

    default:
      return (
        <InfoContainer
          iconType={message?.type ?? 'info'}
          title={messageHeader && advancedMsgStr(messageHeader)}
          message={message && advancedMsgStr(message?.summary)}
        />
      );
  }
};

type TInfoContainer = {
  title?: string;
  message?: string;
  iconType: 'success' | 'warning' | 'error' | 'info';
  optionalSecondMessage?: string;
};

const InfoContainer = ({
  title,
  message,
  iconType,
  optionalSecondMessage,
}: TInfoContainer): JSX.Element => (
  <SideImageLayout sideImgSrc={MainSideImage}>
    <div className={styles.infoContainer}>
      {iconType === 'success' && <SuccessIcon className={styles.icon} />}
      {iconType === 'info' && <InfoIcon className={styles.icon} />}
      {iconType === 'warning' && <WarningIcon className={styles.icon} />}
      {iconType === 'error' && <ErrorIcon className={styles.icon} />}
      {title && <Title level={4}>{title}</Title>}
      {message && <Text>{message}</Text>}
      {optionalSecondMessage && <Text>{optionalSecondMessage}</Text>}
    </div>
  </SideImageLayout>
);

export { Info };
