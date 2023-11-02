import { Input, Space } from 'antd';
import { PageProps } from 'keycloakify/login';
import SideImageLayout from 'layout/SideImage';
import type { I18n } from 'login/keycloak/i18n';
import { KcContext } from 'login/keycloak/kcContext';

import MainSideImage from 'assets/side-img-svg.svg';

import styles from './index.module.scss';

const DeviceGrant = (
  props: PageProps<Extract<KcContext, { pageId: 'login-oauth-grant.ftl' }>, I18n>,
) => {
  const { kcContext, i18n } = props;
  const { oauth, url } = kcContext;
  const { advancedMsgStr } = i18n;

  return (
    <SideImageLayout sideImgSrc={MainSideImage}>
      <div className={styles.grantPage}>
        <h3>{advancedMsgStr('oauthGrantRequest')}</h3>
        <ul>
          {oauth.clientScopesRequested.map((clientScope) => (
            <li key={clientScope.consentScreenText}>
              <span>{advancedMsgStr(clientScope.consentScreenText)}</span>
            </li>
          ))}
        </ul>

        <form className={styles.userGrantForm} action={(url as any).oauthAction} method="POST">
          <Input type="hidden" name="code" value={oauth.code} />
          <div>
            <div id="kc-form-buttons">
              <Space>
                <Input
                  name="accept"
                  id="kc-login"
                  type="submit"
                  value={advancedMsgStr('doYes')}
                  className={styles.primary}
                />
                <Input name="cancel" id="kc-cancel" type="submit" value={advancedMsgStr('doNo')} />
              </Space>
            </div>
          </div>
        </form>
      </div>
    </SideImageLayout>
  );
};

export default DeviceGrant;
