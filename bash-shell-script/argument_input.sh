#!/bin/bash

all_build_option=0;

build_42sim=0;
build_libcsp=0;
build_sds=0;
build_vserial=0;
build_dptc=0;
build_rdpsim=0;
build_xactcv=0;

while getopts 'abcdefz:' c
do
  case $c in
    a) build_42sim=1 ;;
    b) build_libcsp=1 ;;
    c) build_sds=1 ;;
    d) build_vserial=1 ;;
    e) build_dptc=1 ;;
    f) build_rdpsim=1 ;;
    g) build_xactcv=1 ;;
    z) build_dptc=$OPTARG ;;
  esac
done

echo "[Option Check]"
if [ $build_42sim = 0 ] && [ $build_libcsp = 0 ] && [ $build_sds = 0 ] && [ $build_vserial = 0 ] && [ $build_dptc = 0 ] && [ $build_rdpsim = 0 ] && [ $build_xactcv = 0 ]
then
    echo '  partial build option off';
    all_build_option=1;
else
    echo '  partial build option on - least one build';
    all_build_option=0;
fi

echo "[Build Path Check]"
check=`echo ${PWD} | grep build`