
### 1. 도커 컨테이너에 /dev/tty* 연결

```bash
    castor@castor-SER8:~/vmscript/test-img$ ls -al /dev/ttyC*
    lrwxrwxrwx 1 root root 15  9월 21 13:30 /dev/ttyCAN1 -> bus/usb/001/006
```

#### ./docker-compose.yml
```yml
services:
    test-img:
        image: test-img:0.1
        build:
            context: ./test
        container_name: test-img
        privileged: true
        tty: true
        user: root
        # security_opt:
        #   - apparmor:unconfined
        devices:
        - /dev/ttyCAN1
        # - /dev/ttyCAN1:/dev/ttyCAN1
        
```

#### ./test/99-candle-usb.rules
```txt
    SUBSYSTEMS=="usb", MODE="0666", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="606f", SYMLINK+="ttyCAN%n"
```

#### ./test/Dockerfile
```Dockerfile
    FROM ubuntu:22.04 AS base
    WORKDIR /src

    COPY . .

    FROM base AS final
    WORKDIR /src
    RUN apt update
    RUN apt install -qq -y can-utils net-tools udev usbutils iproute2 

    COPY ./99-candle-usb.rules /etc/udev/rules.d/

    RUN /lib/systemd/systemd-udevd --daemon && udevadm control --reload-rules

    #RUN udevadm trigger
    # => ERROR [test-img final 6/7] RUN udevadm trigger                                                                                                         0.4s 
    # ------                                                                                                                                                          
    #  > [test-img final 6/7] RUN udevadm trigger:                                                                                                                    
    # 0.370 LNXSYSTM:00: Failed to write 'change' to '/sys/devices/LNXSYSTM:00/uevent': Read-only file system       

    WORKDIR /src/
    ENTRYPOINT ["bash", "./entrypoint.sh"]

```

#### ./test/entrypoint.sh
```bash
    tail -f /dev/null
```

## 직접 수행시 기록

### 설치 항목 기록

```bash
    apt update
    apt-get install -y can-utils net-tools udev usbutils iproute2 kmod
    # udev      -> udevadm 명령어용
    # usbutils  -> lsusb 명령어용
    # iproute2  -> ip link 명령어용
    # kmod      -> modprobe 명령어 사용

    # root@cbafa3722ec2:/src# modprobe can
    # modprobe: FATAL: Module can not found in directory /lib/modules/6.5.0-44-generic
    # root@cbafa3722ec2:/src# modprobe slcan
    # modprobe: FATAL: Module slcan not found in directory /lib/modules/6.5.0-44-generic
    # root@cbafa3722ec2:/src# modprobe slcan
    # modprobe: FATAL: Module slcan not found in directory /lib/modules/6.5.0-44-generic    
    ubuntu-drivers install

    # X
    # slcan-utils   -> slcan 동작 관련 --> gps한테 속음 이런건 없다..
    # slcan은 can-utils로 지원됨

    slcand -o -c -f -s8 /dev/ttyCAN1 can0
```

### 도커 udev reload 안됨


```bash
    # udevadm control --reload-rules && systemctl restart systemd-udevd && udevadm trigger
    # 위 명령어가 안되서 다음과 같이 실행
    /lib/systemd/systemd-udevd --daemon && udevadm control --reload-rule && udevadm trigger

    slcand -o -c -s8 /dev/ttyCAN1 can0

    ip link set can0 up type can bitrate 1000000
```

### 도커 vcan 가능 확인

```bash
    # vcan0 생성
    sudo ip link add dev vcan0 type vcan
    ifconfig -a
    
    # vcan0 활성화
    sudo ifconfig vcan0 up
    ifconfig
```