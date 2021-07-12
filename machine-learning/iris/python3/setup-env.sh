#!/bin/bash

set -ex

MY_DIR=$(dirname "$0")

python3 -m venv $MY_DIR/.env
source $MY_DIR/.env/bin/activate
pip install --upgrade pip
pip install wheel
pip install -r $MY_DIR/requirements.txt
