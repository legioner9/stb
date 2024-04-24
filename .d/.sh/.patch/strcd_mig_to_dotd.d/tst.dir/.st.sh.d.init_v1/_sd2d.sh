#!/bin/bash

_sd2d() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    # echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" >&2 #sistem info mesage

    if [[ "-h" == "${ARGS[0]}" ]]; then
        echo -e "
MAIN: ${FUNCNAME} :: cp dir \${ARGS[2]} to $(dirname \${ARGS[2]}) with replace \${ARGS[0]} to \${ARGS[1]} in files and name node
TAGS:
\$1 reciver_string
\$2 inserter_string
\$3 reciver_result_dir
CNTL: 
    _e : body fn : _edit ${HOME}/.st.rc.d/.st.sh.d/_sd2d.sh
    _t : tst_dir : _edit ${HOME}/.st.rc.d/.st.tst.d/_sd2d.tst.d

NB!!: escaping in \${ARGS[1]} '\[' '\]' '\\\$' '\^' '\\\\\'
EXAM: 
    ${FUNCNAME}
"
        return 0
    fi

    if [[ "_e" == "${ARGS[0]}" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_sd2d.sh
        return 0
    fi

    if [[ "_t" == "${ARGS[0]}" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_sd2d.tst.d
        return 0
    fi

    if [[ -z "${ARGS[2]}" ]]; then
        echo "\${ARGS[2]} NOT_DEFINE return 1" >&2
        return 1
    fi

    #! ptr_path
    local init_dir="${ARGS[2]}"
    echo -e "${GREEN}\$init_dir = $init_dir${NORMAL}" #print variable

    if ! _abs_path "${PPWD}" init_dir; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_sd2d.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_abs_path ${PPWD} init_dir' : ${hint} : return 1" >&2
        return 1
    fi

    init_dir="$(_abs_path "${PPWD}" "init_dir")"
    #[[ptr_path_s]]

    if ! [[ -d "$init_dir" ]]; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_sd2d.sh , line=${LINENO}, ${FUNCNAME}() : NOT_DIR : 'file://$init_dir' : ${hint} : return 1" >&2
        return 1
    fi

    local reciver=${ARGS[0]}
    local inserter=${ARGS[1]}

    local init_dir_name=$(basename $init_dir)
    local init_dir_base=$(dirname $init_dir)

    echo -e "${HLIGHT}--- exec: _s2se $reciver $inserter $init_dir_name ---${NORMAL}" #start files
    local result_dir_name=$(_s2se $reciver $inserter $init_dir_name)

    # echo -e "${HLIGHT}--- exec: cp -r ${init_dir_base}/${init_dir_name}/. ${init_dir_base}/${result_dir_name} ---${NORMAL}" #start files
    if [[ -d ${init_dir_base}/${result_dir_name} ]]; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_sd2d.sh , line=${LINENO}, ${FNN}() : DIR_EXIST: 'file://${init_dir_base}/${result_dir_namer}' : ${hint} : return 1" >&2
        return 1
    fi

    # echo -e "${HLIGHT}--- exec: mkdir ${init_dir_base}/${result_dir_name}~ ---${NORMAL}" #start files
    mkdir ${init_dir_base}/${result_dir_name}~

    # echo -e "${HLIGHT}--- exec: mv ${init_dir_base}/${init_dir_name}~ ${init_dir_base}/${init_dir_name} ---${NORMAL}" #start files
    mv ${init_dir_base}/${result_dir_name}~ ${init_dir_base}/${result_dir_name}

    # echo -e "${HLIGHT}--- exec: cp -rfv ${init_dir_base}/${init_dir_name}/. ${init_dir_base}/${result_dir_name} ---${NORMAL}" #start files
    cp -rf ${init_dir_base}/${init_dir_name}/. ${init_dir_base}/${result_dir_name}

    local result_dir=${init_dir_base}/${result_dir_name}

    echo -e "${GREEN}\$result_dir = file://$result_dir${NORMAL}" #print variable

    # return 0

    _in_fn_1_sd2d() {

        if ! [[ -d "$1" ]]; then
            echo "in fs=file://${HOME}/.st.rc.d/.st.sh.d/_sd2d.sh, line=${LINENO}, pwd=${PWD} fn=${FUNCNAME}() : NOT_DIR : '${ARGS[0]}'" >&2
            return 1
        fi

        local item
        for item in $(ls -A "$1"); do
            echo -e "${GREEN}\$item = $item${NORMAL}" #print variable

            # echo -e "${HLIGHT}--- exec: echo $item | grep $reciver ---${NORMAL}" #start files
            # echo $item | grep $reciver
            if echo $item | grep $reciver; then
                # echo "--- exec: echo $item | sed \"$reciver | $inserter | g\" "--- #start files
                # echo $item | sed "s|$reciver|$inserter|g"

                echo -e "${HLIGHT}--- exec: _s2se ${ARGS[0]} ${ARGS[1]} $item ---${NORMAL}" #start files
                dest_name=$(_s2se ${ARGS[0]} ${ARGS[1]} $item)

                dest_path=$1/$dest_name
                src_path=$1/$item

                # echo -e "${HLIGHT}--- exec: mv $src_path $dest_path ---${NORMAL}" #start files
                mv $src_path $dest_path
            else
                dest_path=$1/$item
            fi

            if [[ -f $dest_path ]]; then
                echo -e "${HLIGHT}--- exec: _s2f ${ARGS[0]} ${ARGS[1]} $dest_path ---${NORMAL}" #start files
                _s2f ${ARGS[0]} ${ARGS[1]} $dest_path

            elif [[ -d $dest_path ]]; then

                if ! _in_fn_1_sd2d $dest_path; then
                    echo "in fs=file://${HOME}/.st.rc.d/.st.sh.d/_sd2d.sh, line=${LINENO}, pwd=${PWD} fn=${FUNCNAME}() : EXEC_FAIL : '_in_fn_1_sd2d file://$dest_path' return 1" >&2
                    return 1
                fi

            else
                echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_sd2d.sh , line=${LINENO}, _in_fn_1_sd2d() : NOT_DIR or NOT_FILE : 'file://$dest_path' : ${hint} : return 1" >&2
                return 1
            fi

        done

    }

    # _in_fn_1_sd2d ${result_dir}

    if ! _in_fn_1_sd2d $result_dir; then
        echo "in fs=file://${HOME}/.st.rc.d/.st.sh.d/_sd2d.sh, line=${LINENO}, pwd=${PWD} fn=${FUNCNAME}() : EXEC_FAIL : '_in_fn_1_sd2d $init_dir' return 1" >&2
        return 1
    fi

    cd $PPWD
    return 0

}
