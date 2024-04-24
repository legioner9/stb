#!/bin/bash

_zip_to() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    if ! [[ -d ${PPWD} ]]; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_bcp_strc.sh , line=${LINENO}, ${FNN}() : \${PPWD} NOT_DIR : 'file://${PPWD}' : ${hint} : return 1"
        return 1
    fi

    echo -e "${CYAN}--- start : ${FUNCNAME}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FUNCNAME} :: zip \$1 dist file \$2 src node (-f|-d) with check in \${dir_dist}/_zip_to.tmp.d
TAGS: @zip
    \$1 dist file !(be added to file.zip if not ext not .zip)
    \$2 src node
CNTL: 
    _e : body            : _edit ${HOME}/.st.rc.d/.st.sh.d/_zip_to.sh
    _t : tst_dir         : _edit ${HOME}/.st.rc.d/.st.tst.d/_zip_to.tst.d
    _d : exec tst_dir_fn : . ${HOME}/.st.rc.d/.st.tst.d/_zip_to.tst.d/_zip_to.tst.sh
EXAM: 
    ${FUNCNAME}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_zip_to.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_zip_to.tst.d
        return 0
    fi

    if [[ "_d" == "$1" ]]; then
        . ${HOME}/.st.rc.d/.st.tst.d/_zip_to.tst.d/_zip_to.tst.sh
        return 0
    fi

    if [[ -z "$2" ]]; then
        echo "in fs= file:// , line=${LINENO}, ${FNN}() : ERR_AMOUNT_ARGS entered : mast 2 args but: '${NARGS}' args : ${hint} : return 1" >&2
        return 1
    fi

    if ! [[ -f $2 ]] && ! [[ -d $2 ]]; then
        hint="\$1: node to zip"
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_zip_to.sh , line=${LINENO}, ${FNN}() : NOT_DIR or NOT_FILE : 'file://$2' : ${hint} : return 1" >&2
        return 1
    fi

    if ! [[ -d $(dirname $1) ]]; then
        hint="\$2: dir dist"
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_zip_to.sh , line=${LINENO}, ${FNN}() : NOT_DIR : 'file://$(dirname $1)' : ${hint} : return 1" >&2
        return 1
    fi

    path_dist="${ARGS[0]}"
    path_dist=$(_abs_path $PPWD "path_dist")

    if [[ $(_prs_f -e ${path_dist}) != "zip" ]]; then
        path_dist=${path_dist}.zip
    fi

    path_src="${ARGS[1]}"
    path_src=$(_abs_path $PPWD "path_src") #ptr args

    dir_src=$(dirname "${path_src}")
    file_src=$(basename "${path_src}")

    dir_dist=$(dirname "${path_dist}")
    file_dist=$(basename "${path_dist}")

    if [[ -f ${path_dist} ]]; then
        mv ${path_dist} ${path_dist}~
    fi

    if ! cd ${dir_src}; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_zip_to.sh , line=${LINENO}, ${FNN}() : EXEC_FAIL : 'cd ${dir_src}' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi

    if [[ -f ${path_src} ]]; then
        zip "${file_dist}" "${file_src}"
        mv "${file_dist}" "${path_dist}"
        echo -e "${HLIGHT}--- exec: mkdir ${dir_dist}/tmp_$(_rnd2e) ---${NORMAL}" #start files
        tmp_dir=${dir_dist}/_zip_to.tmp.d
        if ! [[ -d ${tmp_dir} ]]; then
            mkdir ${tmp_dir}
        fi
        echo -e "${HLIGHT}--- cp file://${path_dist} file://${tmp_dir} ---${NORMAL}" #start files
        cp ${path_dist} ${tmp_dir}

        echo -e "${HLIGHT}--- exec: cd ${tmp_dir} ---${NORMAL}" #start files
        cd ${tmp_dir} || {
            echo "NOT_DIR : ${tmp_dir} return 1" >&2
            cd $PPWD
            return 1
        }
        echo -e "${HLIGHT}--- exec: unzip -o ${tmp_dir}/${file_dist} ---${NORMAL}" #start files
        unzip -o ${tmp_dir}/${file_dist} 

        # read -p "continue?"

        echo -e "${HLIGHT}--- exec: diff -q file://${tmp_dir}/${file_src} file://${path_src} ---${NORMAL}" #start files
        if ! diff -q ${tmp_dir}/${file_src} ${path_src}; then
            diff ${tmp_dir}/${file_src} ${path_src}
            echo "in fs= file:// , line=${LINENO}, ${FNN}() : : EXEC_FAIL : 'EXEC_EXPERSION' : ${hint} : return 1" >&2
            # read -p "continue?"
            rm -r ${tmp_dir}
            cd $PPWD
            return 1
        fi
        rm -r ${tmp_dir}
    fi

    if ! cd ${dir_src}; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_zip_to.sh , line=${LINENO}, ${FNN}() : EXEC_FAIL : 'cd ${dir_src}' : ${hint} : return 1" >&2
        cd $PPWD
        return 1
    fi

    if [[ -d ${path_src} ]]; then

        echo -e "${HLIGHT}--- exec: zip -vr "${file_dist}" "${file_src}" ---${NORMAL}" #start files
        zip -vr "${file_dist}" "${file_src}"

        mv "${file_dist}" "${path_dist}"
        echo -e "${HLIGHT}--- exec: mkdir ${dir_dist}/_zip_to.tmp.d ---${NORMAL}" #start files
        tmp_dir=${dir_dist}/_zip_to.tmp.d
        if ! [[ -d ${tmp_dir} ]]; then
            mkdir ${tmp_dir}
        fi
        echo -e "${HLIGHT}--- cp file://${path_dist} file://${tmp_dir} ---${NORMAL}" #start files
        cp ${path_dist} ${tmp_dir}

        echo -e "${HLIGHT}--- exec: cd ${tmp_dir} ---${NORMAL}" #start files
        cd ${tmp_dir} || {
            echo "NOT_DIR : ${tmp_dir} return 1" >&2
            cd $PPWD
            return 1
        }
        echo -e "${HLIGHT}--- exec: unzip -o ${tmp_dir}/${file_dist} ---${NORMAL}" #start files
        unzip -o ${tmp_dir}/${file_dist}

        # read -p "continue?"

        echo -e "${HLIGHT}--- exec: diff -qr file://${tmp_dir}/${file_src} file://${path_src} ---${NORMAL}" #start files
        if ! diff -qr ${tmp_dir}/${file_src} ${path_src}; then
            diff -r ${tmp_dir}/${file_src} ${path_src}
            echo "in fs= file:// , line=${LINENO}, ${FNN}() : : EXEC_FAIL : 'EXEC_EXPERSION' : ${hint} : return 1" >&2
            # read -p "continue?"
            rm -r ${tmp_dir}
            cd $PPWD
            return 1
        fi
        rm -r ${tmp_dir}
    fi

    touch ${path_dist}

    cd $PPWD
    return 0

}
