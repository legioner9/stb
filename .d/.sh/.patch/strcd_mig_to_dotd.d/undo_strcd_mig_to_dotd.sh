#!/bin/bash

read -p "DO? undo_strcd_mig_to_dotd"

if ! [[ -d ${HOME}/.d/.rc.d ]]; then
    mkdir -p ${HOME}/.d/.rc.d
fi

if ! [[ -d ${HOME}/.d/.path.d ]]; then
    mkdir -p ${HOME}/.d/.path.d
fi

#* tst st.sh.d.res

# cd ${HOME}/REPOBARE/_repo/mane/.d/.sh/.patch/strcd_mig_to_dotd.d/tst.dir || {
#     echo "EXEC_FAIL : cd ${HOME}/REPOBARE/_repo/mane/.d/.sh/.patch/strcd_mig_to_dotd.d/tst.dir" >&2
#     return 1
# }

# rm -r .st.sh.d.res
# cp -r ./.st.sh.d.init/. ./.st.sh.d.res

# _s2ad "/.st.rc.d" "/.d/.rc.d/.st.rc.d" ".st.sh.d.res"
#*

#* do /.st.rc.d----------
if [[ -d ${HOME}/~.st.rc.d~ ]]; then
    rm -r ${HOME}/.st.rc.d
    mkdir ${HOME}/.st.rc.d
    cp -r ${HOME}/~.st.rc.d~/. ${HOME}/.st.rc.d
else
    echo "NOT_DIR ${HOME}/~.st.rc.d~"
fi
#*------------------

#* do .bashrc

if [[ -f ${HOME}/~.bashrc~ ]]; then
    rm ${HOME}/.bashrc
    cp ${HOME}/~.bashrc~ ${HOME}/.bashrc
else
    echo "NOT_FILE ${HOME}/~.bashrc~"
fi
#*

#* do .mane.rc

if [[ -f ${HOME}/~.mane.rc~ ]]; then
    rm ${HOME}/.d/.rc.d/.mane.rc
    rm ${HOME}/.mane.rc
    cp ${HOME}/~.mane.rc~ ${HOME}/.mane.rc
else
    echo "NOT_FILE ${HOME}/~.mane.rc~ "
fi

#* do .st_rc_d.rc
# rm ${HOME}/.d/.rc.d/.st_rc_d.rc
# cp ${HOME}/.st_rc_d.rc ${HOME}/.d/.rc.d

if [[ -f ${HOME}/~.st_rc_d.rc~ ]]; then
    rm ${HOME}/.d/.rc.d/.st_rc_d.rc
    rm ${HOME}/.st_rc_d.rc
    cp ${HOME}/~.st_rc_d.rc~ ${HOME}/.st_rc_d.rc
else
    echo "NOT_FILE ${HOME}/~.st_rc_d.rc~ "
fi

if ! _is_rr; then
    hint="\$1: \$2: "
    _st_exit "in fs= file://${HOME}/REPOBARE/_repo/sta/.d/.sh/.patch/strcd_mig_to_dotd.d/strcd_mig_to_dotd.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_is_rr' : ${hint} : return 1"
    return 1
fi