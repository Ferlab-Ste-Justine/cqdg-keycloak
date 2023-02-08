Keycloak
========

Steps to make the deployment work:

1. Make sure app.secrets is in the secrets location. That file should have password for the keycloak that could be used to login.
	a. Keep in mind to login use kfadmin for username and password is set in the app.secrets file.
	b. The app.secrets should have the following variable:
		KEYCLOAK_PASSWORD="some_value"	
1.1. Deploy application. The first deployment will fail due to terraform user is not setup.
1.2. Log in to keycloak
2. Create terraform user from using terraform.json file provided in docs.
3. Add admin roles in "Service Account Roles".
3.1. Make sure that you have terraform.secrets in terraform-config/terraform.secrets secret location. It should have the following values:
        TF_VAR_google_client_id="some_value"
	TF_VAR_google_client_secret="some_value"
	TF_VAR_ras_client_secret="some_value"
	TF_VAR_ras_client_id="some_value"
	TF_VAR_orcid_client_id="some_value"
	TF_VAR_orcid_client_secret="some_value"
	TF_VAR_terraform_client_id="some_value"
	TF_VAR_terraform_client_secret="some_value"
	TF_VAR_facebook_client_id="some_value"
	TF_VAR_facebook_client_secret="some_value"
	TF_VAR_zeppelin_client_secret="some_value"
	TF_VAR_kidsfirst_confidential_apis_client_secret="some_value"
4. Redeploy keycloak. 
