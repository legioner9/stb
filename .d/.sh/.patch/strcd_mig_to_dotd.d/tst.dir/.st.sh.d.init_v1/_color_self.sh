#!/bin/bash

_color_self() {

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

    INVER='\033[33;5;7m' # ${INVER}# инверсия
    MIG='\e[41m'         # ${MIG}# мигание
    BLACK='\033[0;30m'   # ${BLACK} # чёрный цвет знаков
    RED='\033[0;31m'     # ${RED} # красный цвет знаков
    GREEN='\033[0;32m'   # ${GREEN} # зелёный цвет знаков
    YELLOW='\033[0;33m'  # ${YELLOW} # желтый цвет знаков
    BLUE='\033[0;34m'    # ${BLUE} # синий цвет знаков
    MAGENTA='\033[0;35m' # ${MAGENTA} # фиолетовый цвет знаков
    CYAN='\033[0;36m'    # ${CYAN} # цвет морской волны знаков
    GRAY='\033[0;37m'    # ${GRAY} # серый цвет знаков

    BGBLACK='\033[40m'   # ${BGBLACK}
    BGRED='\033[41m'     # ${BGRED}
    BGGREEN='\033[42m'   # ${BGGREEN}
    BGBROWN='\033[43m'   # ${BGBROWN}
    BGBLUE='\033[44m'    # ${BGBLUE}
    BGMAGENTA='\033[45m' # ${BGMAGENTA}
    BGCYAN='\033[46m'    # ${BGCYAN}
    BGGRAY='\033[47m'    # ${BGGRAY}
    BGDEF='\033[49m'     # ${BGDEF}
    HLIGHT='\033[1m' # ${HLIGHT} жирный шрифт (интенсивный цвет)
    ULINE='\033[4m'  # ${ULINE} подчеркивание
    LLIGHT='\033[2m' # ${LLIGHT} полу яркий цвет (тёмно-серый, независимо от цвета)

    NORMAL='\033[0m' # ${NORMAL} # все атрибуты по умолчанию
}

_color_self @

