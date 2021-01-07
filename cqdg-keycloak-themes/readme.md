CQDG Keycloak Theme
==============

Development
-------------

Launch ``npm start`` at the root of the project.

Launch ``keycloak start`` in the docker folder.

Then go to http://localhost:8080 and you can login using admin/password.

### Configure Keycloak Mail Server

```
Host: smtp.gmail.com

Port: 587

From: your-account@gmail.com

Activate StartTLS

Activate Authentication
```

Provide your username and password for your gmail account and save the configuration.

N.B.: In order for this to work, you might have to allow access to "less secure apps" in your gmail account settings.

### Configuring reCaptcha

#### Google API Key
Go to https://www.google.com/recaptcha/admin/create in order to create the API Key.

Select the reCAPTCHA v2 with the "I'm not a robot" tickbox.

Domains: localhost

#### Keycloak configuration

https://www.keycloak.org/docs/latest/server_admin/#_recaptcha

```
X-Frame-Options: ALLOW-FROM https://www.google.com
Content-Security-Policy: frame-src 'self' https://www.google.com; frame-ancestors 'self' localhost http://localhost:3000; object-src 'none';
```

Deploy Themes
-------------

You can either deploy the themes by copying to the themes folder or as modules.

Deploy SPI
------------

Build (mvn clean package) the cqdg-keycloak-hooks project and copy target/cqdg-keycloak-hooks.jar into the cqdg-keycloak-theme/docker/providers folder.

Docker-compose will copy the content of this folder in the /opt/jboss/keycloak/providers of the Keycloak container and the SPI will be deployed at startup.

To add the custom validation flow to the registration flow:
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

### Copy

Simplest way to deploy the themes is to copy `src/main/resources/theme/*` to `themes/`.

### Module

Alternatively you can deploy as modules. This can be done by first running:

    mvn clean install
    $KEYCLOAK_HOME/bin/jboss-cli.sh --command="module add --name=ca.cqdg.themes --resources=target/cqdg-keycloak-themes.jar"

Then open `standalone/configuration/standalone.xml` and register the theme module by adding:

    <theme>
        ...
        <modules>
            <module>ca.cqdg.themes</module>
        </modules>
    </theme>

CQDG Theme
-------------------

Theme that changes the look of the login forms and emails. To enable the theme open the admin console, select your realm, click on `Theme`. In the dropdown for `Login Theme` select `CQDG`. Click `Save` and login to the realm to see the new theme in action.


CQDG Admin Theme
-----------------

To enable the theme open the admin console, select your realm, click on `Theme`. In the dropdowns for `Account Theme` and `Admin Console Theme` select `CQDG-Admin`. Click `Save` and login to the realm to see the new theme in action.

One thing to note is that to change the admin console for the master admin console (`/auth/admin`) you need to change the theme for the master realm. Changing the admin console theme for any other realms will only change the admin console for that specific realm (for example `/auth/admin/myrealm/console`).