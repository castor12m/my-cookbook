
get_container_pid() {
    DOCKERPID=`docker inspect -f '{{ .State.Pid }}' $1`

    echo $DOCKERPID
}

option_slcan(){
    CAN_DEVICE_NAME="can0" 

    DOCKERPID=`get_container_pid $1`

    sudo ip link set $CAN_DEVICE_NAME netns $DOCKERPID
    sudo nsenter -t $DOCKERPID -n ip link set $CAN_DEVICE_NAME type can bitrate 1000000
}

option_vcan(){
    VCAN_DEVICE_NAME_HOST="vxcan0" 
    VCAN_DEVICE_NAME_CONTAINER="vxcan1"
    
    DOCKERPID=`get_container_pid $1`

    sudo ip link add $VCAN_DEVICE_NAME_HOST up type vxcan peer name $VCAN_DEVICE_NAME_CONTAINER netns $DOCKERPID
    sudo nsenter -t $DOCKERPID -n ip link set $VCAN_DEVICE_NAME_CONTAINER up

}

################################################################################

len=$#

echo " - Total number of arguments: $len"

if [ $len -lt 1 ]
then

    echo " - Input argument option"
    exit 1

else

    while [[ $# -gt 0 ]]
    do
        key="$1"

        case $key in
            -s|slcan)
                echo ''
                echo ' [ slcan to container ]'
                if [ ${#2} -lt 1 ]
                then
                    echo ' - Input service name to start'
                    exit 1
                else
                    option_slcan $2
                    shift
                fi
                ;;

            -v|vcan)
                echo ''
                echo ' [ vcan to container ]'
                if [ ${#2} -lt 1 ]
                then
                    echo ' - Input service name to start'
                    exit 1
                else
                    option_vcan $2
                    shift
                fi
                ;;

            *) 
                echo ' - Wrong option'
                exit 1
                ;;
        esac

    shift
    done
fi
