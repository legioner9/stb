#!/bin/bash

_dSYd() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FUNCNAME} :: rsync mirror dir_src path \$1 to dir_dist path \$2 
TAGS:
\$1 src dir
\$2 dist dir
[, \$2]
CNTL: 
    _e : body    : _edit ${HOME}/.st.rc.d/.st.sh.d/_dSYd.sh
    _t : tst_dir : _edit ${HOME}/.st.rc.d/.st.tst.d/_dSYd.tst.d
EXAM: 
    ${FUNCNAME}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_dSYd.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_dSYd.tst.d
        return 0
    fi

    #! ptr_path
    local src_dir="$1"
    if ! _abs_path "${PPWD}" src_dir; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_dSYd.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} init_dir' : ${hint} : return 1" >&2
        return 1
    fi
    src_dir="$(_abs_path "${PPWD}" "src_dir")"

    if ! [[ -d $src_dir ]]; then
        hint="\$1: src_dir"
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_dSYd.sh , line=${LINENO}, ${FNN}() : NOT_DIR : 'file://$src_dir' : ${hint} : return 1"
        return 1
    fi
    #[[ptr_path_s]]

    #! ptr_path
    local dist_dir="$2"
    if ! _abs_path "${PPWD}" dist_dir; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_dSYd.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} dist_dir' : ${hint} : return 1" >&2
        return 1
    fi
    dist_dir="$(_abs_path "${PPWD}" "dist_dir")"

    if ! [[ -d $dist_dir ]]; then
        hint="\$2: dist_dir"
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_dSYd.sh , line=${LINENO}, ${FNN}() : NOT_DIR : 'file://$dist_dir' : ${hint} : return 1"
        return 1
    fi
    #[[ptr_path_s]]

    if ! rsync -azvtu --delete $1/ $2; then
        hint="\$1: src_dir \$2: dist_dir"
        plt_exit "in fs= file:// , line=${LINENO}, ${FNN}() : : EXEC_FAIL : 'rsync -avzu --delete $1/ $2' : ${hint} : return 1"
        return 1
    fi

    if ! diff -qr $1 $2 >/dev/null; then
        echo "in file://${HOME}/.st.rc.d/.st.sh.d/_dSYd.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : 'diff -qr $1 $2 >/dev/null' : ${hint} : return 1" >&2
        diff -r $1 $2 >&2
        return 1
    fi

    return 0

}
