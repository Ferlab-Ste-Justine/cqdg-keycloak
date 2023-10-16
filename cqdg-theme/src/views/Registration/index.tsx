import ScrollContent from '@ferlab/ui/core/layout/ScrollContent';
import { I18n } from 'keycloak/i18n';
import { KcContext } from 'keycloak/kcContext';
import { PageProps } from 'keycloakify/login';
import SideImageLayout from 'layout/SideImage';
import { ErrorContainer } from 'views/Error';

import MainSideImage from 'assets/side-img-svg.svg';
import { useRegistrationFlow } from 'store/registrationFlow';

import SurveyStep from './Survey';
import TermsStep from './Terms';

import styles from './index.module.scss';

export default function Registration(
  props: PageProps<Extract<KcContext, { pageId: 'login-update-profile.ftl' }>, I18n>,
) {
  const { currentStep, hasError } = useRegistrationFlow();
  const { kcContext, i18n } = props;
  const { advancedMsg } = i18n;

  const displayStep = () => (
    <SideImageLayout sideImgSrc={MainSideImage} theme="light" alignCenter={false}>
      <ScrollContent className={styles.joinPageWrapper}>
        <div className={styles.contentWrapper}>
          {currentStep === 1 ? (
            <TermsStep kcContext={kcContext} i18n={i18n} />
          ) : (
            <SurveyStep kcContext={kcContext} i18n={i18n} />
          )}
        </div>
      </ScrollContent>
    </SideImageLayout>
  );

  const displayError = () => (
    <SideImageLayout sideImgSrc={MainSideImage} theme="light">
      <ErrorContainer redirectUrl={kcContext.redirectUrl} advancedMsg={advancedMsg} />
    </SideImageLayout>
  );

  return !hasError ? displayStep() : displayError();
}
