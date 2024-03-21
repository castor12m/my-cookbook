
## 1. 몇가지 라즈베리파이 설치시 사항

### 1.1. 라즈베리파이 우분투 부팅 재대로 안되는 경우

초기 시간이 좀 걸리기는 함.

안된다면 전원 문제 일 가능성도 있음, 전원 공급 케이블 라즈베리파이 전용인걸로 연결하자! 

### 1.2. 타임존 설정

```bash
    date
    >>>
    Sat Feb  3 13:40:30 UTC 2024
```

한국 시간대로 바꾸기 위해서 프로파일에 다음 추가

```bash
    vi ~/.profile
    ========================================================
    (...)
    TZ='Asia/Seoul'; export TZ        
    ========================================================

    . ~/.profile

    date 
    >>>
    Sat Feb  3 22:43:36 KST 2024
```

초기 시간이 좀 걸리기는 함.

안된다면 전원 문제 일 가능성도 있음, 전원 공급 케이블 라즈베리파이 전용인걸로 연결하자! 


### 1.3. apt update 등 apt install 안되는 경우

인터넷이 연결되었는지 확인하자

핑 확인을 해보거나 다음 명령어로 아이피 할당이 되었는지 체크

```bash
    # 아이피가 제대로 할당되었는지 확인하자
    $ ip addr
        or
    $ hostname -I
```


## 2. 와이파이 자동 로그인

https://apost.dev/1140/

```bash
    # 하드웨어 확인
    # wlan0 이 와이파이 겟쥬?
    ls /sys/class/net
    >>>
    eth0  lo  wlan0

    # 네트워크 설정 파일 확인
    # 01-network-manager-all.yaml 혹은 50-cloud-init.yaml 둘 중의 하나가 사용된다고함.
    ls /etc/netplan/
    >>>
    50-cloud-init.yaml
    
    vi /etc/netplan/50-cloud-init.yaml
```

### 2.1. 수정 전

```
    # This file is generated from information provided by the datasource.  Changes
    # to it will not persist across an instance reboot.  To disable cloud-init's
    # network configuration capabilities, write a file
    # /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
    # network: {config: disabled}
    network:
        ethernets:
            eth0:
                dhcp4: true
                optional: true
        version: 2
```

### 2.2. 수정 후

```
    # This file is generated from information provided by the datasource.  Changes
    # to it will not persist across an instance reboot.  To disable cloud-init's
    # network configuration capabilities, write a file
    # /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
    # network: {config: disabled}
    network:
        ethernets:
            eth0:
                dhcp4: true
                optional: true
        version: 2
        wifis:
            wlan0:
                optional: true
                access-points:
                    "접속할 와이파이 SSID":
                        password: "와이파이 비번"
                dhcp4: true

```

### 2.3. 적용

```bash
    # https://blog.may-i.io/tech-7/
    # 들여쓰기 및 문법 확인해주는 명령어라고함
    sudo netplan generate

    sudo netplan apply

    ip a
    >>>
    (...)
    3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether b8:27:eb:28:34:ae brd ff:ff:ff:ff:ff:ff
    inet 192.168.35.24/24 metric 600 brd 192.168.35.255 scope global dynamic wlan0
       valid_lft 2724sec preferred_lft 2724sec
    inet6 fe80::ba27:ebff:fe28:34ae/64 scope link
       valid_lft forever preferred_lft forever

    wlan0에 ip가 잡힌것을 확인

```


## 3. 로그인 자동

https://davi06000.tistory.com/23
https://blog.naver.com/chandong83/222622684536

```bash
    sudo systemctl edit getty@tty1.service
```

nano 에디터로 열린다...

기본 설정인듯.. 어떻게 바꾸는지는 안찾음..

수정 전

```t
    ### Editing /etc/systemd/system/getty@tty1.service.d/override.conf
    ### Anything between here and the comment below will become the new contents of the file



    ### Lines below this comment will be discarded

    ### /lib/systemd/system/getty@.service
    # #  SPDX-License-Identifier: LGPL-2.1-or-later
    # #
    # #  This file is part of systemd.
    # #
    # #  systemd is free software; you can redistribute it and/or modify it
    # #  under the terms of the GNU Lesser General Public License as published by
    # #  the Free Software Foundation; either version 2.1 of the License, or
    # #  (at your option) any later version.
    #
    # [Unit]
    # Description=Getty on %I
    # Documentation=man:agetty(8) man:systemd-getty-generator(8)
    # Documentation=http://0pointer.de/blog/projects/serial-console.html
    # After=systemd-user-sessions.service plymouth-quit-wait.service getty-pre.target
    # After=rc-local.service
    #
    # # If additional gettys are spawned during boot then we should make
    # # sure that this is synchronized before getty.target, even though
    # # getty.target didn't actually pull it in.
    # Before=getty.target
    # IgnoreOnIsolate=yes
```

수정 후

```t
    ### Editing /etc/systemd/system/getty@tty1.service.d/override.conf
    ### Anything between here and the comment below will become the new contents of the file

    [Service]
    ExecStart=
    ExecStart=-/sbin/agetty --noissue --autologin %I $TERM
    Type=idle

    ### Lines below this comment will be discarded

    ### /lib/systemd/system/getty@.service
    # #  SPDX-License-Identifier: LGPL-2.1-or-later
    # #
    # #  This file is part of systemd.
    # #
    # #  systemd is free software; you can redistribute it and/or modify it
    # #  under the terms of the GNU Lesser General Public License as published by
    # #  the Free Software Foundation; either version 2.1 of the License, or
    # #  (at your option) any later version.
    #
    # [Unit]
    # Description=Getty on %I
    # Documentation=man:agetty(8) man:systemd-getty-generator(8)
    # Documentation=http://0pointer.de/blog/projects/serial-console.html
    # After=systemd-user-sessions.service plymouth-quit-wait.service getty-pre.target
    # After=rc-local.service
    #
    # # If additional gettys are spawned during boot then we should make
    # # sure that this is synchronized before getty.target, even though
    # # getty.target didn't actually pull it in.
    # Before=getty.target
    # IgnoreOnIsolate=yes
```

https://github.com/systemd/systemd/issues/24208

위와 같이 꼭 "### Anything between here and..." 라인과 "### Lines below this comment will be d~" 라인 사이에 넣어야함

안그러면 저장이 안됨...

myusername에 원하는 유저의 이름을 넣어야 함

저장        Ctrl + X 
저장 확인   y
최종 확인   엔터

리부트