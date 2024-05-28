import { ArrowRightOutlined } from '@ant-design/icons';
import { Button, Col, Input, Row, Space } from 'antd';
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
        <ul className={styles.scopeListContainer}>
          {oauth.clientScopesRequested.map((clientScope) => (
            <li key={clientScope.consentScreenText}>
              <span>{advancedMsgStr(clientScope.consentScreenText)}</span>
            </li>
          ))}
        </ul>

        <form action={(url as any).oauthAction} method="POST">
          <Input type="hidden" name="code" value={oauth.code} />
          <div>
            <div id="kc-form-buttons">
              <Space className={styles.spaceContainer}>
                <Button
                  id="kc-cancel"
                  name="cancel"
                  htmlType="submit"
                  value={advancedMsgStr('doNo')}
                >
                  {advancedMsgStr('cancel')}
                </Button>
                <Button
                  id="kc-login"
                  name="accept"
                  htmlType="submit"
                  type="primary"
                  value={advancedMsgStr('doYes')}
                >
                  <Row justify="end" gutter={8}>
                    <Col>{advancedMsgStr('next')}</Col>
                    <Col>
                      <ArrowRightOutlined />
                    </Col>
                  </Row>
                </Button>
              </Space>
            </div>
          </div>
        </form>
      </div>
    </SideImageLayout>
  );
};

export default DeviceGrant;
