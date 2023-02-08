import { memo } from "react";
import type { KcProps } from "keycloakify";
import { KcContext } from "keycloak/kcContext";
import SideImageLayout from "layout/SideImage";
import MainSideImage from "assets/mainSideImage.jpg";
import TermsStep from "./Terms";
import ScrollContent from "@ferlab/ui/core/layout/ScrollContent";
import SurveyStep from "./Survey";
import { useRegistrationFlow } from "store/registrationFlow";

import styles from "./index.module.scss";

export type KcContext_LoginUpdateProfile = Extract<
  KcContext,
  { pageId: "login-update-profile.ftl" }
>;

const Registration = memo(
  ({
    kcContext,
    ...props
  }: { kcContext: KcContext_LoginUpdateProfile } & KcProps) => {
    const { currentStep } = useRegistrationFlow();

    return (
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
  }
);

export default Registration;
