#!/bin/bash

_unzip_to() {

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
MAIN: ${FUNCNAME} :: unzip to \$1 dir_dist from zip path_src file [-f]
TAGS:
    \$1 dist dir 
    \$2 src zip file
[, \$2]
CNTL: 
    _e : _edit body      : _edit ${HOME}/.st.rc.d/.st.sh.d/_unzip_to.sh
    _t : _edit tst_dir   : _edit ${HOME}/.st.rc.d/.st.tst.d/_unzip_to.tst.d
    _d : exec tst_dir_fn : . ${HOME}/.st.rc.d/.st.tst.d/_unzip_to.tst.d/_unzip_to.tst.sh
EXAM: 
    ${FUNCNAME}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_unzip_to.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_unzip_to.tst.d
        return 0
    fi

    if [[ "_d" == "$1" ]]; then
        . ${HOME}/.st.rc.d/.st.tst.d/_unzip_to.tst.d/_unzip_to.tst.sh
        return 0
    fi

    if [[ -z "$2" ]]; then
        echo "in fs= file:// , line=${LINENO}, ${FNN}() : ERR_AMOUNT_ARGS entered : mast 2 args but: '${NARGS}' args : ${hint} : return 1" >&2
        return 1
    fi

    if ! [[ -f $2 ]]; then
        hint="\$2: zip file"
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_zip_to.sh , line=${LINENO}, ${FNN}() : NOT_FILE : 'file://$2' : ${hint} : return 1" >&2
        return 1
    fi

    if ! [[ -d $1 ]]; then
        hint="\$1: dir dist"
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_zip_to.sh , line=${LINENO}, ${FNN}() : NOT_DIR : 'file://$1' : ${hint} : return 1" >&2
        return 1
    fi

    path_dist="${ARGS[0]}"
    path_dist=$(_abs_path $PPWD "path_dist")

    path_src="${ARGS[1]}"
    path_src=$(_abs_path $PPWD "path_src") #ptr args

    if [[ $(_prs_f -e ${path_src}) != "zip" ]]; then
        path_src=${path_src}.zip
    fi

    dir_src=$(dirname "${path_src}")
    file_src=$(basename "${path_src}")

    dir_dist=$(dirname "${path_dist}")
    file_dist=$(basename "${path_dist}")

    if [[ $(_prs_f -e ${path_src}) != "zip" ]]; then
        path_src=${path_src}.zip
    fi

    mv ${path_src} ${path_dist}

    cd ${path_dist} || {
        echo "NOT_DIR : ${path_dist} return 1" >&2
        cd $PPWD
        return 1
    }

    unzip -o ${file_src}

    rm ${path_dist}/${file_src}

    cd $PPWD
    return 0

}
