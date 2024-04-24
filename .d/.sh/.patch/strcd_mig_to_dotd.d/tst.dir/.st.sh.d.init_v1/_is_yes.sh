#!/bin/bash

_is_yes() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FUNCNAME} :: return 0 only answer for question type 'y' 
TAGS:
\$1 question
[, \$2]
CNTL: 
    _e : body    : _edit ${HOME}/.st.rc.d/.st.sh.d/_is_yes.sh
    _t : tst_dir : _edit ${HOME}/.st.rc.d/.st.tst.d/_is_yes.tst.d
EXAM: 
    ${FUNCNAME}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_is_yes.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_is_yes.tst.d
        return 0
    fi

    local yes
    read -r -p "only 'y' is yes. QUESTION: $1" yes

    if [ "${yes:-no}" == "y" ]; then
        cd $PPWD
        return 0
    else
        cd $PPWD
        return 1
    fi

}
