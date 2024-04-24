#!/bin/bash

_re() {

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

    local lst_path=${HOME}/.st.rc.d/.st.lst
    if eval "grep '^\${HOME}/$1' ${lst_path}"; then
        eval "sed -i 's|\${HOME}/$1|#\${HOME}/"$1"|g' ${lst_path}"
    else
        if eval "grep '^\#\${HOME}/$1' ${lst_path}"; then
            eval "sed -i 's|#\${HOME}/$1|\${HOME}/$1|g' ${lst_path}"
        else
            echo "file://${HOME}/$1 NOT_INCLUDE in file://${lst_path}" >&2
        fi
    fi

    cd $PPWD
    return 0
}
