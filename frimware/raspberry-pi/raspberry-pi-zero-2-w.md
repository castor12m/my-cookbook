

### 1. 이미지 구울떄

#### 1.1 커스터마이징 정보

ubuntu core

라즈베라파이 웹에 계정 생성해놔야함.
core 설치 할때 계정 아이디 없으면 설치 진행 막힘.

ubuntu 22.04 64bit 로 선택해서 진행

커스터마이징 정보
```
    localhostname = raspberrypizero
    id : pi0
    passwd : ****
    SSID : 연결할 WIFI SSID
    SSID PASSWORD : 연결할 WIFI 비번
```

#### 1.2 SD카드에서 변경할것

https://askubuntu.com/questions/1384864/ubuntu-core-raspberry-pi-zero-2-w

https://qengineering.eu/install-64-os-on-raspberry-pi-zero-2.html


이미지 굽고 나서 config.txt 파일에 아래 추가

수정 전
```txt

    (...)

    [pi4] 
    ...

    (...)

```

수정 후,
```txt

    (...)

    [pi4] 
    ...

    [pi0] 
    kernel=uboot_rpi_3.bin

    (...)

```


### 2. 부팅하고 나서

https://raspberrypi.stackexchange.com/questions/98598/how-to-setup-the-raspberry-pi-3-onboard-wifi-for-ubuntu-server-18-04-with-netpla

```bash
    # Testing: 
    $ sudo netplan --debug try (continue even if there are errors)
    # Generate: 
    $ sudo netplan --debug generate (provides more details in case of issues with the previous command)
    # Apply: 
    $ sudo netplan --debug apply (if no issues during the previous commands)

    Confirmation Test:
    $ sudo reboot
```


### 3. 필수 설치할꺼?

```
    sudo apt update

    sudo apt install -y net-tools openssh-server vim

    service ssh start

    service ssh status
```


#### 3.1 install vim 실패

https://mingyucloud.tistory.com/entry/%EC%98%A4%EB%A5%98-%ED%95%B4%EA%B2%B0-Waiting-for-cache-lock-Could-not-get-lock-varlibdpkglock-frontend

vim 설치하려고하는데

Waiting for cache lock: Could not get lock /var/lib/dpkg/lock-frontend. It is held by process 

뜨는 경우 아래 조치

```
    $ sudo rm /var/lib/apt/lists/lock
    $ sudo rm /var/cache/apt/archives/lock
    $ sudo rm /var/lib/dpkg/lcok*

    $ sudo dpkg --configure -a
    $ sudo apt update
```


#### 3.2 ssh 자동 실행

https://gist.github.com/bityob/8a92b050c30f7bb5cbbbd6ea9264e6e9


다음 ssh 설정 파일에서 수정

vi /etc/ssh/sshd_config
```
    ...
    PermitRootLogin yes
    ...
```

sudo service ssh --full-restart

.bashrc 에 아래 추가

```
    # Run ssh on logging, only if not running yet
    if [ ! "$(ps -elf | grep -v grep | grep /usr/sbin/sshd)" ];
        then sudo /usr/sbin/sshd;
    fi
```

https://lindarex.github.io/ubuntu/ubuntu-ufw-setting/

ssh service 방화벽 허용
```
    sudo ufw allow ssh
```

https://gist.github.com/bityob/8a92b050c30f7bb5cbbbd6ea9264e6e9


```bash
    sudo visudo
    
    #add this line to the end of the file:
    %sudo ALL=NOPASSWD: /usr/sbin/sshd
```


#### 4. 쩝..

pi0 에 ssh 시작시켯는데

내 윈도우 pc에서 ssh 접속 실패

known_host도 지우고 햇는데

자꾸 pi0 쪽에 ssh 연결하려면 permission denied (publickkey)

발생

sshd_config 설정에 비밀번호 로그인만 해놧느데...

쩝..
