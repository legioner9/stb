#!/bin/bash

_fnCMPenv() {

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
MAIN: ${FNN} :: compare env ${HOME}/.st.rc.d/.st.config.d/fn_name.sh with real ${HOME}/.st.rc.d/.st.sh.d
TAGS: @cmp @env 
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

    # hint="\$1: \$2: "
    # if _isn_from ${NARGS} LESS MORE "in fs= file://${fn_sh_file}, line=${LINENO}, ${FNN}() : DEMAND 'NNNN' ERR_AMOUNT_ARGS entered :'${NARGS}' args : ${hint} : return 1"; then
    #     return 1
    # fi

    local name_env=${HOME}/.st.rc.d/.st.config.d/fn_name.sh
    local dir_data=${HOME}/.st.rc.d/.st.data.d/_fnCMPenv
    local dir_sh=${HOME}/.st.rc.d/.st.sh.d

    sort ${HOME}/.st.rc.d/.st.config.d/fn_name.sh -o ${HOME}/.st.rc.d/.st.config.d/fn_name.sh

    if [[ -d ${dir_data} ]]; then
        mkdir ${dir_data}
        touch ${dir_data}/0
    fi

    : >${dir_data}/sh.lst
    : >${dir_data}/env.lst

    local item1=

    for item1 in $(ls ${dir_sh}); do
        echo "$(_prs_f -n ${item1})" >>${dir_data}/sh.lst
    done

    local item2=
    local item_arr=()

    for item2 in $(_f2e ${name_env}); do
        item_arr=(${item2//=/ })
        echo ${item_arr[1]} >>${dir_data}/env.lst
    done

    echo -e "${HLIGHT}--- exec: diff ${dir_data}/sh.lst ${dir_data}/env.lst ---${NORMAL}" #start files

    sort ${dir_data}/sh.lst -o ${dir_data}/sh.lst
    sort ${dir_data}/env.lst -o ${dir_data}/env.lst

    echo "diff ${dir_data}/sh.lst ${dir_data}/env.lst" >${dir_data}/diff.lst
    diff ${dir_data}/sh.lst ${dir_data}/env.lst >>${dir_data}/diff.lst

    echo -e "${HLIGHT}--- exec: cat file://${dir_data}/diff.lst ---${NORMAL}" #start files
    cat ${dir_data}/diff.lst

    cd $PPWD
    return 0

}
