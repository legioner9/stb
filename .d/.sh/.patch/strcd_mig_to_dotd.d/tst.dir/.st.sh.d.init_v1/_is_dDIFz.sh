#!/bin/bash

_is_dDIFz() {

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
MAIN: ${FNN} :: is? diff dir \$1 with unzip \$2
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : _edit body      : _edit ${HOME}/.st.rc.d/.st.sh.d/_is_dDIFz.sh
    _t : _edit tst_dir   : _edit ${HOME}/.st.rc.d/.st.tst.d/_is_dDIFz.tst.d
    _d : exec tst_dir_fn : . ${HOME}/.st.rc.d/.st.tst.d/_is_dDIFz.tst.d/_is_dDIFz.tst.sh
EXAM: 
    ${FNN}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_is_dDIFz.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_is_dDIFz.tst.d
        return 0
    fi

    if [[ "_d" == "$1" ]]; then
        . ${HOME}/.st.rc.d/.st.tst.d/_is_dDIFz.tst.d/_is_dDIFz.tst.sh
        return 0
    fi

    if [[ -z $2 ]]; then
        hint="\$1: is dir -nt that \$2: file"
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_is_dDIFz.sh , line=${LINENO}, ${FNN}() : ERR_AMOUNT_ARGS : '{NARGS}=${NARGS}' demand: 2 : ${hint} : return 1" >&2
        return 1
    fi

    #! ptr_path
    local ptr_path_1="$1"
    if ! _abs_path "${PPWD}" ptr_path_1 >/dev/null; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_is_dDIFz.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} ptr_path_1' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi
    ptr_path_1="$(_abs_path "${PPWD}" "ptr_path_1")"

    local ptr_path_2="$2"
    if ! _abs_path "${PPWD}" ptr_path_2 >/dev/null; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_is_dDIFz.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} ptr_path_2' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi
    ptr_path_2="$(_abs_path "${PPWD}" "ptr_path_2")"
    #[[ptr_path_s]]

    zipf_path=${ptr_path_2}
    cmpd_path=${ptr_path_1}

    # echo -e "${GREEN}\$zipf_path = $zipf_path${NORMAL}" #print variable

    if ! [[ -f ${zipf_path} ]]; then
        hint="\$1: cmpd \$2: zipf "
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_is_dDIFz.sh , line=${LINENO}, ${FNN}() :  NOT_FILE : \$2 'file://${zipf_path}' : ${hint} : return 1"
        return 1
    fi

    # echo -e "${GREEN}\$cmpd_path = $cmpd_path${NORMAL}" #print variable

    if ! [[ -d ${cmpd_path} ]]; then
        hint="\$1: cmpd \$2: zipf "
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_is_dDIFz.sh , line=${LINENO}, ${FNN}() :  NOT_DIR : \$1 'file://${cmpd_path}' : ${hint} : return 1"
        return 1
    fi

    dir_zipf=$(dirname "${zipf_path}")
    file_zipf=$(basename "${zipf_path}")

    dir_cmpd=$(dirname "${cmpd_path}")
    file_cmpd=$(basename "${cmpd_path}")

    tmp_dir=${dir_zipf}/_is_dDIFz.tmp.d
    rm -r ${tmp_dir} &>/dev/null

    mkdir ${tmp_dir}
    cp ${zipf_path} ${tmp_dir}

    # echo -e "${HLIGHT}--- exec: unzip -o ${tmp_dir}/${file_zipf} ---${NORMAL}" #start files

    cd ${tmp_dir} || {
        echo "NOT_DIR: ${tmp_dir} return 1" >&2
        return 1
    }
    
    unzip -o ${file_zipf} >/dev/null

    echo -e "${HLIGHT}--- exec: diff -qr file://${cmpd_path} file://${tmp_dir}/${file_cmpd} >/dev/null ---${NORMAL}" #start files

    if ! diff -qr ${cmpd_path} ${tmp_dir}/${file_cmpd} >/dev/null; then

        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_is_dDIFz.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : 'diff -rq ${cmpd_path} ${tmp_dir}/${file_cmpd}' : ${hint} : return 1" >&2
        echo -e "${HLIGHT}--- exec: diff -r file://${cmpd_path} file://${tmp_dir}/${file_cmpd} ---${NORMAL}" >&2 #start files

        diff -r ${cmpd_path} ${tmp_dir}/${file_cmpd}
        rm -r ${tmp_dir} &>/dev/null

        cd $PPWD
        return 1
    fi

    rm -r ${tmp_dir} &>/dev/null

    cd $PPWD
    return 0

}
