#!/bin/bash

_gig_st_rc_fn() {

    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: generate \$1 st_rc_fn like _XXX
TAGS:
\$1 name st_rc_fn
[, \$2]
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_gig_st_rc_fn.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_gig_st_rc_fn.tst.d
        return 0
    fi

    if command -v $1; then
        hint="\$1: name create strs_fn"
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_gig_st_rc_fn.sh , line=${LINENO}, ${FNN}() : : EXEC_TRUE : 'command -v $1' : ${hint} : return 1" >&2
        return 1
    fi

    if [[ -f ${HOME}/.st.rc.d/.st.sh.d/$1.sh ]]; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.tst.d/_gig_st_rc_fn.tst.d , line=${LINENO}, ${FNN}() : FILE_EXIST : '${HOME}/.st.rc.d/.st.sh.d/$1.sh' : ${hint} : return 1" >&2
        return 1
    fi

    # echo -e "${HLIGHT}--- exec: _sd2d _XXX $1 ${HOME}/.st.rc.d/.st.tst.d/_XXX.tst.d ---${NORMAL}" #start files

    if ! _sd2d _XXX $1 ${HOME}/.st.rc.d/.st.tst.d/_XXX.tst.d; then

        echo "in fs= file://${HOME}/.st.rc.d/.st.tst.d/_gig_st_rc_fn.tst.d , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_sd2d _XXX $1 ${HOME}/.st.rc.d/.st.tst.d/_XXX.tst.d' : ${hint} : return 1" >&2
        return 1

    fi

    if ! _sf2f _XXX $1 ${HOME}/.st.rc.d/.st.tst.d/_XXX.tst; then

        echo "in fs= file://${HOME}/.st.rc.d/.st.tst.d/_gig_st_rc_fn.tst.d , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_sd2d _XXX $1 ${HOME}/.st.rc.d/.st.tst.d/_XXX.tst' : ${hint} : return 1" >&2
        return 1

    fi

    if ! _sf2f _XXX $1 ${HOME}/.st.rc.d/.st.sh.d/_XXX.sh; then

        echo "in fs= file://${HOME}/.st.rc.d/.st.tst.d/_gig_st_rc_fn.tst.d , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_sd2d _XXX $1 ${HOME}/.st.rc.d/.st.sh.d/_XXX.sh' : ${hint} : return 1" >&2
        return 1

    fi

    # if ! [[ -f ${HOME}/.st.rc.d/.st.sh.d/$1.sh ]]; then

    #     cp ${HOME}/.st.rc.d/.st.sh.d/_XXX.sh ${HOME}/.st.rc.d/.st.sh.d/$1.sh
    #     _s2f '_XXX' $1 ${HOME}/.st.rc.d/.st.sh.d/$1.sh

    # fi

    # if ! [[ -d ${HOME}/.st.rc.d/.st.tst.d/$1.tst.d ]]; then

    #     mkdir ${HOME}/.st.rc.d/.st.tst.d/$1.tst.d
    #     cp ${HOME}/.st.rc.d/.st.tst.d/_XXX.tst.d/_XXX.tst.sh ${HOME}/.st.rc.d/.st.tst.d/$1.tst.d/$1.tst.sh
    #     _s2f '_XXX' $1 ${HOME}/.st.rc.d/.st.tst.d/$1.tst.d/$1.tst.sh

    #     touch ${HOME}/.st.rc.d/.st.tst.d/$1.tst.d/res
    #     touch ${HOME}/.st.rc.d/.st.tst.d/$1.tst.d/pre

    # fi

    # if ! [[ -d ${HOME}/.st.rc.d/.st.tst.d/$1.tst.d/tst.d ]]; then
    #     mkdir ${HOME}/.st.rc.d/.st.tst.d/$1.tst.d/tst.d
    #     touch ${HOME}/.st.rc.d/.st.tst.d/$1.tst.d/tst.d/0
    # fi

    # if ! [[ -f ${HOME}/.st.rc.d/.st.tst.d/$1.tst ]]; then
    #     cp ${HOME}/.st.rc.d/.st.tst.d/_XXX.tst ${HOME}/.st.rc.d/.st.tst.d/$1.tst
    #     _s2f '_XXX' $1 ${HOME}/.st.rc.d/.st.tst.d/$1.tst
    # fi

    return 0

}
