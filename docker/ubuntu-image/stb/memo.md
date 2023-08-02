

### 1. Dockerfile 로 이미지 생성

ref <br/>
: https://sangchul.kr/entry/Docker-%EC%9A%B0%EB%B6%84%ED%88%AC-sbininit-%EB%B0%8F-systemctl-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0 <br/>
: https://wooono.tistory.com/123 <br/>

```bash
    $ mkdir stb && cd stb
    $ touch Dockerfile
```

Dockerfile 에 다음 내용 복붙

```
    FROM ubuntu:22.04

    ARG DEBIAN_FRONTEND=noninteractive

    ENV TZ=Asia/Seoul

    RUN sed -i 's/kr.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

    # install essential packages
    RUN apt update \
    && apt install -qq -y init systemd \
    && apt install -qq -y tzdata \
    && apt install -qq -y nano curl \
    && apt install -qq -y libtool pkg-config build-essential autoconf automake uuid-dev libzmq3-dev libsocketcan-dev can-utils cmake \
    && apt install -qq -y net-tools iputils-ping iproute2 git python3 python-is-python3 wget \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

    # get STB source from git repository & change git submodule branch
    RUN git clone https://****************************@github.com/Naraspace-Technology/STB.git \
    && cd STB \
    && sed -i 's/github.com/****************************@github.com/g' ./.gitmodules \
    && git submodule update --init --recursive \
    && cd SDS && git checkout castor && cd .. \
    && cd 42 && git checkout Develop && cd .. \
    && cd libcsp &&  git checkout master && cd .. \
    && cd cesium &&  git checkout master && cd ..

    # install STB dependancy
    RUN apt install -qq -y libboost-all-dev libspdlog-dev libssl-dev freeglut3-dev libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev pkg-config

    # build STB
    RUN mkdir /STB/output \
    && mkdir /STB/build \
    && cd /STB/build \
    && pwd \
    && bash ../abuild_all.sh

    CMD ["/sbin/init"]

```

도커 빌드

```bash
    $ docker build --tag naraspace/stb:0.1 .
                                           |
                                        (Dockerfile 위치)
```

컨테이너 생성

```bash
    # 아래의 1, 2번 방법 중 선택해서 수행

    # 1)
    $ docker run -d --privileged --name stb naraspace/stb:0.1 /sbin/init
    $ docker network connect --ip=192.168.0.48 mac0 stb

    # 2)
    $ docker run -d --privileged --net=mac0 --ip=192.168.0.48 --name stb naraspace/stb:0.1 /sbin/init

    # **) 2번 방법에서 ssh port 추가
    $ docker run -d --privileged -p 8022:22 --net=mac0 --ip=192.168.0.48 --name stb naraspace/stb:0.1 /sbin/init

    $ docker run -d --privileged -p 8022:22 -p 6000:6000  --hostname naraspace_stb_0_1 --name stb naraspace/stb:0.1 /sbin/init
```

컨테이너 접속

```bash
    $ docker exec -it stb bash
```

STB 실행

```bash
    $ cd /STB/build
    $ bash ../jstart_all.sh --obs1
```
