#!/bin/bash

_c_up() {
    echo -e "${CYAN}--- c_up() \$1 = $1---${NORMAL}" #started functions
    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: exec rec in dir nfile with ext=.sh
TAGS:
\$1 
[, \$2]
"
        return 0
    fi
    IFS=$' \t\n'

    # cd_h "$1" "$filename" "$LINENO"
    if [[ -d "$1" ]]; then
        cd "$1"
    else
        echo "'$1' is not dir :: return 1" >&2
        return 1
    fi

    local dir
    dir=$(pwd)

    for item in *; do

        local item_path=$dir/$item

        if [ -f "$item_path" ] && [ "${item:0:1}" != "_" ] && [ "${item##*.}" = sh ]; then

            if ! . "$item_path"; then
                hint="\$1: \$2: "
                echo "in fs=file:// , line=${LINENO}, ${FNN}() : EXEC_FAIL : '. file://$item_path' : ${hint} : return 1" >&2
                return 1
            fi

        elif
            [ -d "$item_path" ] && [ "${item:0:1}" != "_" ]
        then

            _c_up "$item_path"

        fi

    done
}
