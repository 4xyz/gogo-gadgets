#!/usr/bin/env bash
set -ex

vagrant box update
if [[ ! -f $(dirname "$0")/.vagrant-vbguest-plugin-installed ]]; then
    vagrant plugin install vagrant-vbguest
    touch $(dirname "$0")/.vagrant-vbguest-plugin-installed
fi
vagrant up
vagrant reload
