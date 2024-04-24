#!/bin/bash

_ststart() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FUNCNAME} :: . \${HOME}/.st.rc.d/.st.rc
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : body    : _edit ${HOME}/.st.rc.d/.st.sh.d/_ststart.sh
    _t : tst_dir : _edit ${HOME}/.st.rc.d/.st.tst.d/_ststart.tst.d
EXAM: 
    ${FUNCNAME}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_ststart.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_ststart.tst.d
        return 0
    fi

    . ${HOME}/.st.rc.d/.st.rc

    cd $PPWD
    return 0

}
