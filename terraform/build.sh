#!/bin/bash

MY_PATH=$(cd $(dirname "$0"); pwd -P)
[[ ! -z ${DOCKER_IMG} ]] || DOCKER_IMG=4xyz/terraform:$(< ${MY_PATH}/VERSION)

docker build -t ${DOCKER_IMG} ${MY_PATH}
