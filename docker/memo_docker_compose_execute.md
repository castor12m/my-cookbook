# micro-itos

### docker-compose 이용법

```bash
    # 실행
    $ docker-compose up -d --build
        or
    $ docker-compose up -d --build --no-cache 

    (https://sang12.co.kr/235/docker-compose-up-no-cache%28%EC%BA%90%EC%89%AC%29)
    $ docker-compose up -d --force-recreate

    # 특정 서비스만 재실행
    $ docker-compose restart stb

    # 특정 서비스 빌드후 재실행 - 의존성 있는 컨테이너들이 이미 실행된 상태여야함!
    # https://www.baeldung.com/rebuild-docker-container-compose
    $ docker-compose up -d --force-recreate --build web

    # 종료
    $ docker-compose down

```

```bash
    (https://shawn-dev.oopy.io/docker-cache-clean)
    # 캐쉬 삭제
    $ docker system prune -a

    # docker 에서는 layer 를 쌓을 때 cache 를 이용해서 이미지 빌드와 컨테이너 생성 시간을 줄인다.
    # 이 cache 데이터는 이미지와 컨테이너를 제거하더라도 로컬에 남아있다.
    # cache 가 계속 쌓이는 것이 장점이 크긴 하지만 단점도 있다.
    # 때로는 cache 로 인해 도커파일을 수정해도 변경사항이 반영이 안 되는 경우도 있고, ( 사실 이 경우는 docker-compose build --no-cache 로 해결 가능 )

    $ docker-compose build --no-cache


```

### 다운 받아야할 repo

```
    $ git clone https://github.com/Naraspace-Technology/micro-itos-blazor.git web
    $ git clone https://github.com/Naraspace-Technology/micro-itos-mediator.git mediator
    $ git clone https://github.com/Naraspace-Technology/micro-itos-stb.git stb
    $ git clone https://github.com/Naraspace-Technology/micro-itos-test-helper.git testhelper
    $ git clone https://github.com/Naraspace-Technology/micro-itos-test-script.git testscript
    $ git clone https://github.com/Naraspace-Technology/micro-itos-zmqproxy.git zmqproxy --recursive
```

### stb 실행법

git 최신 다운 받았다는 가정.

stb 컨테이너에 접속해서

```
    $ bash ./set_docker_build_option.sh
    $ cd ./build && bash ../jstart_all.sh --obs1 --42 --vs
```

### test script 실행법

testhelper 이용법

```
    $ bash ./cp_libcsp_file.sh 
    
    // 바로 사용
    테스트 샘플 예제)
    $ bash ./jstart.sh obs1 set30

```

### ssh service 이용.

stb or testhelper ssh 서비스 설정 방법

```
    $ passwd root
    >> 암호 입력

    $ service ssh start

    // 이 후 ssh 접속해서 사용 
```

### host에서 redis-cli 로 접근법

```bash
    (https://www.enqdeq.net/216)
    $ redis-cli -h 127.0.0.1 -p 6379 -a foobared
```

### docker volume 생성

```
    (https://seosh817.tistory.com/374)
    
    $ docker volume create --name host_name
```

### 주의


1) 윈도우에서 실행시, 레디스가 켜져잇다면 끄고 할 것.

```powershell
    $ net stop redis
```

2) 쉘스크립트 실행 이상 문제

https://harryp.tistory.com/1192

```
    $'\r': command not found
```

이런 오류는 윈도우에서 작성 된 스크립트를 리눅스에서 실행 하려고 할 때 발생 할 수 있습니다.

윈도우와 리눅스에서 사용하는 개행문자 (줄 바꿈 문자, New Line 문자) 가 달라서 발생하는 오류 입니다.

윈도우에선 줄 바꿈을 CRLF (\r\n),

리눅스에서는 LF (\n) 를 사용해서 바뀌는 문제 입니다.

```
    $ sed -i 's/\r$//' 파일명
```

### To Do

- testhelper 에서 다른 프로세스를 실행할 파이썬 프로그램, 명령 수신은 레디스 subscribe 통해서 받기

- (할일은 아님) docker-compose 로 연결된 volume 엔트리 포인트까지 수행된다음 되는건가..
volume에 있는 .so 파일 옮겨 놓을려고 했는데 여러가지 삽질을 해봤는데 다 안되네...


### 1) hostsystem 에서 micro-itos 실행 하기 위한 최소한의 서비스 실행

```
    $ docker-compose up -d redis mediator
```



### 2) 

```bash
    $ docker-compose up -d redis mediator zmqproxy stb testhelper fsw
    or 
    $ docker-compose up -d --build redis mediator zmqproxy stb testhelper fsw
```