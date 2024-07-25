#!/bin/bash
# https://unix.stackexchange.com/questions/468981/handling-unused-getopts-argument-are-options-not-mandatory
USAGE() { 
    USAGE_GUIDE="
    Usage: bash $0 (below option) \n
\t\t\t\t  [-w <in-dir>] \n
\t\t\t\t  [-o <out-dir>] \n
\t\t\t\t  [-c <template1>] \n
\t\t\t\t  [-t <template>] \n
    \n"
    echo -e ${USAGE_GUIDE} 1>&2; exit 1; 
}

if (($# == 0))
then
    USAGE
fi

build_option1=0;
build_option2=0;
build_option3=0;
build_option4=0;
build_option5=0;
build_option6=0;
build_option7=0;

while getopts 'abcdry:z:' opt
do
  case $opt in
    a) build_option1=1; echo "usage1" ;;
    b) build_option2=1; echo "usage2" ;;
    c) build_option3=1; echo "usage3" ;;
    d) build_option4=1; echo "usage4" ;;
    r) build_option5=1; echo "usage5" ;;
    y) build_option6=$OPTARG; echo "usage7" ;;
    z) build_option7=$OPTARG; echo "usage8" ;;

    # https://www.unix.com/shell-programming-and-scripting/164747-bypass-getopts-errors-continue-processing.html
    ?)  echo "unknown option"
        exit ;;
    :)  echo "Option -$OPTARG requires an argument" >&2
        exit ;;
  esac
done

echo "[Option Check]"