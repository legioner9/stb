#!/bin/bash

_s2f() {

    # local PPWD=${pwd}
    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: insert \$1 str into str \$2 in file \$3 
TAGS:
\$1 reciver_string
\$2 inserter_string
\$3 reciver_result_file
[, \$4 hint]
NB!!: escaping in \$2 '\[' '\]' '\\\$' '\^' '\\\\\'
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_s2f.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_s2f.tst.d
        return 0
    fi

    local hint=$4

    if [[ -z "$3" ]]; then
        echo "in line=${LINENO}, ${FUNCNAME}() : ERR_AMOUNT_ARGS : '{NARGS}=$#' demand: 3 : ${hint} : return 1" >&2
        return 1
    fi

    if ! [[ -f "$3" ]]; then
        echo "in line=${LINENO}, ${FUNCNAME}() : NOT_FILE : 'file://$3' : ${hint} : return 1" >&2
        return 1
    fi

    #! ptr_path
    # local ptr_path="$3"
    # ptr_path="$("${_abs_path}" "${PPWD}" "ptr_path")"
    #[[ptr_path]]

    sed -i "s|$1|$2|g" "$3"

}
