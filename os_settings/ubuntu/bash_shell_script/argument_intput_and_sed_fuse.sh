#!/bin/bash
# https://unix.stackexchange.com/questions/468981/handling-unused-getopts-argument-are-options-not-mandatory
USAGE() { 
    USAGE_GUIDE="
    Usage: bash $0 (no argument = revert file) \n
\t\t\t\t  [-c change file param for docker env] \n
    \n"
    echo -e ${USAGE_GUIDE} 1>&2; exit 1; 
}

if (($# == 0))
then
    USAGE
fi

build_option1=0;

while getopts 'c' opt
do
  case $opt in
    c) build_option1=1 ;;

    # https://www.unix.com/shell-programming-and-scripting/164747-bypass-getopts-errors-continue-processing.html
    ?)  echo "unknown option"
        exit ;;
    :)  echo "Option -$OPTARG requires an argument" >&2
        exit ;;
  esac
done

echo "[Option Check]"

file_name_array[0]="./SDS/src/app_dsm/CMakeLists.txt"
file_name_array[1]="./SDS/src/app_space_dynamic_data_provider/CMakeLists.txt"

# https://www.cyberciti.biz/faq/finding-bash-shell-array-length-elements/
file_name_array_length=${#file_name_array[@]}

#echo "file_name_array_length ${file_name_array_length}"

if [ $build_option1 == 1]
then
    for ((i=0 ; i < ${file_name_array_length}; i++));
    do
        sed -i 's/set(USE_REDIS_ENABLE false)/set(USE_REDIS_ENABLE true)/g' ${file_name_array[$i]}
    done
else
    for ((i=0 ; i < ${file_name_array_length}; i++));
    do
        sed -i 's/set(USE_REDIS_ENABLE true)/set(USE_REDIS_ENABLE false)/g' ${file_name_array[$i]}
    done
fi