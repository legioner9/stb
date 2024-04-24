#!/bin/bash

_is_dNTf() {

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
MAIN: ${FNN} :: is? cmp dir \$1 recurce any node -nt that \$2 file
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : _edit body      : _edit ${HOME}/.st.rc.d/.st.sh.d/_is_dNTf.sh
    _t : _edit tst_dir   : _edit ${HOME}/.st.rc.d/.st.tst.d/_is_dNTf.tst.d
    _d : exec tst_dir_fn : . ${HOME}/.st.rc.d/.st.tst.d/_is_dNTf.tst.d/_is_dNTf.tst.sh
EXAM: 
    ${FNN}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_is_dNTf.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_is_dNTf.tst.d
        return 0
    fi

    if [[ "_d" == "$1" ]]; then
        . ${HOME}/.st.rc.d/.st.tst.d/_is_dNTf.tst.d/_is_dNTf.tst.sh
        return 0
    fi

    if [[ -z $2 ]]; then
        hint="\$1: is dir -nt that \$2: file"
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_is_dNTf.sh , line=${LINENO}, ${FNN}() : ERR_AMOUNT_ARGS : '{NARGS}=${NARGS}' demand: 2 : ${hint} : return 1" >&2
        return 1
    fi

    #! ptr_path
    local ptr_path_1="$1"
    if ! _abs_path "${PPWD}" ptr_path_1 >/dev/null; then
        echo "in fs= file://${HOME} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} ptr_path_1' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi
    ptr_path_1="$(_abs_path "${PPWD}" "ptr_path_1")"

    local ptr_path_2="$2"
    if ! _abs_path "${PPWD}" ptr_path_2 >/dev/null; then
        echo "in fs= file://${HOME} , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} ptr_path_2' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi
    ptr_path_2="$(_abs_path "${PPWD}" "ptr_path_2")"
    #[[ptr_path_s]]

    local is_flag=1

    recurce__is_dNTf() { # $1 as is? cmp dir

        local item
        for item in $(ls -A $1); do
            # echo -e "${HLIGHT}--- $1/$item -nt $ptr_path_2 ---${NORMAL}" #start files
            if [[ $1/$item -nt $ptr_path_2 ]]; then
                echo "$1/$item"
                is_flag=0
            fi

            if [[ -d $1/$item ]]; then
                recurce__is_dNTf $1/$item
            fi

        done

    }

    recurce__is_dNTf $ptr_path_1

    cd $PPWD
    return $is_flag

}
