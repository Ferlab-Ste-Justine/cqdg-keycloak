import { lazy, Suspense } from 'react';
import Fallback from 'keycloakify/login';
import { Error } from 'views/Error';
import Login from 'views/Login';
import Registration from 'views/Registration';

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
