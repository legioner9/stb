#!/bin/bash

_f2ad() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")

    local ARGS0="$1"
    local ARGS1="$2"
    local ARGS2="$3"
    local ARGS3="$4"

    local NARGS=$#

    local sh_file=${HOME}/.st.rc.d/.st.sh.d/${FNN}.sh
    local tst_file=${HOME}/.st.rc.d/.st.tst.d/${FNN}.sh
    local tst_dir=${HOME}/.st.rc.d/.st.tst.d/${FNN}.tst.d
    local tst_dir_file=${tst_dir}/${FNN}.tst.sh

    if ! [[ -d ${PPWD} ]]; then
        echo "in fs= file://${sh_file} , line=${LINENO}, ${FNN}() : \${PWD} NOT_DIR : 'file://${PPWD}' : ${hint} : return 1"
        return 1
    fi

    echo -e "${CYAN}--- start : ${FNN}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FNN} :: insert \$1 file after str \$2 in ALL (without prevent) file from dir \$3
TAGS:
\$1 reciver_string
\$2 inserter_string
\$3 reciver_result_dir
[, \$2]
CNTL: 
    _e : _edit body      : _edit ${sh_file}
    _t : _edit tst_dir   : _edit ${tst_dir}
    _d : exec tst_dir_fn : . ${tst_dir_file}
NB!!: escaping in \$2 '\[' '\]' '\\\$' '\^' '\\\\\'
EXAM: 
    ${FNN}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${sh_file}
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${tst_dir}
        return 0
    fi

    if [[ "_d" == "$1" ]]; then
        . ${tst_dir_file}
        return 0
    fi

    hint="insert \$1 file after str \$2 in ALL (without prevent) file from dir \$3"
    if _isn_from ${NARGS} 3 3 "in fs= file://${fn_sh_file}, line=${LINENO}, ${FNN}() : DEMAND '3' ERR_AMOUNT_ARGS entered :'${NARGS}' args : ${hint} : return 1"; then
        return 1
    fi

    #! ptr_path_1
    local ptr_path_1="$1"
    if ! _abs_path "${PPWD}" ptr_path_1; then
        echo "in fs= file://${HOME} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} ptr_path_1' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi
    ptr_path_1="$(_abs_path "${PPWD}" "ptr_path_1")"
    #[[ptr_path_s]]

    #! ptr_path_3
    local ptr_path_3="$3"
    if ! _abs_path "${PPWD}" ptr_path_3; then
        echo "in fs= file://${HOME} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} ptr_path_3' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi
    ptr_path_3="$(_abs_path "${PPWD}" "ptr_path_3")"
    #[[ptr_path_s]]

    file_inserter=${ptr_path_1}
    str_reciver=${ARGS1}
    dir_reciver=${ptr_path_3}

    __inner_f2ad() { # $1 dir to treat
        local item
        for item in $(ls -A $1); do

            if [[ -d $1/${item} ]]; then
                __inner_f2ad $1/${item}
            fi

            if [[ -f $1/${item} ]]; then
                if ! _f2f "${file_inserter}" "${str_reciver}" $1/${item}; then
                    _st_exit "in fs= file://${sh_file} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : ' _f2f file://${file_inserter} ${str_reciver} file://$1/${item}' : return 1"
                    return 1
                fi
            fi

        done
    }

    __inner_f2ad ${dir_reciver}

    cd $PPWD
    return 0

}
