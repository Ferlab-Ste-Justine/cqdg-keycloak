import { lazy, StrictMode, Suspense } from 'react';
import { createRoot } from 'react-dom/client';
import { Provider as ReduxProvider } from 'react-redux';

import { getStore } from 'store';

import { kcContext as kcLoginThemeContext } from './login/keycloak/kcContext';

import 'style/themes/cqdg/dist/antd.css';
import 'style/themes/cqdg/main.scss';
import './index.scss';

const KcLoginThemeApp = lazy(() => import('login/keycloak/KcApp'));

const store = getStore();

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <Suspense>
      {(() => {
        if (kcLoginThemeContext !== undefined) {
          return (
            <ReduxProvider store={store}>
              <KcLoginThemeApp kcContext={kcLoginThemeContext} />
            </ReduxProvider>
          );
        }

        throw new Error(
          'This app is a Keycloak theme' + "It isn't meant to be deployed outside of Keycloak",
        );
      })()}
    </Suspense>
  </StrictMode>,
);
