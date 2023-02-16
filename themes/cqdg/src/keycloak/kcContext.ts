import { getKcContext } from "keycloakify";

export const { kcContext } = getKcContext<
  | {
      pageId: "login-update-profile.ftl";
      redirectUrl: string;
      userProfile: {
        editUsernameAllowed: boolean;
        username?: string;
        email?: string;
        first_name?: string;
        last_name?: string;
        era_commons_id?: string;
        nih_ned_id?: string;
        external_individual_fullname?: string;
        external_individual_email?: string;
        affiliation?: string;
        portal_usages?: string[];
        roles?: string[];
        research_area?: string;
        accepted_terms: boolean;
        understand_disclaimer: boolean;
        commercial_use_reason?: string;
        completed_registration: boolean;
        config?: any;

      };
    }
  | {
      pageId: "login.ftl";
    }
>({
  /* Uncomment to test outside of keycloak, ⚠️ don't forget to run 'npm run keycloak' at least once */
  // mockPageId: "login-update-profile.ftl",
  // mockPageId: "login.ftl",
  /**
   * Customize the simulated kcContext that will let us
   * dev the page outside keycloak (with auto-reload)
   */
  mockData: [
    {
      pageId: "login.ftl",
      social: {
        providers: [
          {
            providerId: "google",
            alias: "google",
            displayName: "Google",
          },
          {
            providerId: "orcid",
            alias: "orcid",
            displayName: "Orcid",
          },
        ],
      },
      registrationDisabled: true,
    },
    {
      pageId: "login-update-profile.ftl",
      redirectUrl: "https://portalv2.qa.cqdg.ferlab.bio",
      userProfile: {
        editUsernameAllowed: false,
        // era_commons_id: "1234",
        nih_ned_id: "",
        external_individual_fullname: "Jean Jean",
        external_individual_email: "",
        era_commons_id: "CASOLI",
        // affiliation: "CHUSJ",
        portal_usages: ["Commercial purposes", "My custom usage"],
        commercial_use_reason: "For fun",
        roles: ["Tool or Algorithm Developer", "Clinician"],
        research_area: "",
        affiliation: "CHUSJ",
        accepted_terms: false,
        understand_disclaimer: false,
        completed_registration: false
      }
    },
  ],
});

export type KcContext = NonNullable<typeof kcContext>;
