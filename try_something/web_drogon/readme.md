
### 1. 무엇

drogon

c++로 만들어진 웹 프레임 워크

### 2. 사용법

### 2.1 관련 글

https://codingmaye.hashnode.dev/the-fastest-web-framework

https://codingmaye.hashnode.dev/drogon-activity-should-i-use-it-for-production-code-part-1

https://codingmaye.hashnode.dev/drogon-framework-should-i-use-it-for-production-code-part-2

### 2.2 drogon 도커라이즈 예시

drogon 도커라이즈 관련 글 링크

https://srdbranding.medium.com/how-to-dockerize-a-c-drogon-web-application-web-app-in-an-existing-project-for-the-web-7778ec7ddcd7

사이트 내용 중 DockerFile 설정

```DockerFile

FROM ubuntu:18.04

RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends software-properties-common \
    sudo curl wget cmake pkg-config locales git gcc-8 g++-8 build-essential \
    openssl libssl-dev libjsoncpp-dev uuid-dev zlib1g-dev libc-ares-dev\
    postgresql-server-dev-all libmariadbclient-dev libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8

WORKDIR /app

RUN git clone https://github.com/an-tao/drogon && \ 
    cd drogon && \
    git submodule update --init && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && make install 

RUN drogon_ctl create project application_name  

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    CC=gcc-8 \
    CXX=g++-8 \
    AR=gcc-ar-8 \
    RANLIB=gcc-ranlib-8 \
    BOOST_INCLUDE_DIR="${HOME}/opt/boost_1_67_0" \  
    IROOT=/install
ARG DEBIAN_FRONTEND=noninteractive

ADD deploy.sh ./app/deploy.sh  

RUN chmod +x ./app/deploy.sh  

EXPOSE 8080

CMD sh ./app/deploy.sh && tail -f /dev/null
How to Keep Docker Containers Running

```

### 2.3 2.1 이용해서 빌드

```bash
    $ https://github.com/drogonframework/drogon.git 
    $ cd drogon/
    $ git submodule update --init
    $ mkdir build
    $ cd build/
    $ cmake ..
    $ make
    $ make install
```