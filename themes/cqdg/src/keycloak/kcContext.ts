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
        research_domains?: string[];
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
  | {
      pageId: "error.ftl";
    }
>({
  /* Uncomment to test outside of keycloak, ⚠️ don't forget to run 'npm run keycloak' at least once */
  // mockPageId: "login-update-profile.ftl",
  // mockPageId: "login.ftl",
  // mockPageId: "error.ftl",
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
          {
            providerId: "microsoft",
            alias: "microsoft",
            displayName: "Microsoft",
          },
          {
            providerId: "cilogon",
            alias: "cilogon",
            displayName: "CiLogon",
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
        roles: ["bioinformatician", "clinician"],
        research_domains: ["aging", "other"],
        affiliation: "CHUSJ",
        accepted_terms: false,
        understand_disclaimer: false,
        completed_registration: false
      }
    },
    {
      pageId: "error.ftl",
    }
  ],
});

export type KcContext = NonNullable<typeof kcContext>;
