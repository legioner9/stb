#!/bin/bash

_elib() {

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

    _edit ${HOME}/.st.rc.d/.st.lst

}
