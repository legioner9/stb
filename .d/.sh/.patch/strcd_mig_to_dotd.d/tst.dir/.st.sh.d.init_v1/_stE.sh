#!/bin/bash

_stE() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FUNCNAME} :: catalog strc_fn form ${HOME}/.st.rc.d/st.sh.d
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : body    : _edit ${HOME}/.st.rc.d/.st.sh.d/_stE.sh
    _t : tst_dir : _edit ${HOME}/.st.rc.d/.st.tst.d/_stE.tst.d
EXAM: 
    ${FUNCNAME}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_stE.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_stE.tst.d
        return 0
    fi

    local item=
    local dir_sh=${HOME}/.st.rc.d/.st.sh.d
    local fn_name=

    for item in $(ls ${dir_sh}); do
        fn_name=$(_prs_f -n $item)
        echo -e "${RED}--- $fn_name ---${NORMAL}"               #exit 1
        echo -e "${BLUE}PATH : file://${dir_sh}/$item${NORMAL}" #sistem info mesage
        echo -e "${CYAN}$($fn_name -h | grep 'MAIN')${NORMAL}"  #sistem info mesage
        echo -e "${CYAN}$($fn_name -h | grep 'TAGS')${NORMAL}"  #sistem info mesage
    done

    cd $PPWD
    return 0

}
