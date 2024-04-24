#!/bin/bash

_f2e() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: if [[ {str0:1} != # ]] ; eval echo str from file \$1 
TAGS:
\$1 file
[, \$2] hint
"
        return 0
    fi

    if ! [[ -f "$1" ]]; then
        echo "in _f2e() : NOT_FILE : file://$1, hint : '$2' return 1" >&2
        return 1
    fi

    local item
    IFS=$'\n'
    for item in $(cat "$1"); do
        fs=${item:0:1}
        if [ "$fs" != "#" ] && [ "$item" != "" ]; then
            eval echo "$item"
        fi
    done
    IFS=$' \t\n'

}
