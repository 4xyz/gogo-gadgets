#!/bin/bash
# function to get absolute path in mac or linux

function abspath() {
    if [[ $OSTYPE == 'darwin'* ]]; then
        if [[ -z $(which realpath) ]]; then
            echo >&2 'realpth not found - use "brew install coreutils" to install it'
        else
            echo $(realpath $1)
        fi
    else
        echo $(readlink -f $1)
    fi
}
