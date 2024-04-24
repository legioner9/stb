#!/bin/bash

_is_root() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#
    
    # echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: 
TAGS:
\$1 
[, \$2]
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_is_root.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_is_root.tst.d
        return 0
    fi

    arg1="$1"
    if [[ -z "${arg1}" ]]; then
        echo "_is_root() : \$1 NOT_DEFINE : return 1" >&2
        return 1
    fi
    if [[ "/" == "${arg1:0:1}" ]]; then
        cd $PPWD
        return 0
    else
        cd $PPWD
        return 1
    fi

}
