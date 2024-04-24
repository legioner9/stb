#!/bin/bash

_str_lib_lst() {
    # echo -e "${CYAN}--- _str_lib_lst() ---${NORMAL}" #started functions

    if [ "-h" == "$1" ]; then
        echo -e "
MAIN: ${FUNCNAME} :: _f2e \${HOME}/.st.rc.d/.st.lst
TAGS:
\$1 
[, \$2]
"
        return 0
    fi

    local item

    for item in $(_f2e ${HOME}/.st.rc.d/.st.lst); do
        echo $(basename $item)
    done

    cd $PPWD
    return 0

}
