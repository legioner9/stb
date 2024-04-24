#!/bin/bash

_parr3e() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")

    local ARGS0="$1"
    local ARGS1="$2"
    local ARGS2="$3"
    local ARGS3="$4"

    local NARGS=$#

    if ! [[ -d ${PPWD} ]]; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/${FNN}.sh , line=${LINENO}, ${FNN}() : \${PWD} NOT_DIR : 'file://${PPWD}' : ${hint} : return 1"
        return 1
    fi

    # echo -e "${CYAN}--- start : ${FNN}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FNN} :: \$1: parr treat echo
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : _edit body      : _edit ${HOME}/.st.rc.d/.st.sh.d/_parr3e.sh
    _t : _edit tst_dir   : _edit ${HOME}/.st.rc.d/.st.tst.d/_parr3e.tst.d
    _d : exec tst_dir_fn : . ${HOME}/.st.rc.d/.st.tst.d/_parr3e.tst.d/_parr3e.tst.sh
EXAM: 
    ${FNN}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_parr3e.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_parr3e.tst.d
        return 0
    fi

    if [[ "_d" == "$1" ]]; then
        . ${HOME}/.st.rc.d/.st.tst.d/_parr3e.tst.d/_parr3e.tst.sh
        return 0
    fi

    hint="\$1: parr treat echo"
    if _isn_from ${NARGS} 1 1 "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_parr3e.sh, line=${LINENO}, ${FNN}() : DEMAND '2' ERR_AMOUNT_ARGS entered :'${NARGS}' args : ${hint} : return 1"; then
        return 1
    fi

    local vlu_arg_0=
    eval vlu_arg_0=\$\{"${ARGS0}"[0]\}

    # echo -e "${GREEN}\$vlu_arg_0 = $vlu_arg_0${NORMAL}" #print variable

    if [[ -z "${vlu_arg_0}" ]]; then
        _st_err "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_parr3e.sh , line=${LINENO}, ${FNN}() : NOT_DEFINE : 'vlu ${ARGS0}' : ${hint} "
    fi

    eval num=\$\{#"${ARGS0}"[@]\}

    # echo -e "${GREEN}\$num = $num${NORMAL}" #print variable

    for ((i = 0; i < ${num}; i++)); do
        eval echo "\\\${\${ARGS0}[$i]} = \${${ARGS0}[$i]}"
    done

    cd $PPWD
    return 0

}
