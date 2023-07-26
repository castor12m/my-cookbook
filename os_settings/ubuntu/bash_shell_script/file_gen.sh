
file_name_index=0
file_name_arr=[]

ADD_FILENAME_ARR() { 
    file_name_arr[$file_name_index]=$1
    ADD_INDEX_______
}

ADD_INDEX_______() { 
    file_name_index=$(expr $file_name_index + 1)
}

ADD_FILENAME_ARR "02"
ADD_FILENAME_ARR "03"
ADD_FILENAME_ARR "04"
ADD_FILENAME_ARR "05"
ADD_FILENAME_ARR "06"
ADD_FILENAME_ARR "07"
ADD_FILENAME_ARR "08"
ADD_FILENAME_ARR "09"
ADD_FILENAME_ARR "10"
ADD_FILENAME_ARR "11"
ADD_FILENAME_ARR "12"
ADD_FILENAME_ARR "13"

file_name_arr_len=${#file_name_arr[@]}
echo file_name_arr_len : ${file_name_arr_len}

for ((i=0; i < ${file_name_arr_len}; i++))
do
    echo --- ${file_name_arr[$i]}
    cp ./NO1-F-EPS-01_REVERT.yml ./NO1-F-EPS-${file_name_arr[$i]}_REVERT.yml
    cp ./NO1-F-EPS-01_SET.yml ./NO1-F-EPS-${file_name_arr[$i]}_SET.yml
done

