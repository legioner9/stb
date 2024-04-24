#!/bin/bash

_df2e() {

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: ls only nfiles
TAGS: @ls @nfile
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
        if [ -f "$1/$item" ] && [ "${item:0:1}" != "_" ]; then
            echo "$item"
        fi
    done

}
