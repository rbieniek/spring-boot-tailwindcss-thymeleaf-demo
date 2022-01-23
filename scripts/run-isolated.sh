#!/bin/sh

docker run \
       -v $(pwd)/stack-files/keycloak/config:/config/keycloak:ro \
       -v $(pwd)/stack-files/keycloak/standalone/mgmt-users.properties:/opt/jboss/keycloak/standalone/configuration/mgmt-users.properties:ro \
       -v $(pwd)/stack-files/keycloak/standalone/mgmt-groups.properties:/opt/jboss/keycloak/standalone/configuration/mgmt-groups.properties:ro \
       --name keycloak \
       --rm \
       -p 8080:8080 \
       -e KEYCLOAK_USER=admin \
       -e KEYCLOAK_PASSWORD=example \
       -e KEYCLOAK_IMPORT=/config/keycloak/sandbox-keycloak.json \
       -e DB_VENDOR=H2 \
       jboss/keycloak:15.0.2 
       
