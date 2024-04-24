#!/bin/bash

# for prod

read -p "DO? strcd_mig_to_dotd"

rm -r ${HOME}/.d/

if ! [[ -d ${HOME}/.d/.rc.d ]]; then
    mkdir -p ${HOME}/.d/.rc.d
fi

if ! [[ -d ${HOME}/.d/.path.d ]]; then
    mkdir -p ${HOME}/.d/.path.d
fi

cp ${HOME}/.mane.path ${HOME}/.d/.path.d/.mane.path
cp ${HOME}/.st_rc_d.path ${HOME}/.d/.path.d/.st_rc_d.path

#* tst st.sh.d.res

# cd ${HOME}/REPOBARE/_repo/mane/.d/.sh/.patch/strcd_mig_to_dotd.d/tst.dir || {
#     echo "EXEC_FAIL : cd ${HOME}/REPOBARE/_repo/mane/.d/.sh/.patch/strcd_mig_to_dotd.d/tst.dir" >&2
#     return 1
# }

# rm -r .st.sh.d.res
# cp -r ./.st.sh.d.init/. ./.st.sh.d.res

# _s2ad "/.st.rc.d" "/.d/.rc.d/.st.rc.d" ".st.sh.d.res"
#*

#* do /.st.rc.d------------
rm -r ${HOME}/.d/.rc.d/.st.rc.d
cp -r ${HOME}/.st.rc.d/. ${HOME}/.d/.rc.d/.st.rc.d
#! 
rm -r ${HOME}/~.st.rc.d~
#! 
mv ${HOME}/.st.rc.d ${HOME}/~.st.rc.d~

#! zip flow

_s2ad "\.st\.rc\.d\.zip" ".st.rXc.d.zip" ${HOME}/.d/.rc.d/.st.rc.d

_s2ad "/\.st\.rc\.d" "/.d/.rc.d/.st.rc.d" ${HOME}/.d/.rc.d/.st.rc.d

_s2ad "\.st\.rXc\.d\.zip" ".st.rc.d.zip" ${HOME}/.d/.rc.d/.st.rc.d

# _s2ad "/\.d/\.rc\.d/\.st\.rc\.d\.zip" "/.st.rc.d.zip" ${HOME}/.d/.rc.d/.st.rc.d

#*-----------------

echo -e "${HLIGHT}--- exec: cat ${HOME}/.d/.rc.d/.st.rc.d/.st.lst ---${NORMAL}" #start files
cat ${HOME}/.d/.rc.d/.st.rc.d/.st.lst
echo
read -p "see that CAT"
#* do .bashrc----------------
#! 
rm ${HOME}/~.bashrc~
#! 
cp ${HOME}/.bashrc ${HOME}/~.bashrc~
#!
_s2f "/.st.rc.d" "/.d/.rc.d/.st.rc.d" ${HOME}/.bashrc
#*-----------------

#* do .mane.rc-----------------
rm ${HOME}/.d/.rc.d/.mane.rc
cp ${HOME}/.mane.rc ${HOME}/.d/.rc.d
#! 
mv ${HOME}/.mane.rc ${HOME}/~.mane.rc~
#*-----------------

#* do .st_rc_d.rc----------------
rm ${HOME}/.d/.rc.d/.st_rc_d.rc
cp ${HOME}/.st_rc_d.rc ${HOME}/.d/.rc.d
#! 
mv ${HOME}/.st_rc_d.rc ${HOME}/~.st_rc_d.rc~
#*-----------------

#* do .st.lst
read -p "DO? : _s2f /.mane.rc /.d/.rc.d/.mane.rc ${HOME}/.d/.rc.d/.st.rc.d/.st.lst"
_s2f "/\.mane\.rc" "/.d/.rc.d/.mane.rc" ${HOME}/.d/.rc.d/.st.rc.d/.st.lst

read -p "DO? : _s2f /.st_rc_d.rc /.d/.rc.d/.st_rc_d.rc ${HOME}/.d/.rc.d/.st.rc.d/.st.lst"
_s2f "/\.st_rc_d\.rc" "/.d/.rc.d/.st_rc_d.rc" ${HOME}/.d/.rc.d/.st.rc.d/.st.lst
#*-----------------

read -p "DO? : _is_rr"
if ! _is_rr; then
    hint="\$1: \$2: "
    _st_exit "in fs= file://${HOME}/REPOBARE/_repo/sta/.d/.sh/.patch/strcd_mig_to_dotd.d/strcd_mig_to_dotd.sh , line=${LINENO}, ${FNN}() : : EXEC_FAIL : '_is_rr' : ${hint} : return 1"
    return 1
fi
