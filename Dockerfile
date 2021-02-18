FROM openjdk:11.0-buster as artifacts

COPY . /opt/

RUN cd /opt && /opt/build.sh

FROM jboss/keycloak:12.0.3 as keycloak

COPY --from=artifacts /opt/target/standalone/deployments/cqdg-keycloak-hooks.jar /opt/jboss/keycloak/providers/cqdg-keycloak-hooks.jar
COPY --from=artifacts /opt/target/standalone/deployments/cqdg-keycloak-themes.jar /opt/jboss/keycloak/standalone/deployments/cqdg-keycloak-themes.jar

COPY static.conf /etc/nginx/conf.d/default.conf

