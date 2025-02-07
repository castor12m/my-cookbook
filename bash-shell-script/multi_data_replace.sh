# usage:
#   # 아규먼트 없이 파일명으로 실행
#   $ bash {filename}.sh
################################################################################################
# 원리 :
#   sed -i 's/# set(FUNCTION_DATA_ENABLE/set(FUNCTION_DATA_ENABLE/g' ./AJC_defs/targets_PC.cmake
################################################################################################

file_name="./target1.txt"
################################################################################################
#   # 다음과 같이 작성 예시
#   # replace_from_to+=("# set(FUNCTION_DATA_ENABLE/set(FUNCTION_DATA_ENABLE")

replace_from_to+=('s/NO1-F-AOCS-00_OFF/AJC-F-AOCS-000_OFF/g')
replace_from_to+=('s/NO1-F-AOCS-00_ON/AJC-F-AOCS-000_ON/g')
replace_from_to+=('s/NO1-F-AOCS-02/AJC-F-AOCS-002-S01/g')
replace_from_to+=('s/NO1-F-AOCS-03/AJC-F-AOCS-101-S01/g')
replace_from_to+=('s/NO1-F-AOCS-04/AJC-F-AOCS-213-S01/g')
replace_from_to+=('s/NO1-F-AOCS-05/AJC-F-AOCS-201-S01/g')
replace_from_to+=('s/NO1-F-AOCS-06/AJC-F-AOCS-211-S01/g')
replace_from_to+=('s/NO1-F-AOCS-07/AJC-F-AOCS-203-S01/g')
replace_from_to+=('s/NO1-F-AOCS-08/AJC-F-AOCS-212-S01/g')
replace_from_to+=('s/NO1-F-AOCS-09/AJC-F-AOCS-111-S01/g')
replace_from_to+=('s/NO1-F-AOCS-10/AJC-F-AOCS-112-S01/g')
replace_from_to+=('s/NO1-F-AOCS-11/AJC-F-AOCS-113-S01/g')
replace_from_to+=('s/NO1-F-AOCS-12/AJC-F-AOCS-121-S01/g')
replace_from_to+=('s/NO1-F-AOCS-13/AJC-F-AOCS-122-S01/g')
replace_from_to+=('s/NO1-F-AOCS-14/AJC-F-AOCS-123-S01/g')
replace_from_to+=('s/NO1-F-AOCS-15/AJC-F-AOCS-232-S01/g')
replace_from_to+=('s/NO1-F-AOCS-16/AJC-F-AOCS-221-S01/g')
replace_from_to+=('s/NO1-F-AOCS-17/AJC-F-AOCS-131-S01/g')
replace_from_to+=('s/NO1-F-AOCS-18/AJC-F-AOCS-222-S01/g')
replace_from_to+=('s/NO1-F-AOCS-19/AJC-F-AOCS-132-S01/g')
replace_from_to+=('s/NO1-F-AOCS-20/AJC-F-AOCS-231-S01/g')
replace_from_to+=('s/NO1-F-AOCS-21/AJC-F-AOCS-202-S01/g')
replace_from_to+=('s/NO1-F-AOCS-22/AJC-F-AOCS-003-S01/g')
replace_from_to+=('s/NO1-F-AOCS-23-S01/AJC-F-AOCS-301-S01/g')
replace_from_to+=('s/NO1-F-AOCS-23-S02/AJC-F-AOCS-301-S02/g')
replace_from_to+=('s/NO1-F-AOCS-23-S03/AJC-F-AOCS-301-S03/g')
replace_from_to+=('s/NO1-F-AOCS-23-S04/AJC-F-AOCS-301-S04/g')
replace_from_to+=('s/NO1-F-AOCS-24-S01/AJC-F-AOCS-302-S01/g')
replace_from_to+=('s/NO1-F-AOCS-24-S02/AJC-F-AOCS-302-S02/g')
replace_from_to+=('s/NO1-F-AOCS-25/AJC-F-AOCS-303-S01/g')
replace_from_to+=('s/NO1-F-AOCS-26/AJC-F-AOCS-304-S01/g')

################################################################################################
replace_from_to_length=${#replace_from_to[@]}

for ((i=0 ; i < ${replace_from_to_length}; i++));
do
    echo "sed -i" \'${replace_from_to[$i]}\' $file_name
    sed -i ${replace_from_to[$i]} $file_name
done
