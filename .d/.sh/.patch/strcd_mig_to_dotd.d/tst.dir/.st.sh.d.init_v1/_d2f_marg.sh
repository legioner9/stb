#!/bin/bash

_d2f_marg() {

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
MAIN: ${FNN} :: \$1 file result (3d arg _d2f) \$2 0 or num  or '-h' (menu from st.d/.mul/_d2f_marg/x.h) flow from ${HOME}/.st.rc.d/.st.d/.mul/_d2f_marg (1d arg _d2f: x.flow/x.insert.d, 2d arg _d2f: x.flow/x.tml )
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : _edit body      : _edit ${sh_file}
    _t : _edit tst_dir   : _edit ${tst_dir}
    _d : exec tst_dir_fn : . ${tst_dir_file}
    _h_mm: menu from ${HOME}/.st.rc.d/.st.d/.mul/_d2f_marg files x.h
    _E : cat from ${HOME}/.st.rc.d/.st.d/.mul/_d2f_marg all files x.h
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

    __help_mm_d2f_marg() {

        local path_mul=${HOME}/.st.rc.d/.st.d/.mul/_d2f_marg
        local arr=()

        arr=($(_df2e ${path_mul}))

        local __help_result=

        _nr2mm arr arr __help_result 0

        cat ${path_mul}/${__help_result}
    }

    if [[ "_h_mm" == "$1" ]]; then
        #! menu from ${HOME}/.st.rc.d/.st.d/.mul/_d2f_marg files x.h
        __help_mm_d2f_marg
        return 0
    fi

    __E_mm_d2f_marg() {

        local path_mul=${HOME}/.st.rc.d/.st.d/.mul/_d2f_marg
        local item=
        for item in $(_df2e ${path_mul}); do
            _f2e ${path_mul}/${item}
        done
    }

    if [[ "_E" == "$1" ]]; then
        #! catalog all ${HOME}/.st.rc.d/.st.d/.mul/_d2f_marg files x.h
        __E_mm_d2f_marg
        return 0
    fi

    if _isn_od ${ARGS1}; then
        hint="\$1 file result (3d arg _d2f) \$2 0 or num flow from ${HOME}/.st.rc.d/.st.d/.mul/_d2f_marg (1d arg _d2f: x.flow/x.insert.d, 2d arg _d2f: x.flow/x.tml )"
        _st_exit "in fs= file://${fn_sh_file} , line=${LINENO}, ${FNN}() : NOT_NUMBER : '${ARGS1}' : ${hint} : return 1"
        return 1
    fi

    hint="\$1 file result (3d arg _d2f) \$2 0 or num flow from ${HOME}/.st.rc.d/.st.d/.mul/_d2f_marg (1d arg _d2f: x.flow/x.insert.d, 2d arg _d2f: x.flow/x.tml )"
    if _isn_from ${NARGS} 2 2 "in fs= file://${fn_sh_file}, line=${LINENO}, ${FNN}() : DEMAND '2' ERR_AMOUNT_ARGS entered :'${NARGS}' args : ${hint} : return 1"; then
        return 1
    fi

    #! ptr_path_1
    local ptr_path_1="${ARGS0}"
    if ! _abs_path "${PPWD}" ptr_path_1 >/dev/null; then
        echo "in fs= file://${sh_file} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} ptr_path_1' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi

    ptr_path_1="$(_abs_path "${PPWD}" "ptr_path_1")"

    # echo -e "${GREEN}\$ptr_path_1 = $ptr_path_1${NORMAL}" #print variable

    local file_result=$ptr_path_1

    local arr_flow=()
    local res=()
    local item=
    local path_mul=${HOME}/.st.rc.d/.st.d/.mul/_d2f_marg

    arr_flow=($(_dd2e ${path_mul}))

    for item in ${arr_flow[@]}; do
        res+=("${path_mul}/${item}")
    done

    local res_nr2mm=

    _nr2mm arr_flow res res_nr2mm ${ARGS1}

    echo -e "${GREEN}\$res_nr2mm = $res_nr2mm${NORMAL}" #print variable

    local name_flow=$(_prs_f -n $res_nr2mm)

    if ! _d2f $res_nr2mm/$name_flow.insert.d $res_nr2mm/$name_flow.tml $file_result >/dev/null; then
        hint=
        _st_exit "in fs= file://${sh_file} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_d2f $res_nr2mm/$name_flow.insert.d $res_nr2mm/$name_flow.tml $file_result' : ${hint} : return 1"
        return 1
    fi

    cd $PPWD
    return 0

}
