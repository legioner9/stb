#!/bin/bash

file_sh="${REPO_PATH}/${name_repo}"/.d/.ham/main/main.fn.lst.d/exec_arb2tst_.sh
file_lst="${REPO_PATH}/${name_repo}"/.d/.ham/main/main.fn.lst.d/_exec_arb2tst_.lst

echo -e "${RED}--- that file://${file_sh} ---${NORMAL}"               #sistem info mesage
echo -e "${HLIGHT}--- arb2tst_() wiwh file://${file_lst} ---${NORMAL}" #start files



if ! [ -f "${file_lst}" ]; then
    plt_info "in file://${file_sh} : NOT_FILE : ' file://${file_lst}' : return 1"
    return 1
fi

if ! arb2tst_ "${file_lst}" tst; then
    plt_info "in file://${file_sh} : FAIL_EXEC : 'arb2tst_() wiwh file://${file_lst}' : return 1"
    return 1
fi

return 0
