#!/bin/bash

_sf2f() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FUNCNAME} :: cp file \${ARGS[2]} to $(dirname \${ARGS[2]}) with replace \${ARGS[0]} to \${ARGS[1]} in file and name file
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : body    : _edit ${HOME}/.st.rc.d/.st.sh.d/_sf2f.sh
    _t : tst_dir : _edit ${HOME}/.st.rc.d/.st.tst.d/_sf2f.tst.d
NB!!: escaping in \${ARGS[1]} '\[' '\]' '\\\$' '\^' '\\\\\'
EXAM: 
    ${FUNCNAME}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_sf2f.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_sf2f.tst.d
        return 0
    fi

    if [[ -z "${ARGS[2]}" ]]; then
        echo "\${ARGS[2]} NOT_DEFINE return 1" >&2
        return 1
    fi

    #! ptr_path
    local init_file="${ARGS[2]}"
    echo -e "${GREEN}\$init_dir = $init_dir${NORMAL}" #print variable

    if ! _abs_path "${PPWD}" init_file; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_sf2f .sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} init_dir' : ${hint} : return 1" >&2
        return 1
    fi

    init_file="$(_abs_path "${PPWD}" "init_file")"
    #[[ptr_path_s]]

    if ! [[ -f "$init_file" ]]; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_sf2f.sh , line=${LINENO}, ${FUNCNAME}() : NOT_FILE : 'file://$init_file' : ${hint} : return 1" >&2
        return 1
    fi

    local reciver=${ARGS[0]}
    local inserter=${ARGS[1]}

    local init_file_name=$(basename $init_file)
    local init_file_base=$(dirname $init_file)

    echo -e "${HLIGHT}--- exec: _s2se $reciver $inserter $init_file_name ---${NORMAL}" #start files
    local result_file_name=$(_s2se $reciver $inserter $init_file_name)

    # echo -e "${HLIGHT}--- exec: cp -r ${init_dir_base}/${init_dir_name}/. ${init_dir_base}/${result_dir_name} ---${NORMAL}" #start files
    if [[ -f ${init_file_base}/${result_file_name} ]]; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_sf2f.sh , line=${LINENO}, ${FNN}() : FILE_EXIST: 'file://${init_file_base}/${result_file_name}' : ${hint} : return 1" >&2
        return 1
    fi

    if ! cp ${init_file_base}/${init_file_name} ${init_file_base}/${result_file_name}; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_sf2f.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : 'cp ${init_file_base}/${init_file_name}/. ${init_file_base}/${result_file_name}' : ${hint} : return 1" >&2
        return 1
    fi

    if ! _s2f $reciver $inserter ${init_file_base}/${result_file_name}; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_sf2f.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_s2f $reciver $inserter ${init_file_base}/${result_file_name}' : ${hint} : return 1" >&2
        return 1
    fi

    cd $PPWD
    return 0

}
