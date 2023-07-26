#/bin/sh

#echo "EXECUTE BACKGROUND START : $1"

WORK_SPACE=$2

# 확인용 
#echo ${PWD}/check_process.sh $1
bash ${PWD}/check_process.sh $1

#echo "result = $?"
check=$?

if [ $check -eq 1 ]
then
    echo "HOLD"
else
    cd ${WORK_SPACE}
    echo "-p2 : ${PWD}"
    echo "EXECUTE BACKGROUND : $1"
    `$1` &
fi

#echo "EXECUTE BACKGROUND FINISH"
