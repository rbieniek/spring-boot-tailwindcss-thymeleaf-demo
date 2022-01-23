#!/bin/sh

CONTAINER_ID=`docker ps -a|grep jboss/keycloak|awk '{ print $1 }'`

[ ! -d build/stack-files/keycloak ] &&  mkdir -p build/stack-files/keycloak

sudo chown root.root build/stack-files/keycloak
sudo chmod 1777 build/stack-files/keycloak

echo Dumping configuration from container with ID $CONTAINER_ID

docker exec -it $CONTAINER_ID /opt/jboss/keycloak/bin/standalone.sh \
	-Djboss.socket.binding.port-offset=100 \
	-Dkeycloak.migration.action=export \
	-Dkeycloak.migration.provider=singleFile \
	-Dkeycloak.migration.realmName=sandbox \
	-Dkeycloak.migration.usersExportStrategy=REALM_FILE \
	-Dkeycloak.migration.file=/work/keycloak/sandbox-keycloak.json
