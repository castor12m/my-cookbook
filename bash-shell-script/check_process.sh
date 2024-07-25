#/bin/sh

#echo "CHECK PROCESS START : $1"

check=`ps -ef | grep $1 | grep -v grep | awk '$8 != "bash" {print $2}'`

if [ -z $check ]
then
    echo "NOT FOUND"
else
    if [ $check -gt 1 ]
    then
        echo "RUNNING : $1"
        return 1
    else
        echo "NOT FOUND"
    fi
fi

#echo "CHECK PROCESS FINISH"