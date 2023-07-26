file_name_index=0

arr_filename=[]
arr_sed_tite=[]
arr_sed_user=[]
arr_sed_comt=[]
arr_sed_node=[]

ADD_FILENAME_ARR() { 
    arr_filename[${file_name_index}]=$1
}

ADD_TITLE____ARR() { 
    arr_sed_tite[${file_name_index}]=$1
}

ADD_USER_____ARR() { 
    arr_sed_user[${file_name_index}]=$1
}

ADD_COMMENT__ARR() { 
    arr_sed_comt[${file_name_index}]=$1
}

ADD_NODE_____ARR() { 
    arr_sed_node[${file_name_index}]=$1
}

ADD_INDEX_______() { 
    file_name_index=$(expr $file_name_index + 1)
}

################################################################
# test 샘플

#arr_filename[0]='NO1-F-EPS-01_TARGET.yml'
#arr_sed_tite[0]='Board TM TC 실패'
#arr_sed_user[0]='00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00'
#arr_sed_comt[0]='(tree:data.t6.cmd_reponse_mask) (value:0)''
#arr_sed_node[0]='4'


################################################################
# 입력할 곳

ADD_FILENAME_ARR 'NO1-F-EPS-06_SET.yml' 
ADD_TITLE____ARR 'Board 온도 이상'
ADD_USER_____ARR 'D4 04 00 04 B0 0B 00 00 00 00 00 44 03 34'
ADD_COMMENT__ARR 'SendData (tree:data.t4.temp0) (value:82)'
ADD_NODE_____ARR '4'
ADD_INDEX_______ 

ADD_FILENAME_ARR 'NO1-F-EPS-06_REVERT.yml' 
ADD_TITLE____ARR 'Board 온도 이상'
ADD_USER_____ARR 'EF 04 00 04 B0 0B 00 00 00 00 00 44 00 00'
ADD_COMMENT__ARR 'SendData (tree:data.t4.temp0) (value:0)'
ADD_NODE_____ARR '4'
ADD_INDEX_______ 


# ADD_FILENAME_ARR 'NO1-F-EPS-07_SET.yml' 
# ADD_TITLE____ARR 'PDU 온도 이상'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '3'
# ADD_INDEX_______ 

# ADD_FILENAME_ARR 'NO1-F-EPS-07_REVERT.yml' 
# ADD_TITLE____ARR 'PDU 온도 이상'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '3'
# ADD_INDEX_______ 


# ADD_FILENAME_ARR 'NO1-F-EPS-08_SET.yml' 
# ADD_TITLE____ARR 'ACU 온도 이상'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '2'
# ADD_INDEX_______ 

# ADD_FILENAME_ARR 'NO1-F-EPS-08_REVERT.yml' 
# ADD_TITLE____ARR 'ACU 온도 이상'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '2'
# ADD_INDEX_______ 


# ADD_FILENAME_ARR 'NO1-F-EPS-09_SET.yml' 
# ADD_TITLE____ARR 'Battery 온도 이상'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '5'
# ADD_INDEX_______ 

# ADD_FILENAME_ARR 'NO1-F-EPS-09_REVERT.yml' 
# ADD_TITLE____ARR 'Battery 온도 이상'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '5'
# ADD_INDEX_______ 


# ADD_FILENAME_ARR 'NO1-F-EPS-10_SET.yml' 
# ADD_TITLE____ARR 'ACU MPPT 이상'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '2'
# ADD_INDEX_______ 

# ADD_FILENAME_ARR 'NO1-F-EPS-10_REVERT.yml' 
# ADD_TITLE____ARR 'ACU MPPT 이상'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '2'
# ADD_INDEX_______ 


# ADD_FILENAME_ARR 'NO1-F-EPS-11_SET.yml' 
# ADD_TITLE____ARR 'Battery 잔량 부족'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '1'
# ADD_INDEX_______ 

# ADD_FILENAME_ARR 'NO1-F-EPS-11_REVERT.yml' 
# ADD_TITLE____ARR 'Battery 잔량 부족'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '1'
# ADD_INDEX_______ 


# ADD_FILENAME_ARR 'NO1-F-EPS-12_SET.yml' 
# ADD_TITLE____ARR 'Solar Panel 전개 스위치 이상'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '22'
# ADD_INDEX_______ 

# ADD_FILENAME_ARR 'NO1-F-EPS-12_REVERT.yml' 
# ADD_TITLE____ARR 'Solar Panel 전개 스위치 이상'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '22'
# ADD_INDEX_______ 


# ADD_FILENAME_ARR 'NO1-F-EPS-13_SET.yml' 
# ADD_TITLE____ARR '전원 제어 실패'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '4'
# ADD_INDEX_______ 

# ADD_FILENAME_ARR 'NO1-F-EPS-13_REVERT.yml' 
# ADD_TITLE____ARR '전원 제어 실패'
# ADD_USER_____ARR 
# ADD_COMMENT__ARR 
# ADD_NODE_____ARR '4'
# ADD_INDEX_______ 



################################################################
# 길이 측정
arr_filename_len=${#arr_filename[@]}

################################################################
# 자동 입력 부

for ((i=0; i < ${arr_filename_len}; i++))
do
    
    temp_sed_cmd_tite='s/___CONDITION__NAME___/'${arr_sed_tite[$i]}'/g'
    temp_sed_cmd_user='s/___USERDATA____/'${arr_sed_user[$i]}'/g'
    temp_sed_cmd_comt='s/___COMMENT____/'${arr_sed_comt[$i]}'/g'
    temp_sed_cmd_node='s/___DESTIONATION_NODE____/'${arr_sed_node[$i]}'/g'

    temp_eval_cmd_tite="sed -i '' '${temp_sed_cmd_tite}' ./${arr_filename[$i]}"
    temp_eval_cmd_user="sed -i '' '${temp_sed_cmd_user}' ./${arr_filename[$i]}"
    temp_eval_cmd_comt="sed -i '' '${temp_sed_cmd_comt}' ./${arr_filename[$i]}"
    temp_eval_cmd_node="sed -i '' '${temp_sed_cmd_node}' ./${arr_filename[$i]}"

    echo ${temp_eval_cmd_tite}
    echo ${temp_eval_cmd_user}
    echo ${temp_eval_cmd_comt}
    echo ${temp_eval_cmd_node}

    eval "${temp_eval_cmd_tite}"
    eval "${temp_eval_cmd_user}"
    eval "${temp_eval_cmd_comt}"
    eval "${temp_eval_cmd_node}"

done
