#/bin/sh

echo "ABORT PROCESS : START"

kill_process_func () {
    #echo " -- process name  : $1"
    #echo " -- process pid   : $2"
	if [ $2 -gt 1 ]
    then
        echo "ABORT PROCESS : [pid : $2] [pname : $1]"
        kill $check
    else
        echo "NOT FOUND"
    fi
}

# # https://gracefulprograming.tistory.com/127 [Peter의 우아한 프로그래밍]
# # https://recipes4dev.tistory.com/171

kill_process_get () {

    process_name=$1
    # 확인용 
    #echo `ps -ef | grep $1 | grep -v grep | awk '$8 != "bash" {print $2}'`
    check=`ps -ef | grep $process_name | grep -v grep | awk '$8 != "bash" {print $2}'`
    count=`ps -ef | grep $process_name | grep -v grep | awk '$8 != "bash" {print $2}' | wc -l`

    echo "PROCESS [$process_name] COUNT : $count";
    array=($check)

    if [ $count -gt 0 ]
    then
        if [ $count -eq 1 ]
        then
            kill_process_func $1 $check
        else
            for e in ${array[*]}
            do
                kill_process_func $1 $e
            done
        fi
    else
        echo "EMPTY STRING"
    fi

}

echo "----------------------------------------"

if [ $# -gt 0 ]
then
    for ((index=1 ; index < ($# + 1); index++));
    do
        cmd="var=$"$index
        #echo "--- $cmd"
        eval "$cmd"
        #echo "--- $var"

        kill_process_get $var

        echo "----------------------------------------"
    done

    echo "ABORT PROCESS : FINISH"
else
    echo "ABORT PROCESS : FINISH - ARGUMENT EMPTY"
fi
