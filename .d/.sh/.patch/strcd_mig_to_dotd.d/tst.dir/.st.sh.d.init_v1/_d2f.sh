#!/bin/bash

_d2f() {

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
MAIN: ${FNN} :: \$1 dir with <reciver>.insert files \$2 .tml file with {{<reciver>}} \$3 path to file result
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : _edit body      : _edit ${sh_file}
    _t : _edit tst_dir   : _edit ${tst_dir}
    _d : exec tst_dir_fn : . ${tst_dir_file}
EXAM: 
    ${FNN}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit $sh_file}
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

    hint="\$1 dir with <reciver>.insert files \$2 .tml file with {{<reciver>}} \$3 path to file result"
    if _isn_from ${NARGS} 3 3 "in fs= file://${fn_sh_file}, line=${LINENO}, ${FNN}() : DEMAND '3' ERR_AMOUNT_ARGS entered :'${NARGS}' args : ${hint} : return 1"; then
        return 1
    fi

    #! ptr_path_1
    local ptr_path_1="$1"
    if ! _abs_path "${PPWD}" ptr_path_1 >/dev/null; then
        echo "in fs= file://${sh_file} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} ptr_path_1' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi
    ptr_path_1="$(_abs_path "${PPWD}" "ptr_path_1")"

    local dir_insert=$ptr_path_1

    #! ptr_path_2
    local ptr_path_2="$2"
    if ! _abs_path "${PPWD}" ptr_path_2 >/dev/null; then
        echo "in fs= file://${sh_file} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} ptr_path_2' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi
    ptr_path_2="$(_abs_path "${PPWD}" "ptr_path_2")"

    local tml_file=$ptr_path_2

    #! ptr_path_3
    local ptr_path_3="$3"
    if ! _abs_path "${PPWD}" ptr_path_3 >/dev/null; then
        echo "in fs= file://${sh_file} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} ptr_path_3' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi
    ptr_path_3="$(_abs_path "${PPWD}" "ptr_path_3")"

    local result_file=$ptr_path_3

    if [[ -f ${result_file} ]]; then
        hint="result_file not be exist"
        _st_exit "in fs= file://${sh_file} , line=${LINENO}, ${FNN}() :  EXIST_FILE : 'file://${result_file}' : ${hint} : return 1"
        return 1
    fi

    if ! cp ${tml_file} ${result_file}; then
        hint=
        _st_exit "in fs= file://${sh_file} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : 'cp ${tml_file} ${result_file}' : ${hint} : return 1"
        return 1
    fi

    local item=
    local file_insert=
    local reciver=

    for item in $(_d2e $dir_insert); do

        file_insert=${dir_insert}/${item}
        echo -e "${GREEN}\$file_insert = $file_insert${NORMAL}" #print variable
        reciver={{$(_prs_f -n $file_insert)}}
        echo -e "${GREEN}\$reciver = $reciver${NORMAL}" #print variable

        echo -e "${HLIGHT}--- exec: _f2f $file_insert $reciver ${result_file} ---${NORMAL}" #start files
        _f2f $file_insert $reciver ${result_file}

    done

    cd $PPWD
    return 0

}
