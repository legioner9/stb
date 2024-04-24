#!/bin/bash

_dd2e() {

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: ls only ndirs
TAGS: @ls @ndir
\$1 
[, \$2]
"
        return 0
    fi

    if ! [[ -d "$1" ]]; then
        echo "in _d2e() : NOT_DIR : file://$1, hint : '$2' return 1" >&2
        return 1
    fi

    local item

    for item in $(ls "$1"); do
        if [ -d "$1/$item" ] && [ "${item:0:1}" != "_" ]; then
            echo "$item"
        fi
    done

}
