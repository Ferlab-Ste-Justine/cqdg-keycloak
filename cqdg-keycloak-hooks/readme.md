Deploy SPI
------------

Build (mvn clean package) the cqdg-keycloak-hooks project and copy target/cqdg-keycloak-hooks.jar into the ${KEYCLOAK_HOME}/providers folder.

####Add custom validations to registration flow

* Login as admin
* Go to Authentication menu - Flows tab.
* Copy the Registration flow (CQDG Registration flow)
* Click the "Actions" drop down menu next to the "CQDG Registration Registration Form" line and select "Add execution"
* Select "Profile Custom Fields Validation" and save.
* Sort the action in the following order: 
  1. registration user creation
  2. recaptcha
  3. profile custom fields validation
  4. profile validation
  5. password validation
* Go to the "Bindings" tab and, select "CQDG Registration" in the dropdown list next to "Registration Flow"
* Save.