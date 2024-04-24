#!/bin/bash

read -p "DO? strcd_mig_to_dotd"



#* tst st.sh.d.res

cd ${HOME}/REPOBARE/_repo/sta/.d/.sh/.patch/strcd_mig_to_dotd.d/tst.dir || {
    echo "EXEC_FAIL : cd ${HOME}/REPOBARE/_repo/sta/.d/.sh/.patch/strcd_mig_to_dotd.d/tst.dir" >&2
    return 1
}

rm -r .st.sh.d.res
cp -r ./.st.sh.d.init/. ./.st.sh.d.res

_s2ad "/\.st\.rc\.d" "/.d/.rc.d/.st.rc.d" ".st.sh.d.res"

cat .st.sh.d.res/.st.lst

#*

