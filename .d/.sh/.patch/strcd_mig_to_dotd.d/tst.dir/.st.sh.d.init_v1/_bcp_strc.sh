#!/bin/bash

_bcp_strc() {

    local FNN=${FUNCNAME[0]}
    local PPWD=$PWD
    local ARGS=("$@")
    local NARGS=$#

    if ! [[ -d ${PPWD} ]]; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/${FNN}.sh , line=${LINENO}, ${FNN}() :\
         \${PPWD} root dir NOT_DIR : 'file://${PPWD}' : ${hint} : return 1"
        return 1
    fi

    echo -e "${CYAN}--- start : ${FNN}() $@ ---${NORMAL}" #sistem info mesage

    if [[ "-h" == "$1" ]]; then
        echo -e "
MAIN: ${FNN} :: bcp mirror ~/.st.rc.d to ${ST_SH_D_PATH}/st_rc_d/.d/.st.rc.d
TAGS:
\$1 
[, \$2]
CNTL: 
    _e : body    : _edit ${HOME}/.st.rc.d/.st.sh.d/_bcp_strc.sh
    _t : tst_dir : _edit ${HOME}/.st.rc.d/.st.tst.d/_bcp_strc.tst.d
    _d : exec tst_dir_fn : . ${HOME}/.st.rc.d/.st.tst.d/_bcp_strc.tst.d/_bcp_strc.tst.sh
EXAM: 
    ${FNN}
"
        return 0
    fi

    if [[ "_e" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.sh.d/_bcp_strc.sh
        return 0
    fi

    if [[ "_t" == "$1" ]]; then
        _edit ${HOME}/.st.rc.d/.st.tst.d/_bcp_strc.tst.d
        return 0
    fi

    if [[ -d ${ST_RC_D_PATH}/.d/.zip/tmp ]]; then
        rm -r ${ST_RC_D_PATH}/.d/.zip/tmp
    fi

    if ! _is_rr; then
        echo "in fs= file://${HOME}/.st.rc.d/.st.sh.d/_dpl_strc.sh, line=${LINENO}, ${FNN}()\
         : : EXEC_FAIL : '_is_rr' : return 1" >&2

        cd $PPWD
        return 1

    fi

    if [[ "$_W_CONST" == "w-" ]]; then
        _st_info "\$_W_CONST=$_W_CONST _bcp_strc NOT WORK ; return 0"
        return 0
    fi


    #* BCP .st_rc_d.rc

    if [[ -f ${ST_RC_D_PATH}/.d/.zip/.st_rc_d.rc.zip ]]; then
        rm ${ST_RC_D_PATH}/.d/.zip/.st_rc_d.rc.zip~
        mv ${ST_RC_D_PATH}/.d/.zip/.st_rc_d.rc.zip ${ST_RC_D_PATH}/.d/.zip/.st_rc_d.rc.zip~
    fi

    zip ${ST_RC_D_PATH}/.d/.zip/.st_rc_d.rc.zip ${HOME}/.st_rc_d.rc



    echo -e "${RED}--------------------- _is_dDIFz ${HOME}/.st.rc.d ${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip: --------------------${NORMAL}"
    if _is_dDIFz ${HOME}/.st.rc.d ${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip; then
        echo "in fs= file://${HOME}.st.rc.d/.st.sh.d/_bcp_strc.sh , line=${LINENO}, ${FNN}() : in file://${HOME}/.st.rc.d NOT _is_dDIFz file://${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip :: return 0"

        cd $PPWD
        return 0
    fi

    if _is_yes "DO? ZIP file://${HOME}/.st.rc.d TO file://${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip"; then
        echo -e "${HLIGHT}--- exec: _zip_to file://${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip file://${HOME}/.st.rc.d \
---${NORMAL}" #start files
        if ! _zip_to ${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip ${HOME}/.st.rc.d >/dev/null; then
            echo "in fs= file://${HOME}.st.rc.d/.st.sh.d/_bcp_strc.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL :\
 '_zip_to file://${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip file://${HOME}/.st.rc.d' : ${hint} : return 1" >&2

            cd $PPWD
            return 1
        fi
    else
        cd $PPWD
        return 0
    fi

    mkdir ${ST_RC_D_PATH}/.d/.zip/tmp

    cp ${ST_RC_D_PATH}/.d/.zip/.st.rc.d.zip ${ST_RC_D_PATH}/.d/.zip/tmp
    cd ${ST_RC_D_PATH}/.d/.zip/tmp || {
        echo "NOT_DIR: ${ST_RC_D_PATH}/.d/.zip/tmp return 1"

        cd $PPWD
        return 1
    }

    unzip .st.rc.d.zip >/dev/null

    echo -e "${HLIGHT}--- exec: diff -rq ${ST_RC_D_PATH}/.d/.zip/tmp/.st.rc.d ${HOME}/.st.rc.d\
 ---${NORMAL}" #start files
    if ! diff -rq ${ST_RC_D_PATH}/.d/.zip/tmp/.st.rc.d ${HOME}/.st.rc.d >/dev/null; then
        echo "in fs= file://${HOME}.st.rc.d/.st.sh.d/_bcp_strc.sh , line=${LINENO} : : EXEC_FAIL :\
 'diff ${ST_RC_D_PATH}/.d/.zip/tmp/.st.rc.d ${HOME}/.st.rc.d' : ${hint} : return 1" >&2
        diff -r ${ST_RC_D_PATH}/.d/.zip/tmp/.st.rc.d ${HOME}/.st.rc.d

        cd $PPWD
        return 1
    fi

    rm -r ${ST_RC_D_PATH}/.d/.zip/tmp

    cd $PPWD

    return 0

}
