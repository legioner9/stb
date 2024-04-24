#!/bin/bash

_s2ad() {

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
MAIN: ${FNN} :: insert \$1 str into str \$2 in ALL (without prevent) file from dir \$3
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

    hint="insert \$1 str into str \$2 in ALL (without prevent) file from dir \$3"
    if _isn_from ${NARGS} 3 3 "in fs= file://${fn_sh_file}, line=${LINENO}, ${FNN}() : DEMAND '3' ERR_AMOUNT_ARGS entered :'${NARGS}' args : ${hint} : return 1"; then
        return 1
    fi

    #! ptr_path_1
    local ptr_path_3="$3"
    if ! _abs_path "${PPWD}" ptr_path_3; then
        echo "in fs= file://${HOME} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} ptr_path_3' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi
    ptr_path_3="$(_abs_path "${PPWD}" "ptr_path_3")"
    #[[ptr_path_s]]

    local dir_result=${ptr_path_3}

    __inner_s2ad() { # $1 dir to treat
        local item
        for item in $(ls -A $1); do

            if [[ -d $1/${item} ]]; then
                __inner_s2ad $1/${item}
            fi

            if [[ -f $1/${item} ]]; then
                if ! _s2f "${ARGS0}" "${ARGS1}" $1/${item}; then
                    _st_exit "in fs= file://${sh_file} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : ' _s2f ${ARGS0} ${ARGS1} $1/${item}' : return 1"
                    return 1
                fi
            fi

        done
    }

    __inner_s2ad ${dir_result}

    cd $PPWD
    return 0

}
