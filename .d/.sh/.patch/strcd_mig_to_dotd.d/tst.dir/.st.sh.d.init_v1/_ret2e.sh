#!/bin/bash

_ret2e() {

    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: echo return \$@
TAGS:
\$@ command with args
[, \$2]
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_s2se.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_s2se.tst.d
        return 0
    fi

    "$@" &>/dev/null
    echo $?

    cd $PPWD
    return 0

}
