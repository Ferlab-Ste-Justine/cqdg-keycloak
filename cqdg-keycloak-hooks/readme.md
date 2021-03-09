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

####Define custom First Broker Login flow 

* Login as admin
* Go to Authentication menu - Flows tab.
* Copy the First Broker Login (CQDG First Broker Login)
* Click the "Add execution" on the top righ corner and select "Custom Review Profile"
* Make sure to put the new execution at the very top.
* Delete the "Review Profile" (default implementation) execution as well as the "Confirm Link Existing Account" execution.
* Configure the "Custom Review Profile": click "Actions -> Config" and set "Update Profile on First Login" to "ON".
* Go to the "Identity Providers" menu of the left navigation and edit the Google and Orcid providers to set the "First Login Flow" to "CQDG First Login Flow"
* Save.
* Go to the CQDG Realm Settings
* Select the Login tab and activate "Email as username"


Development
------------

#### Remote Debug Setup

![IntelliJ Remote Debugging Configuration](https://github.com/Ferlab-Ste-Justine/cqdg-keycloak/blob/main/cqdg-keycloak-hooks/remote-debugging.png)