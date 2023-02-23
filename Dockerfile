FROM ferlabcrsj/maven-node:969831c6c1fc6a3f3d4c24b3d4966e856d1e6cae-1648832023 as builder
WORKDIR /app
COPY . /app
RUN mvn clean package
RUN cd themes/cqdg/ && npm install && npm run keycloak


FROM jboss/keycloak:14.0.0

USER root
RUN microdnf install -y findutils
USER jboss
COPY --from=builder /app/configuration/standalone-ha.xml /opt/jboss/keycloak/standalone/configuration/standalone-ha.xml
COPY --from=builder /app/configuration/standalone.xml /opt/jboss/keycloak/standalone/configuration/standalone.xml

COPY --from=builder /app/target/cqdg-keycloak-ext-1.0-SNAPSHOT-jar-with-dependencies.jar /opt/jboss/keycloak/standalone/deployments/
COPY --from=builder /app/themes/cqdg/build_keycloak/target/keycloakify-cqdg-app-keycloak-theme-0.1.jar /opt/jboss/keycloak/standalone/deployments/

