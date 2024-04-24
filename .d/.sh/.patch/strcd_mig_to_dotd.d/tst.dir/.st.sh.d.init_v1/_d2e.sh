#!/bin/bash

_d2e() {

    # echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FUNCNAME} :: like ls exclude [ "\${item:0:1}" != \"_\" ] - nnodes
TAGS:
\$1 dir
[, \$2]
CNTL: 
    _e : bady    : _edit ${HOME}/.st.rc.d/.st.sh.d/_d2e.sh
    _t : tst_dir : _edit ${HOME}/.st.rc.d/.st.tst.d/_d2e.tst.d
EXAM: 
    ${FUNCNAME}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_d2e.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_d2e.tst.d
        return 0
    fi


    if [[ -z "$1" ]]; then
        echo "in _d2e() : \$1 NOT_DEFINE : '$1', hint : '$2' return 1" >&2
        return 1
    fi

    if ! [[ -d "$1" ]]; then
        echo "in _d2e() : NOT_DIR : '\$1= file://$1 ', hint : '$2' return 1" >&2
        return 1
    fi

    local item

    for item in $(ls "$1"); do
        if { [ -d "$1/$item" ] || [ -f "$1/$item" ]; } && [ "${item:0:1}" != "_" ]; then
            echo "$item"
        fi
    done

    return 0

}
