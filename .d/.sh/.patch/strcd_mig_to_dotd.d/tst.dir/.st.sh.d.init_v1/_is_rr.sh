#!/bin/bash

_is_rr() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    if ! [[ -d ${PPWD} ]]; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/${FNN}.sh , line=${LINENO}, ${FNN}() : \${PWD} NOT_DIR : 'file://${PPWD}' : ${hint} : return 1"
        return 1
    fi

    echo -e "${CYAN}--- start : ${FNN}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FNN} :: return 1 if _rr with (err or >&2)
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : _edit body      : _edit ${HOME}/.st.rc.d/.st.sh.d/_is_rr.sh
    _t : _edit tst_dir   : _edit ${HOME}/.st.rc.d/.st.tst.d/_is_rr.tst.d
    _d : exec tst_dir_fn : . ${HOME}/.st.rc.d/.st.tst.d/_is_rr.tst.d/_is_rr.tst.sh
EXAM: 
    ${FNN}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_is_rr.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_is_rr.tst.d
        return 0
    fi

    if [[ "_d" == "$1" ]]; then
        . ${HOME}/.st.rc.d/.st.tst.d/_is_rr.tst.d/_is_rr.tst.sh
        return 0
    fi

    # _rr &>${HOME}/.tmp

    if ! _rr &>${HOME}/.tmp; then
        echo "in fs= file://${HOME}.st.rc.d/.st.sh.d/_is_rr.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_rr' : ${hint} :  flag=1" >&2
        flag=1
    fi

    if [[ -n "$(cat ${HOME}/.tmp)" ]]; then
        echo "exec _rr :" >&2
        cat ${HOME}/.tmp >&2
        echo "in fs= file://${HOME}.st.rc.d/.st.sh.d/_is_rr.sh , line=${LINENO}, ${FNN}() : : EXEC_TRUE : '[[ -n \$(cat ${HOME}/.tmp) ]] : ${hint} :  flag=1" >&2
        flag=1
    fi

    if [[ ${flag} -eq 1 ]]; then
        echo "in fs= file://${HOME}.st.rc.d/.st.sh.d/_is_rr.sh , line=${LINENO}, ${FNN}() return 1" >&2
        return 1
    fi

    cd $PPWD
    return 0

}
