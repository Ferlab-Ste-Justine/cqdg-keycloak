FROM node:18-alpine3.15 as builder-theme
WORKDIR /app
COPY . /app
RUN cd cqdg-theme/ && npm install && npm run keycloak

FROM maven:3-adoptopenjdk-16 as builder-providers
WORKDIR /app
COPY . /app
RUN cd cqdg-providers/ && mvn clean package -DskipTests

FROM quay.io/keycloak/keycloak:21.1.1

ENV KC_DB=postgres
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_DEBUG=true
ENV KC_HOSTNAME_STRICT=false
ENV KC_HOSTNAME_STRICT_HTTPS=false
ENV KC_CACHE=ispn
ENV KC_CACHE_STACK=kubernetes
ENV JAVA_OPTS_APPEND=-Djgroups.dns.query=keycloak-headless

WORKDIR /opt/keycloak

COPY --from=builder-providers /app/cqdg-providers//target/bio.ferlab.keycloak.cqdg-keycloak-ext.jar /opt/keycloak/providers
COPY --from=builder-theme /app/cqdg-theme/build_keycloak/src/main/resources/theme/keycloakify-cqdg-app /opt/keycloak/themes/keycloakify-cqdg-app

RUN /opt/keycloak/bin/kc.sh build

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

