FROM openjdk:11.0.4-jdk-slim as artifacts

COPY . /opt/

RUN cd /opt && /opt/build.sh

FROM jboss/keycloak:12.0.3 as keycloak

COPY --from=artifacts /opt/cqdg-keycloak-themes/src/main/resources/theme/cqdg /opt/jboss/keycloak/themes/cqdg
COPY --from=artifacts /opt/cqdg-keycloak-themes/src/main/resources/theme/cqdg-admin /opt/jboss/keycloak/themes/cqdg-admin
COPY --from=artifacts /opt/cqdg-keycloak-themes/src/main/resources/theme/main /opt/jboss/keycloak/themes/main

COPY --from=artifacts /opt/target/standalone/deployments/cqdg-keycloak-hooks.jar /opt/jboss/keycloak/standalone/deployments/cqdg-keycloak-hooks.jar
