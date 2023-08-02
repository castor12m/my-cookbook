

### 1. 컨테이너에서 설치


```bash
    (필수 패키지)
    $ apt install -y libtool pkg-config build-essential autoconf automake uuid-dev libzmq3-dev libsocketcan-dev can-utils cmake

    (zeroMQ 설치 - 호환성 문제로 인해 최신버전 수동 설치 )
    (ref : https://nagy.tistory.com/22)
    $ wget https://github.com/zeromq/libzmq/releases/download/v4.3.4/zeromq-4.3.4.tar.gz
    $ tar xvzf zeromq-4.3.4.tar.gz
    $ cd zeromq-4.3.4
    $ ./configure
    $ make install
    $ sudo ldconfig             # linux에 zeromq driver 설치 

    $ ldconfig -p | grep zmq    # 설치 확인
    >>>
    libzmq.so.5 (libc6,AArch64) => /lib/aarch64-linux-gnu/libzmq.so.5
    libzmq.so.5 (libc6,AArch64) => /usr/local/lib/libzmq.so.5
    libzmq.so (libc6,AArch64) => /lib/aarch64-linux-gnu/libzmq.so
    libzmq.so (libc6,AArch64) => /usr/local/lib/libzmq.so

```

본격 타겟 소스 빌드

```bash
    (libcsp)
    $ git clone https://************************@github.com/NST-FSW/libcsp libcsp-nst
    $ ./waf configure --install-csp --with-os=posix --enable-can-socketcan --enable-if-zmqhub --enable-shlib
    $ ./waf build

    (fsw)
    $ git clone https://************************@github.com/NST-FSW/Observer_FSW
    $ cd Observer_FSW

    # 서브모듈 가져올때 github cli로 로그인 안되어 있으면 fail남 주의ß
    $ git submodule update --init

    # target을 pc용으로 변경
    $ cp Observer_defs/targets_PC.cmake Observer_defs/targets.cmake

    # build
    $ make install

    # build된 libcsp를 복사
    $ cp ../libcsp-nst/build/libcsp.so build/exe/PC/cf/

    # exec
    $ cd b
```



```bash
    (ref : https://wooono.tistory.com/123)
    (ref : https://sangchul.kr/entry/Docker-%EC%9A%B0%EB%B6%84%ED%88%AC-sbininit-%EB%B0%8F-systemctl-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0)
```