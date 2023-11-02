import { lazy, Suspense } from 'react';
import Fallback from 'keycloakify/login';
import DeviceGrant from 'login/views/Device/Grant';
import DeviceUserCode from 'login/views/Device/UserCode';
import { Error } from 'login/views/Error';
import { Info } from 'login/views/Info';
import Login from 'login/views/Login';
import PageExpired from 'login/views/PageExpired';
import Registration from 'login/views/Registration';

import { useI18n } from './i18n';
import type { KcContext } from './kcContext';

const DefaultTemplate = lazy(() => import('keycloakify/login/Template'));

export default function App(props: { kcContext: KcContext }) {
  const { kcContext } = props;

  const i18n = useI18n({ kcContext });

  if (i18n === null) {
    return null;
  }

  return (
    <Suspense fallback={null}>
      {(() => {
        switch (kcContext.pageId) {
          case 'login.ftl':
            return (
              <Login {...{ kcContext, i18n }} Template={DefaultTemplate} doUseDefaultCss={true} />
            );
          case 'login-update-profile.ftl':
            return (
              <Registration
                {...{ kcContext, i18n }}
                Template={DefaultTemplate}
                doUseDefaultCss={true}
              />
            );
          case 'error.ftl':
            return (
              <Error {...{ kcContext, i18n }} Template={DefaultTemplate} doUseDefaultCss={true} />
            );
          case 'info.ftl':
            return (
              <Info {...{ kcContext, i18n }} Template={DefaultTemplate} doUseDefaultCss={true} />
            );
          case 'login-oauth2-device-verify-user-code.ftl':
            return (
              <DeviceUserCode
                {...{ kcContext, i18n }}
                Template={DefaultTemplate}
                doUseDefaultCss={true}
              />
            );
          case 'login-oauth-grant.ftl':
            return (
              <DeviceGrant
                {...{ kcContext, i18n }}
                Template={DefaultTemplate}
                doUseDefaultCss={true}
              />
            );
          case 'login-page-expired.ftl':
            return (
              <PageExpired
                {...{ kcContext, i18n }}
                Template={DefaultTemplate}
                doUseDefaultCss={true}
              />
            );
          default:
            return (
              <Fallback
                {...{ kcContext, i18n }}
                Template={DefaultTemplate}
                doUseDefaultCss={true}
              />
            );
        }
      })()}
    </Suspense>
  );
}
