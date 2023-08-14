
### curl 활용법

https://domdom.tistory.com/537

``` bash
  ### 1) GET data 전송법
  $ curl http://127.0.0.1/?key=value&key2=value2
  $ curl -G http://127.0.0.1/ -d key=value -d key2=value2

  ### 2) POST data 전송법
  $ curl http://127.0.0.1/ -d key=value -d key2=value2
  $ curl http://127.0.0.1/ -d "key=value&key2=value2"
  $ curl -X POST -d "key=value" http://127.0.0.1/

  ### 3) JSON data 전송법
  $ curl -X POST -H "Content-Type: application/json" -d '{"key": number, "key2": "string"}' http://127.0.0.1/
  $ curl -X POST -H "Content-Type: application/json" -d "{\"key\": number, \"key2\": \"string\"}" http://127.0.0.1/

  ### 4) Cookie 값 지정법
  $ curl http://127.0.0.1/ -b "session=domdomi"

  ### 5) 파일 업로드
  $ curl http://127.0.0.1/ -d "@/etc/passwd"
  $ curl http://127.0.0.1/ -F pwdfile=@/etc/passwd -F hello=domdomi

  ### 6) $ curl 결과 저장
  $ curl http://127.0.0.1/ > test.txt
  $ curl http://127.0.0.1/ -o test.txt
  $ curl -O http://127.0.0.1/test.txt # -O 옵션은 파일 이름 그대로 다운
  $ curl -O http://127.0.0.1/foo[0-9].txt # foo0.txt 부터 foo9.txt 파일 다운 받기
  $ curl -O http://127.0.0.1/foo-[a-z][0-9].txt # foo-a0 ~ foo-z9 다운 받기
  $ curl -O http://127.0.0.1/{foo,bar,baz}.txt # foo.txt, bar.txt, baz.txt 다운 받기

  ### 7. Linux 명령어와 연계
  $ curl http://127.0.0.1/ -d whoami=`whoami|base64`
  $ cat /etc/passwd | base64 | curl http://127.0.0.1/ -d @- # 명령실행 결과를 base64 인코딩해서 전송
```