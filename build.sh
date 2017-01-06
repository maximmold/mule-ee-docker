#!/bin/bash

echo
tput rev
echo "┌─────────────────────────────────────────────────────────────────────────┐"
echo "│           M U L E   D O C K E R    I M A G E    B U I L D E R           │"
echo "└─────────────────────────────────────────────────────────────────────────┘"
tput sgr0

if [[ -z $1 ]] ; then
   NAME="mule-ee"
else
   NAME=$1
fi

MULE_BASE="$HOME/mule/${NAME}"

echo
echo "Building Docker image with label '${NAME}'..."
docker build --tag="${NAME}" .
echo
echo "Done. You may now run the Docker image using this command:"
echo "$ docker run -name <CONTAINER_NAME> ${NAME}"
echo
echo "Example of starting the container using HTTP port 8081 mapping and locally mounted data volume:"
echo "$ docker run -t -i --name='${NAME}' -p 8081:8081 -v $MULE_BASE/apps:/opt/mule/apps -v $MULE_BASE/logs:/opt/mule/logs ${NAME}"
echo
