#!/bin/bash

_s2se() {

    # echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FUNCNAME} :: stdout \$1 reciver_string \$2 inserter_string \$3 reciver_result_string
TAGS:
\$1 reciver_string
\$2 inserter_string
\$3 reciver_result_string
CNTL: 
    _e : body    : _edit ${HOME}/.st.rc.d/.st.sh.d/_s2se.sh
    _t : tst_dir : _edit ${HOME}/.st.rc.d/.st.tst.d/_s2se.tst.d
NB!!: escaping in \$2 '\[' '\]' '\\\$' '\^' '\\\\\'
EXAM: 
    ${FUNCNAME}
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

    echo "$3" | sed "s|$1|$2|g"

    cd $PPWD
    return 0

}
