/* eslint-disable max-len */
import { createUseI18n } from 'keycloakify/login';

export const { useI18n } = createUseI18n({
  en: {
    login_title: 'Log in with',
    registration_title: 'CQDG Portal Registration',
    portal_introduction:
      'The CQDG data portal enables research, visualization and access to sensitive and confidential data. Some datasets may require additional approvals and terms and conditions from the studies trust.',
    terms_title: 'CQDG Portal Terms & Conditions',
    last_update_tooltip: 'Last updated on (yyyy-mm-dd)',
    terms_1:
      'You are responsible for maintaining the confidentiality of your account and all activities that take place as a result of the use of your account;',
    terms_2:
      'You are responsible for all material that you submit to this site. You must not transmit any content or documents that contain corrupted files, viruses or any other similar software file that could damage the functioning of a computer system. You must ensure that no personal information is included in the data submitted to CQDG;',
    terms_3:
      'In accordance with the Data Access and Use Policies of the studies, you must take appropriate measures to protect the data against theft, loss, interception, use or unauthorized disclosure;',
    terms_4:
      'You will use controlled access datasets only in connection with the research project described in an approved data access request for each dataset;',
    terms_5:
      'You adhere to the intellectual property clauses (if applicable) as specified in the Data Access and Use Policies of the studies;',
    terms_6:
      'You will not make any attempt to identify or contact any participants or groups of participants from whom the data was collected, or to generate any information that could easily determine the identity of the participants;',
    terms_7:
      'You will report any unauthorized disclosure of data, data security breach or other data management incidents that violate the Data Access Terms;',
    disclaimer_title: 'CQDG Portal Disclaimers',
    disclaimer_1:
      'Data available in the CQDG Portal is provided on an AS-IS basis and may change over time.',
    disclaimer_2:
      'CQDG does not warrant or assume any legal liability or responsibility for information, apparatus, product, or process contained in the CQDG Portal.',
    disclaimer_3:
      'Content provided on the CQDG Portal is for informational purposes only and is not intended to be a substitute for independent professional medical judgment, advice, diagnosis, or treatment.',
    terms_checkbox: 'I have read and agree to the CQDG Portal Terms and Conditions',
    disclaimer_checkbox: 'I have read and understand the CQDG Portal Disclaimers',
    cancel: 'Cancel',
    next: 'Next',
    terms_disclaimer_error: 'Please accept the terms & conditions and portal disclaimers',
    survey_introduction:
      'Thank you for completing this brief form. The more information we have about our users, the more we can continue to make improvements to the portal. The information you submit here will never be disclosed. All fields below need to be filled out.',
    survey_form_roles_label: 'I am a',
    checkbox_help: 'Check all that apply',
    survey_form_role_researcher_in_academic_or_non_profit_institution:
      'Researcher in an academic or non-profit institution',
    survey_form_role_clinician: 'Clinician',
    survey_form_role_representative_of_commercial_or_for_profit_company:
      'Representative of a commercial or for-profit company',
    survey_form_role_bioinformatician_software_developer: 'Bioinformatician, software developer',
    survey_form_role_employee_in_governmental_agency: 'Employee in a governmental agency',
    survey_form_role_other: 'Other',
    survey_form_affiliation_label: 'Affiliation',
    survey_form_affiliation_help: 'Provide institutional or organizational affiliation',
    survey_form_no_affiliation_label: 'I do not have an institutional affiliation',
    survey_form_research_domain_label: 'Research Domain',
    survey_form_research_domain_aging: 'Aging',
    survey_form_research_domain_bioinformatics: 'Bioinformatics',
    survey_form_research_domain_birth_defects: 'Birth Defects',
    survey_form_research_domain_cancer: 'Cancer',
    survey_form_research_domain_circulatory_respiratory_health:
      'Circulatory and Respiratory Health',
    survey_form_research_domain_general_health: 'General Health',
    survey_form_research_domain_infection_immunity: 'Infection and Immunity',
    survey_form_research_domain_musculoskeletal_health_arthritis:
      'Musculoskeletal Health and Arthritis',
    survey_form_research_domain_neurodevelopmental_conditions: 'Neurodevelopmental Conditions',
    survey_form_research_domain_neurosciences_mental_health_addiction:
      'Neurosciences, Mental Health and Addiction',
    survey_form_research_domain_nutrition_metabolism_diabetes: 'Nutrition, Metabolism and Diabetes',
    survey_form_research_domain_population_genomics: 'Population Genomics',
    survey_form_research_domain_rare_diseases: 'Rare Diseases',
    survey_form_research_domain_not_applicable: 'Not Applicable',
    survey_form_research_domain_other: 'Other',
    submit: 'Submit',
    back: 'Back',
    error_title: 'Unable to complete request',
    error_message:
      'Our servers are currently experiencing technical difficulties and are unable to process your request.',
    try_again: 'Try again',
    required_field_error: 'This field is required',
    verifyOAuth2DeviceUserCode:
      'Enter the one-time code provided in your terminal and click submit',
    submit_en: 'Submit',
    oauth2DeviceInvalidUserCodeMessage: 'Invalid code. Please try again.',
    oauth2DeviceExpiredUserCodeMessage: 'OAUTH2_DEVICE_EXPIRED_USER_CODE',
    device_flow_code_expired_title: 'This code has expired',
    device_flow_code_expired_message: 'Please go back to your terminal and generate a new code.',
    oauth2DeviceVerificationCompleteMessage: 'OAUTH2_DEVICE_VERIFICATION_COMPLETE',
    device_flow_success_title: 'You are connected',
    device_flow_success_message_1: 'Your connection will be valid for 60 days.',
    device_flow_success_message_2: 'You can close this window and return to your terminal.',
    oauth2DeviceVerificationFailedMessage: 'OAUTH2_DEVICE_VERIFICATION_FAILED',
    device_flow_error_title: 'An error has occurred',
    device_flow_error_message:
      'You may close this window and go back to your terminal to try again.',
    oauth2DeviceConsentDeniedMessage: 'OAUTH2_DEVICE_CONSENT_DENIED',
    device_flow_consent_denied_title: 'Connection denied',
    device_flow_consent_denied_message:
      'You have not granted access for establishing the connection.',
    oauth2DeviceAuthorizationGrantDisabledMessage: 'OAUTH2_DEVICE_AUTHORIZATION_GRANT_DISABLED',
    device_flow_disabled_title: 'Authorization denied',
    device_flow_disabled_message: 'Please contact support for further assistance:',
    pageExpiredTitle: 'This page has expired',
    pageExpiredMsg1: 'To restart the authentication process,',
    pageExpiredMsg2: 'To resume the authentication process,',
    doClickHere: 'click here',
    oauthGrantRequest: 'Would you like to grant access for these privileges?',
    profileScopeConsentText: 'Profil',
    emailScopeConsentText: 'Email',
    rolesScopeConsentText: 'Role',
    alreadyLoggedIn: 'ALREADY_LOGGED_IN',
    already_logged_in_title: 'You are already connected',
    already_logged_in_message: 'You can close this window.',
  },
  fr: {
    login_title: 'Choisir votre identifiant',
    registration_title: 'Inscription au portail du CQDG',
    portal_introduction:
      'Le portail de données du CQDG permet la recherche, la visualisation et l’accès à des données sensibles et confidentielles. Certains jeux de données peuvent exiger des autorisations et des termes et conditions supplémentaires de la part des études fiduciaires.',
    terms_title: 'Termes & conditions d’utilisation du portail CQDG',
    last_update_tooltip: 'Dernière mise à jour (aaaa-mm-jj)',
    terms_1:
      'Vous êtes responsable du maintien de la confidentialité de votre compte et de toutes les activités en lien avec l’utilisation de votre compte ;',
    terms_2:
      'Vous êtes responsable de tout le matériel que vous soumettez sur ce site. Vous ne devez pas transmettre du contenu ou des documents qui contiennent des fichiers corrompus, des virus ou tout autre fichier logiciel similaire qui puissent endommager le fonctionnement d’un système informatique. Vous devez vous assurer qu’aucun renseignement personnel ne soit inclus dans les données soumises au CQDG ;',
    terms_3:
      'Vous devez prendre les mesures appropriées pour protéger les données contre tout vol, perte, interception, utilisation ou divulgation non autorisée, conformément aux politiques d’accès aux données des études fiduciaires ;',
    terms_4:
      'Vous devez utiliser les ensembles de données à accès contrôlé uniquement pour les fins du projet de recherche approuvé ;',
    terms_5:
      'Vous devez adhérer aux clauses concernant la propriété intellectuelle (le cas échéant) telles que spécifiées dans les politiques d’accès aux données des études fiduciaires ;',
    terms_6:
      "Vous ne devez faire aucune tentative d’identifier ou de contacter des participants ou des groupes de participants auprès desquels les données ont été collectées, ou de générer des informations qui pourraient permettre d'identifier des participants ;",
    terms_7:
      "Vous devez rapporter toute divulgation non autorisée de données, violation de la sécurité des données ou autres incidents de gestion de données contraires aux conditions d'accès aux données ;",
    disclaimer_title: 'Avis de non-responsabilité du portail CQDG',
    disclaimer_1:
      'Les données disponibles sur le portail CQDG sont fournies telles quelles et peuvent changer au fil du temps.',
    disclaimer_2:
      "Le CQDG ne garantit ni n'assume aucune responsabilité légale ou responsabilité pour les informations, appareils, produits ou processus contenus dans le portail CQDG.",
    disclaimer_3:
      "Le contenu fourni sur le portail CQDG est à titre informatif uniquement et n'est pas destiné à se substituer à un jugement, un conseil, un diagnostic ou un traitement d’un professionnel de la santé.",
    terms_checkbox: "J'ai lu et j'accepte les termes et conditions du portail CQDG",
    disclaimer_checkbox: "J'ai lu et compris les clauses de non-responsabilité du portail CQDG",
    cancel: 'Annuler',
    next: 'Suivant',
    terms_disclaimer_error:
      'Veuillez accepter les termes & conditions  et les clauses de non-responsabilité du portail',
    survey_introduction:
      'Merci de bien vouloir remplir ce petit formulaire. En connaître un peu plus sur nos utilisateurs nous est extrêmement utile pour continuer à améliorer le portail. L’information saisie ci-dessous ne sera jamais partagée. Tous les champs ci-dessous doivent être remplis.',
    survey_form_roles_label: 'Je suis un(e)',
    checkbox_help: 'Cochez tout ce qui s’applique',
    survey_form_role_researcher_in_academic_or_non_profit_institution:
      'Chercheur(e) dans une institution académique ou sans but lucratif',
    survey_form_role_representative_of_commercial_or_for_profit_company:
      "Représentant(e) d'une entreprise commerciale ou à but lucratif",
    survey_form_role_bioinformatician_software_developer:
      'Bioinformaticien(ne), développeur(e) logiciel',
    survey_form_role_clinician: 'Clinician',
    survey_form_role_employee_in_governmental_agency: 'Employé(e) d’un organisme gouvernemental',
    survey_form_role_other: 'Autre',
    survey_form_affiliation_label: 'Affiliation',
    survey_form_affiliation_help:
      'Indiquez votre affiliation institutionnelle ou organisationnelle',
    survey_form_no_affiliation_label: "Je n'ai pas d'affiliation institutionnelle",
    survey_form_research_domain_label: 'Domaine de recherche',
    survey_form_research_domain_aging: 'Vieillissement',
    survey_form_research_domain_bioinformatics: 'Bioinformatique',
    survey_form_research_domain_birth_defects: 'Malformations congénitales',
    survey_form_research_domain_cancer: 'Cancer',
    survey_form_research_domain_circulatory_respiratory_health:
      'Santé circulatoire et respiratoire',
    survey_form_research_domain_general_health: 'Santé générale',
    survey_form_research_domain_infection_immunity: 'Infection et immunité',
    survey_form_research_domain_musculoskeletal_health_arthritis:
      'Santé musculo-squelettique et arthrite',
    survey_form_research_domain_neurodevelopmental_conditions: 'Conditions neuro-développementales',
    survey_form_research_domain_neurosciences_mental_health_addiction:
      'Neurosciences, santé mentale et toxicomanie',
    survey_form_research_domain_nutrition_metabolism_diabetes: 'Nutrition, métabolisme et diabète',
    survey_form_research_domain_population_genomics: 'Génomique des populations',
    survey_form_research_domain_rare_diseases: 'Maladies rares',
    survey_form_research_domain_not_applicable: "Ne s'applique pas",
    survey_form_research_domain_other: 'Autre',
    submit: 'Soumettre',
    back: 'Précédent',
    error_title: 'Impossible de terminer la demande',
    error_message:
      'Nos serveurs rencontrent actuellement des difficultés techniques et ne sont pas en mesure de traiter votre demande.',
    try_again: 'Réessayer',
    required_field_error: 'Ce champ est obligatoire',
    verifyOAuth2DeviceUserCode:
      'Enter the one-time code provided in your terminal and click submit', // We want to always display this in english
    submit_en: 'Submit',
    oauth2DeviceInvalidUserCodeMessage: 'Code invalide. Veuillez réessayer.',
    oauth2DeviceExpiredUserCodeMessage: 'OAUTH2_DEVICE_EXPIRED_USER_CODE',
    device_flow_code_expired_title: 'Code expiré',
    device_flow_code_expired_message:
      'Veuillez retourner sur votre terminal pour générer un nouveau code.',
    oauth2DeviceVerificationCompleteMessage: 'OAUTH2_DEVICE_VERIFICATION_COMPLETE',
    device_flow_success_title: 'Vous êtes connecté',
    device_flow_success_message_1: 'Votre connexion sera valable pendant 60 jours.',
    device_flow_success_message_2: 'Vous pouvez fermer cette fenêtre et revenir à votre terminal.',
    oauth2DeviceVerificationFailedMessage: 'OAUTH2_DEVICE_VERIFICATION_FAILED',
    device_flow_error_title: 'Une erreur est survenue',
    device_flow_error_message:
      'Veuillez fermer cette fenêtre et retourner à votre terminal pour réessayer.',
    oauth2DeviceConsentDeniedMessage: 'OAUTH2_DEVICE_CONSENT_DENIED',
    device_flow_consent_denied_title: 'Connexion refusée',
    device_flow_consent_denied_message:
      "Vous n'avez pas accordé les privilèges pour établir la connexion.",
    oauth2DeviceAuthorizationGrantDisabledMessage: 'OAUTH2_DEVICE_AUTHORIZATION_GRANT_DISABLED',
    device_flow_disabled_title: 'Autorisation refusée',
    device_flow_disabled_message:
      "Veuillez contacter notre équipe de soutien pour obtenir de l'aide supplémentaire :",
    pageExpiredTitle: 'Page expirée',
    pageExpiredMsg1: "Pour recommencer le processus d'authentification,",
    pageExpiredMsg2: 'Pour continuer le processus d’authentification,',
    doClickHere: 'cliquez ici',
    oauthGrantRequest: 'Voulez-vous accorder ces privilèges d’accès ?',
    profileScopeConsentText: 'Profil',
    emailScopeConsentText: 'Courriel',
    rolesScopeConsentText: 'Role',
    alreadyLoggedIn: 'ALREADY_LOGGED_IN',
    already_logged_in_title: 'Vous êtes déjà connecté',
    already_logged_in_message: 'Vous pouvez fermer cette fenêtre.',
  },
});

export type I18n = NonNullable<ReturnType<typeof useI18n>>;
