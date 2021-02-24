CQDG Keycloak
==============

Development
-------------
To point to latest ferlab-ui, checkout the ferlab-ui branch you want to use and :

```
ferlab-ui/packages/style
npm install
npm link
```

Then :

```
cqdg-keycloak/cqdg-keycloak-themes
npm install
npm link @ferlab/style
```

If you wish to go back to pointing to the ferlab-ui from npmjs.org :

```
npm unlink @ferlab/style
npm install 
```

Launch ``npm start`` at the root of the cqdg-keycloak-themes project.

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

## Configuring reCaptcha

### Google API Key
Go to https://www.google.com/recaptcha/admin/create in order to create the API Key.

Select the reCAPTCHA v2 with the "I'm not a robot" tickbox.

Domains: localhost

### Keycloak configuration

https://www.keycloak.org/docs/latest/server_admin/#_recaptcha

```
X-Frame-Options: ALLOW-FROM https://www.google.com
Content-Security-Policy: frame-src 'self' https://www.google.com; frame-ancestors 'self' localhost http://localhost:3000; object-src 'none';
```


## Configuring Google authentication

### create credentials
Go to https://console.cloud.google.com/apis/dashboard

Login with your right account

You will need to create a new project. 
At the top bar you should see organization or a dropdown near Google Cloud Platform.
Click on it, select an organization if you have one or just create a brand new project. 
Its a the top right of the modal. Name it what you want.

Once done, you can create new credentials in your project.
Enter a name for it
Fill in URIs with (for dev):

Authorized Javascript Origins
http://localhost:8080

Authorized redirect URIs (this one is provided by keycloak when you create your provider)
http://localhost:8080/auth/realms/CQDG/broker/google/endpoint


### Create Google provider
Login to keycloak admin panel

select your Realm (CQDG)
click on identity Providers
in the dropdown select under Social Google

For the configuration:
You now have a redirect URI, copy/paste this in the redirect URI on google side
Copy/Paste Client ID and Client Secret from Google here

Hosted Domain: *

Enabled (leave the rest default)
Save your configs

### Keycloak File Theming
You can customize what is inside the list as you wish

```
<#if realm.password && social.providers??>
    <#list social.providers as p>
        <div class="form__group">
            <a class="social-link" href="${p.loginUrl}">
                ${p.alias}
            </a>
        </div>
    </#list>
</#if>
```
## Configuring ORCID authentication
Go to https://sandbox.orcid.org/ to create an account or login

** YOU HAVE TO CREATE AN ACCOUNT WITH A MALINATOR EMAIL **
You don't need to create one, there is a public inboxes to receive all malionator email here: https://www.mailinator.com/v3/#/#inboxpane

Before creating any credentials you have to validate your email account.

Once all validations is done, you can create you API's access
Click on the dropdown with your name top right (next to language) and click on developers tools
You will need to activate it before configuring anything
Once activated, go to the keycloak configuration you will need the redirect URIs before completing this section.

You need to enter a Name for the config,  a valid site and a description.
Paste your redirect URI and click save.

Once created you should have access to the Client ID, secret, authorize request and token request

### Create ORCID Provider
Login to keycloak admin panel

Click on identity Providers and select in the dropdown menu OpenID Connect v1.0
here you have your Redirect URI you can copy/paste this to ORCID config
Enter an Alias and Display Name and Enabled (leave the rest default)

#### OpenID Connect Config
Use the Authorization and Token URL provided by ORCID and paste them here.
Do the same for Client ID and Secret theClient authentication ** HAS ** to be Client secret sent as post
Save your configs

#### Manage theming files
[See this section](#keycloak-file-theming)

### Configure SPI
See https://github.com/Ferlab-Ste-Justine/cqdg-keycloak/blob/main/cqdg-keycloak-hooks/readme.md