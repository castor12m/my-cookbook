#!/bin/bash

# configure/counter.py
# openc3/command_model.py
# openc3/command_parser.py
# openc3/telemetry_model.py
# openc3/telemetry_parser.py
# protocol/csp/service_handler.py

file_name_array[0]="configure/counter.py"
file_name_array[1]="openc3/command_model.py"
file_name_array[2]="openc3/command_parser.py"
file_name_array[3]="openc3/telemetry_model.py"
file_name_array[4]="openc3/telemetry_parser.py"
file_name_array[5]="protocol/csp/service_handler.py"

####################################################################

check_sentense_at_file () {
    check=`sed -n '1p' ${1}`
    echo $check

    if [ "$check" == "from __future__ import annotations" ]
    then
        echo "FOUND"
    else
        echo "NOT FOUND"

        # ref : https://ciy545.tistory.com/87
        #       https://zetawiki.com/wiki/%EB%A6%AC%EB%88%85%EC%8A%A4_%ED%8C%8C%EC%9D%BC_%ED%8A%B9%EC%A0%95_%ED%96%89_%EB%82%B4%EC%9A%A9_%EA%B5%90%EC%B2%B4
        # (주의) 원본파일에 그대로 저장하는 것은 불가능. 즉, 원본파일명과 새파일명이 같으면 파일 내용이 비워진다.
        # 따라서 사본파일을 만들고 mv를 이용해 덮어씌어준다.

        # awk '{ if (NR==1) { print "from __future__ import annotations"; print $0 } else { print $0 } }' ${1} > temp.py
        # mv temp.py ${1}

        # 함수 형태로 call 되도록 수정
        append_line_at_file $1
    fi
}

append_line_at_file () {
    awk '{ if (NR==1) { print "from __future__ import annotations"; print $0 } else { print $0 } }' ${1} > temp.py
    mv temp.py ${1}
}

for value in "${file_name_array[@]}"; do
    echo $value
    check_sentense_at_file $value
done
