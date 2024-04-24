#!/bin/bash

_isn_from() {

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
MAIN: ${FNN} :: true if \$1 < \$2 or \$1 >\$3
TAGS:
\$1 
\$2 
\$3 
\$4 message
[, \$2]
CNTL: 
    _e : _edit body      : _edit ${HOME}/.st.rc.d/.st.sh.d/_isn_from.sh
    _t : _edit tst_dir   : _edit ${HOME}/.st.rc.d/.st.tst.d/_isn_from.tst.d
    _d : exec tst_dir_fn : . ${HOME}/.st.rc.d/.st.tst.d/_isn_from.tst.d/_isn_from.tst.sh
EXAM: 
    ${FNN}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_isn_from.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_isn_from.tst.d
        return 0
    fi

    if [[ "_d" == "$1" ]]; then
        . ${HOME}/.st.rc.d/.st.tst.d/_isn_from.tst.d/_isn_from.tst.sh
        return 0
    fi

    if _isn_od "$1"; then
        _st_err "in fs= file://${ST_RC_D_PATH}/.st.sh.d/_isn_from.sh , line=${LINENO}, ${FNN}() : NOT_NUMBER : '\$1=$1' : return 0"
        return 0
    fi

    if _isn_od "$2"; then
        _st_err "in fs= file://${ST_RC_D_PATH}/.st.sh.d/_isn_from.sh , line=${LINENO}, ${FNN}() : NOT_NUMBER : '\$2=$2' : return 0"
        return 0
    fi

    if _isn_od "$3"; then
        _st_err "in fs= file://${ST_RC_D_PATH}/.st.sh.d/_isn_from.sh , line=${LINENO}, ${FNN}() : NOT_NUMBER : '\$3=$3' : return 0"
        return 0
    fi

    if [[ "$2" -gt "$3" ]]; then
        _st_err "in fs= file://${ST_RC_D_PATH}/.st.sh.d/_isn_from.sh , line=${LINENO}, ${FNN}() : message '$4': EXEC_FAIL : not $2 <= $3"
        return 0
    fi

    if [[ "$1" -ge "$2" ]] && [[ "$1" -le "$3" ]]; then
        return 1
    else
        _st_err "in fs= file://${ST_RC_D_PATH}/.st.sh.d/_isn_from.sh , line=${LINENO}, ${FNN}() : message '$4': EXEC_FAIL : $1: not >= $2 and <= $3"
        return 0
    fi

    cd $PPWD
    return 0

}
