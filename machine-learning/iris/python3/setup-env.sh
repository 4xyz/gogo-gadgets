#!/bin/bash

set -ex

MY_DIR=$(dirname "$0")

python3 -m venv $MY_DIR/.iris
source $MY_DIR/.iris/bin/activate
pip install --upgrade pip
pip install wheel
pip install -r $MY_DIR/requirements.txt
