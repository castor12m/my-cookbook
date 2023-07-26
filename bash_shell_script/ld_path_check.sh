# ldd 혹은 ld가 뭘까? library dependencies 인듯?

# 이건 아래 LD_LIBRARY_PATH 조회 명령어
# ref : https://www.lesstif.com/lpt/linux-error-while-loading-shared-libraries-95880436.html

# 아래 

LD_WANT_PATH="/usr/local/lib"

IFS=':' ; for i in $LD_LIBRARY_PATH; do ls -l $i$LD_WANT_PATH 2>/dev/null;done

ld_path_check=$?

echo "[show result]"
echo " --- "$ld_path_check

if [ $ld_path_check == 0 ]
then
    echo " --- path check ng"
    echo " --- type below"
    echo " --- $ export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:"$LD_WANT_PATH
    
    #여기에 해봣자 등록 안됨.
    #사용자가 입력하거나 bashprofile에 입력해야하는듯..
    #export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
else
    echo " --- path check ok"
fi