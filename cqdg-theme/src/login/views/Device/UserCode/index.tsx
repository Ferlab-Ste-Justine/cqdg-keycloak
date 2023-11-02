import { useState } from 'react';
import { Alert, Button, Form, Input, Space } from 'antd';
import { PageProps } from 'keycloakify/login';
import SideImageLayout from 'layout/SideImage';
import type { I18n } from 'login/keycloak/i18n';
import { KcContext } from 'login/keycloak/kcContext';

import MainSideImage from 'assets/side-img-svg.svg';

import styles from './index.module.scss';

const DeviceUserCode = (
  props: PageProps<
    Extract<KcContext, { pageId: 'login-oauth2-device-verify-user-code.ftl' }>,
    I18n
  >,
) => {
  const { kcContext, i18n } = props;
  const { url, message } = kcContext;
  const { advancedMsgStr } = i18n;
  const [form] = Form.useForm();
  const [isLoginButtonDisabled, setIsLoginButtonDisabled] = useState(false);

  const onFinish = () => {
    setIsLoginButtonDisabled(true);

    const formElement = document.getElementById(
      'kc-user-verify-device-user-code-form',
    ) as HTMLFormElement;

    formElement.submit();
  };

  return (
    <SideImageLayout sideImgSrc={MainSideImage}>
      <div className={styles.userCodePage}>
        {message && <Alert type={message.type} message={message.summary}></Alert>}
        <Form
          id="kc-user-verify-device-user-code-form"
          name="kc-user-verify-device-user-code-form"
          className={styles.userCodeForm}
          layout="vertical"
          onFinish={onFinish}
          action={(url as any).oauth2DeviceVerificationAction}
          method="post"
          form={form}
        >
          <Form.Item label={advancedMsgStr('verifyOAuth2DeviceUserCode')}>
            <Input id="device_user_code" name="device_user_code" tabIndex={1} />
          </Form.Item>
          <Space size={'middle'}>
            <Button type="primary" htmlType="submit" disabled={isLoginButtonDisabled}>
              {advancedMsgStr('submit')}
            </Button>
          </Space>
        </Form>
      </div>
    </SideImageLayout>
  );
};

export default DeviceUserCode;
