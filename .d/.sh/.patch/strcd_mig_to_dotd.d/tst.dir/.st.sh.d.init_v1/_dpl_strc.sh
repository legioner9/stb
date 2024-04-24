#!/bin/bash

_dpl_strc() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    if ! [[ -d ${PPWD} ]]; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/${FNN}.sh , line=${LINENO}, ${FNN}() : \${PPWD} NOT_DIR : 'file://${PPWD}' : ${hint} : return 1"
        return 1
    fi

    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FUNCNAME} :: 
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : _edit body      : _edit ${HOME}/.st.rc.d/.st.sh.d/_dpl_strc.sh
    _t : _edit tst_dir   : _edit ${HOME}/.st.rc.d/.st.tst.d/_dpl_strc.tst.d
    _d : exec tst_dir_fn : . ${HOME}/.st.rc.d/.st.tst.d/_dpl_strc.tst.d/_dpl_strc.tst.sh
EXAM: 
    ${FUNCNAME}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_dpl_strc.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_dpl_strc.tst.d
        return 0
    fi

    if [[ "_d" == "$1" ]]; then
        . ${HOME}/.st.rc.d/.st.tst.d/_dpl_strc.tst.d/_dpl_strc.tst.sh
        return 0
    fi

    if ! _is_rr; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_dpl_strc.sh, line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_is_rr' : return 1" >&2
        return 1

    fi

    if ! _is_yes "deploy file://${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip to file://${HOME}/.st.rc.d ?"; then
        echo "answer NOT 'y' : return 0 from _dpl_strc()"
        cd $PPWD
        return 0
    fi

    if [[ -f ${HOME}/.st.rc.d.zip ]]; then
        echo -e "${HLIGHT}--- exec: rm ${HOME}/.st.rc.d.zip ---${NORMAL}" #start files
        rm ${HOME}/.st.rc.d.zip
    fi

    if [[ -f ${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip ]]; then
        cp ${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip ${HOME}
    else
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_dpl_strc.sh , line=${LINENO}, ${FNN}() : NOT_FILE : 'file://${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi

    if [[ -d ${HOME}/.st.rc.d ]]; then
        mv -r ${HOME}/.st.rc.d ${HOME}/.st.rc.d~
    else
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_dpl_strc.sh , line=${LINENO}, ${FNN}() : NOT_DIR : 'file://${HOME}/.st.rc.d' : return 1" >&2
        cd $PPWD
        return 1
    fi

    if ! _unzip_to ${HOME} ${HOME}/.st.rc.d.zip; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_dpl_strc.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_unzip_to ${HOME} ${HOME}/.st.rc.d.zip' : ${hint} : return 1"
        cd $PPWD
        return 1
    fi

    if ! _is_rr; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_dpl_strc.sh, line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_is_rr' : be exec : mv -r ${HOME}/.st.rc.d~ ${HOME}/.st.rc.d" >&2
        if ! mv -r ${HOME}/.st.rc.d~ ${HOME}/.st.rc.d; then
            echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_dpl_strc.sh, line=${LINENO}, ${FNN}() : : EXEC_FAIL : 'mv -r ${HOME}/.st.rc.d~ ${HOME}/.st.rc.d' : return 1" >&2
            cd $PPWD
            return 1
        fi
    fi

    cd $PPWD
    return 0

}
