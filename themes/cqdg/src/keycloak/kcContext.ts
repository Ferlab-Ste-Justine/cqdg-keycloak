import { getKcContext } from 'keycloakify';

export const { kcContext } = getKcContext<
  | {
      pageId: 'login-update-profile.ftl';
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
      userOptions: {
        roleOptions: {
          value: string;
          label: string;
        }[];
        researchDomainOptions: {
          value: string;
          label: string;
        }[];
        usageOptions: {
          value: string;
          label: string;
        }[];
      };
    }
  | {
      pageId: 'login.ftl';
    }
  | {
      pageId: 'error.ftl';
    }
>({
  /* Uncomment to test outside of keycloak, ⚠️ don't forget to run 'npm run keycloak' at least once */
  // mockPageId: 'login-update-profile.ftl',
  // mockPageId: 'login.ftl',
  // mockPageId: 'error.ftl',
  /**
   * Customize the simulated kcContext that will let us
   * dev the page outside keycloak (with auto-reload)
   */
  mockData: [
    {
      pageId: 'login.ftl',
      social: {
        providers: [
          {
            providerId: 'google',
            alias: 'google',
            displayName: 'Google',
          },
          {
            providerId: 'orcid',
            alias: 'orcid',
            displayName: 'Orcid',
          },
          {
            providerId: 'microsoft',
            alias: 'microsoft',
            displayName: 'Microsoft',
          },
          {
            providerId: 'cilogon',
            alias: 'cilogon',
            displayName: 'CiLogon',
          },
        ],
      },
      registrationDisabled: true,
    },
    {
      pageId: 'login-update-profile.ftl',
      redirectUrl: 'https://portalv2.qa.cqdg.ferlab.bio',
      userProfile: {
        editUsernameAllowed: false,
        roles: ['bioinformatician_software_developer', 'clinician'],
        research_domains: ['aging', 'other'],
        affiliation: 'CHUSJ',
        accepted_terms: false,
        understand_disclaimer: false,
        completed_registration: false,
      },
      userOptions: {
        roleOptions: [
          {
            value: 'bioinformatician_software_developer',
            label: 'Bioinformatician, software developer',
          },
          {
            value: 'clinician',
            label: 'Clinician',
          },
          {
            value: 'employee_in_governmental_agency',
            label: 'Employee in a governmental agency',
          },
        ],
        researchDomainOptions: [
          {
            value: 'aging',
            label: 'Aging',
          },
          {
            value: 'bioinformatics',
            label: 'Bioinformatics',
          },
          {
            value: 'birth_defects',
            label: 'Birth Defects',
          },
          {
            value: 'other',
            label: 'Other',
          },
        ],
        usageOptions: [],
      },
    },
    {
      pageId: 'error.ftl',
    },
  ],
});

export type KcContext = NonNullable<typeof kcContext>;
