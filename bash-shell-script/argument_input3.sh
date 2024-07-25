#!/bin/bash
# https://educoder.tistory.com/entry/Bash-%EB%AA%85%EB%A0%B9%ED%96%89-%EC%9D%B8%EC%9E%90-0-Command-line-argument
# https://jaeyung1001.tistory.com/entry/Shell-Script-%EC%9D%B8%EC%9E%90%EA%B0%92-%EC%9D%B4%EC%81%98%EA%B2%8C-%EB%B0%9B%EA%B8%B0

entry_stop=0;

while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
      --id) ISSUE_ID="$2"
        shift # 입력 변수 하나 이동
        ;;

      -b|--build) BUILD_MODE="$2"
        shift
        ;;

      --dummy) echo dummy : ${@:0} : ${@:1} : ${@:2}
        shift
        ;;

      --entry-stop) entry_stop=1 ;;

      *) ;;
  esac

  shift
done

echo "Issue: $ISSUE_ID"
echo "Mode: $BUILD_MODE"
echo "entry_stop: $entry_stop"