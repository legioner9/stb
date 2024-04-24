#!/bin/bash

_f2f() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: insert \$1 file after str \$2 in file \$3
TAGS:
\$1 inserter_file
\$2 reciver_string
\$3 reciver_file
[, \$4 hint]
NB!!: escaping in \$2 '\[' '\]' '\\\$' '\^' '\\\\\'
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_f2f.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_f2f.tst.d
        return 0
    fi

    # sed -e '/{{in}}/{r insert.file' -e 'd;}' receive.file > tmp
    echo -e "${HLIGHT}--- exec: sed -e '/$2/{r $1' -e ';}' $3 >tmp ---${NORMAL}" #start files
    eval "sed -e '\|$2|{r $1' -e ';}' $3 >tmp"

    mv tmp "$3"

    return 0

}
