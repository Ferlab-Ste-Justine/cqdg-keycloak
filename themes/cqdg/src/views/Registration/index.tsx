import { memo } from "react";
import type { KcProps } from "keycloakify";
import { KcContext } from "keycloak/kcContext";
import SideImageLayout from "layout/SideImage";
import MainSideImage from "assets/side-img-svg.svg";
import TermsStep from "./Terms";
import ScrollContent from "@ferlab/ui/core/layout/ScrollContent";
import SurveyStep from "./Survey";
import { useRegistrationFlow } from "store/registrationFlow";

import styles from "./index.module.scss";
import { ErrorContainer } from "views/Error";

export type KcContext_LoginUpdateProfile = Extract<
  KcContext,
  { pageId: "login-update-profile.ftl" }
>;

const Registration = memo(
  ({
    kcContext,
    ...props
  }: { kcContext: KcContext_LoginUpdateProfile } & KcProps) => {
    const { currentStep, hasError } = useRegistrationFlow();

    const displayStep = () => (
      <SideImageLayout
        sideImgSrc={MainSideImage}
        theme="light"
        alignCenter={false}
      >
        <ScrollContent className={styles.joinPageWrapper}>
          <div className={styles.contentWrapper}>
            {currentStep === 1 ? (
              <TermsStep kcContext={kcContext} />
            ) : (
              <SurveyStep kcContext={kcContext} />
            )}
          </div>
        </ScrollContent>
      </SideImageLayout>
    );
    
    const displayError = () => (
      <SideImageLayout
        sideImgSrc={MainSideImage}
        theme="light"
      >
        <ErrorContainer redirectUrl={kcContext.redirectUrl}/>
      </SideImageLayout>
    );

    return !hasError ? displayStep() : displayError();
  }
);

export default Registration;
