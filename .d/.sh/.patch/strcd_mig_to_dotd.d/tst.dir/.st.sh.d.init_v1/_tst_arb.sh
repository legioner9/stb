#!/bin/bash

_tst_arb() {

    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: 
TAGS:
\$1 
[, \$2]
"
        return 0
    fi

    if ! [[ -f "$1" ]]; then
        echo "in _tst_arb() : arb_lst NOT_FILE : file://$1, hint : '$2' return 1" >&2
        return 1
    fi

    local arb_path
    local ram_name
    local ram_path
    local flag_fail=0

    for arb_path in $(_f2e $1); do
        echo "\${arb_path}=${arb_path}"
        for ram_name in $(_dd2e ${arb_path}); do
            ram_path=${arb_path}/${ram_name}
            tst_path=${ram_path}/.grot/_tst/exec.tst
            # echo "\${tst_path}= file://${tst_path}"
            if [[ -f ${tst_path} ]]; then
                echo ". ${tst_path}"
                if ! . ${tst_path} >/dev/null; then
                    echo "in line=${LINENO}, _tst_arb() : : EXEC_FAIL : '. ${tst_path}'" >&2
                    flag_fail=1
                fi
            fi
        done
    done

    if [[ ${flag_fail} -eq 1 ]]; then
        echo "ANY in $1 fail"
        return 1
    fi
    cd $PPWD
    return 0
}
