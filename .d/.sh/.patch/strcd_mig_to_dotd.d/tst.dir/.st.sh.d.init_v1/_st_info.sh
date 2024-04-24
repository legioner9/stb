#!/bin/bash

_st_info() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    if ! [[ -d ${PPWD} ]]; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/${FNN}.sh , line=${LINENO}, ${FNN}() : \${PWD} NOT_DIR : 'file://${PPWD}' : ${hint} : return 1"
        return 1
    fi

    # echo -e "${CYAN}--- start : ${FNN}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FNN} :: only message
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : _edit body      : _edit ${HOME}/.st.rc.d/.st.sh.d/_st_info.sh
    _t : _edit tst_dir   : _edit ${HOME}/.st.rc.d/.st.tst.d/_st_info.tst.d
    _d : exec tst_dir_fn : . ${HOME}/.st.rc.d/.st.tst.d/_st_info.tst.d/_st_info.tst.sh
EXAM: 
    ${FNN}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_st_info.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_st_info.tst.d
        return 0
    fi

    if [[ "_d" == "$1" ]]; then
        . ${HOME}/.st.rc.d/.st.tst.d/_st_info.tst.d/_st_info.tst.sh
        return 0
    fi

    echo -e "${RED}-------- _st_info: ${ARGS[*]} --------${NORMAL}" #sistem info mesage

    cd $PPWD
    return 0

}
