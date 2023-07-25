for var in {1..1000..1} 
do 
    echo `uptime` >> result.txt
    echo `ls /home | grep test` >> result.txt
    sleep 1
    #
done
