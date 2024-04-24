#!/bin/bash

_arb_up() {
    echo -e "${CYAN}--- _arb_up() \$1 = $1---${NORMAL}" #started functions

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: 
TAGS:
\$1 
[, \$2]
"
        return 0
    fi

    local arg0="$1"
    local hint="$2"
    local fail_flag=0

    if [[ -d "${arg0}" ]]; then
        cd "${arg0}"
    else
        echo "${arg0} is not dir :: return 1" >&2
        return 1
    fi

    for item in $(ls "${arg0}"); do
        # echo -e "${GREEN}\$item = $item${NORMAL}" #print variable
        item_path=${arg0}/${item}
        if [ -d "$item_path" ] && [ "${item:0:1}" != "_" ]; then

            name_item="${item%.*}"
            local up_name="${arg0}"/$item/.grot/${name_item}.sh
            if [ -f ${up_name} ]; then
                # echo -e "${CYAN}--- . ${up_name} ---${NORMAL}" #sistem info mesage
                if ! . "${up_name}"; then
                    echo "in line=${LINENO}, ${FUNCNAME}() : : EXEC_FAIL : '. file://${up_name}' : ${hint} : fail_flag=1" >&2
                    fail_flag=1
                fi
            else
                echo "in arb_up() : NOT_FILE : file://${up_name} : fail_flag=1" >&2
                fail_flag=1
            fi
        fi
    done

    if [[ ${fail_flag=1} -eq 1 ]]; then
        echo "in line=${LINENO}, ${FUNCNAME}() : : FAIL in dir : 'file://${arg0}' : ${hint} : fail_flag=1" >&2
    fi
}
