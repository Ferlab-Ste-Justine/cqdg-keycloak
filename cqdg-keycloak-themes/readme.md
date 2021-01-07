CQDG Keycloak Theme
==============

Deploy Themes
-------------

You can either deploy the themes by copying to the themes folder or as modules.

### Copy

Simplest way to deploy the themes is to copy `src/main/resources/theme/*` to `themes/`.

### Copy Jar

    mvn clean install
    cp cqdg-keycloak-themes.jar $KEYCLOAK_HOME/standalone/deployments


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