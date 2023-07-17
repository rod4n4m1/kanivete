#!/bin/bash
source building.env

podman login $REGISTRY -u $USER_NAME
podman build . -t $USER_NAME/$APP_NAME:$VERSION
podman push $USER_NAME/$APP_NAME:$VERSION