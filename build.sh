#!/bin/bash

./mvnw clean package

if [ ! -d "target" ]; then
    mkdir -p target
fi

rm -f target/cqdg-keycloak.tar.gz
tar czf cqdg-keycloak.tar.gz -C ./target .
mv cqdg-keycloak.tar.gz target/