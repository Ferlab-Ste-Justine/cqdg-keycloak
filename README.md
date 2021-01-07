CQDG Keycloak
==============

Development
-------------

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

#### Configure SPI

See https://github.com/Ferlab-Ste-Justine/cqdg-keycloak/blob/main/cqdg-keycloak-hooks/readme.md