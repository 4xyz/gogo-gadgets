#!/bin/bash

MY_PATH=$(cd $(dirname "$0"); pwd -P)
TERRA_DIR=${TERRA_DIR-$(pwd)}
TERRA_DIR=$(cd $TERRA_DIR; pwd -P)

docker run -i --rm \
    -v $TERRA_DIR:/opt/terraform \
    4xyz/terraform:$(< ${MY_PATH}/VERSION) \
    terraform $@
