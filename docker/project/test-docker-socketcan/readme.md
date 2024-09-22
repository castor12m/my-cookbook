
### 0. ref

- https://chemnitzer.linux-tage.de/2021/media/programm/folien/210.pdf


### 1. 도커 실행 환경 예씨

```bash
    docker run --rm -it --name cantest ubuntu:20.04
    apt-get update && apt-get install -y can-utils
```

### 2. can0 도커에 연결

- 참고 링크에 보면 3가지 정도 방법이 나오는데 2개만 나열

#### 2.1 방법 1) move can0 -- ?


```bash
    DOCKERPID=$(docker inspect -f '{{ .State.Pid }}' cantest)
    sudo ip link set can0 netns $DOCKERPID

    sudo nsenter -t $DOCKERPID -n ip link set can0 type can bitrate 500000
    sudo nsenter -t $DOCKERPID -n ip link set can0 up

    (or)

    sudo nsenter -t $DOCKERPID -n ip link set can0 up type can bitrate 500000
```

- can0 가 없는 경우 낭패?

- 호스트 머신에 실제 canable 장비를 장착하여 slcan을 can0로 로드한뒤
- 로드된 can0 네트워크를 컨테이너로 설정해준다.

#### 2.2 방법 2) vxcan

```bash
    DOCKERPID=$(docker inspect -f '{{ .State.Pid }}' cantest)
    sudo ip link add vxcan0 type vxcan peer name vxcan1 netns $DOCKERPID
    sudo ip link set vxcan0 up
    sudo nsenter -t $DOCKERPID -n ip link set vxcan1 up
```

- 적용한 모습

host)
```bash
    stbtest3@stbtest3:~/workspace$ ifconfig
    (...)
    vxcan0: flags=129<UP,NOARP>  mtu 72
            unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 1000  (UNSPEC)
            RX packets 0  bytes 0 (0.0 B)
            RX errors 0  dropped 0  overruns 0  frame 0
            TX packets 0  bytes 0 (0.0 B)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

    stbtest3@stbtest3:~/workspace$ sudo nsenter -t $DOCKERPID -n ip link set vxcan1 up
    
    stbtest3@stbtest3:~/workspace$ cansend vxcan0 123#1123
```

docker)
```bash
    root@ab68292e1911:/src/host/temp# ifconfig
    (...)
    vxcan1: flags=193<UP,RUNNING,NOARP>  mtu 72
            unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 1000  (UNSPEC)
            RX packets 0  bytes 0 (0.0 B)
            RX errors 0  dropped 0  overruns 0  frame 0
            TX packets 0  bytes 0 (0.0 B)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

    root@ab68292e1911:/src/host/temp# candump vxcan1
    vxcan1  123   [2]  11 23
```

### 3. 생성한 vxcan 내리기

```bash
    # 컨테이너에 활성화 시킨 vxcan1 비활성화
    sudo nsenter -t $DOCKERPID -n ip link set vxcan1 up

    # vxcan0 비활성화
    sudo ip link set vxcan0 up

    # vxcan0 삭제
    # 이명령어만 날려도 앞에 명령어 두개 안보내도됨
    sudo ip link delete vxcan0
    # 삭제하면 컨테이너에서 ifconfig -a 보이는 vxcan1도 사라진다
    # 물론 host의 ifconfig -a 혹은 ip link show 에서 보이는 네트워크 인터페이스에서도 사라짐
```


### A. 기타

- https://jaeho.tistory.com/entry/docker-nsenter
- https://gettingconnected.tistory.com/m/491

- nsenter 명령어는 namespace enter 명령어라고함.. 격리된 네임스페이스(컨테이너와 같은?)에 진입하는 명령어

### B. 무작정

```bash
    # host
    DOCKERPID=$(docker inspect -f '{{ .State.Pid }}' stb)
    sudo ip link add vxcan0 type vxcan peer name vxcan1 netns $DOCKERPID
    sudo ip link set vxcan0 up
    sudo nsenter -t $DOCKERPID -n ip link set vxcan1 up
```