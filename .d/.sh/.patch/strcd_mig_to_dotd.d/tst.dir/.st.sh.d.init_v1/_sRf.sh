#!/bin/bash

_sRf() {

    # local PPWD=${pwd}
    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: 
TAGS:
\$1 revove_string
\$2 treat_file
[, \$3 hint]
NB!!: escaping in \$1 '\[' '\]' '\\\$' '\^' '\\\\\'
"
        return 0
    fi

    local hint=$3

    if [[ -z "$2" ]]; then
        echo "in line=${LINENO}, ${FUNCNAME}() : ERR_AMOUNT_ARGS : '{NARGS}=$#' demand: 3 : ${hint} : return 1" >&2
        return 1
    fi

    if ! [[ -f "$2" ]]; then
        echo "in line=${LINENO}, ${FUNCNAME}() : NOT_FILE : 'file://$3' : ${hint} : return 1" >&2
        return 1
    fi

    #! ptr_path
    # local ptr_path="$3"
    # ptr_path="$("${_abs_path}" "${PPWD}" "ptr_path")"
    #[[ptr_path]]
    echo -e "${HLIGHT}--- exec: sed -i 's|$1||g' $2 ---${NORMAL}" #start files
    sed -i "s|$1||g" "$2"

}
