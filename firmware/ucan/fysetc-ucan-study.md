https://canable.io/getting-started.html#socketcan-linux


## A. 리눅스계열 연결

### 1. 사전 설정

#### 1.1 장비 정보 확인

canable 장치를 사용할 PC혹은 장비에 연결한 다음, dmesg 혹은 lsusb를 통해 정보를 획득

dmesg
```
    (...)
    [4369582.705694] usb 1-1: new full-speed USB device number 4 using xhci_hcd
    [4369582.879503] usb 1-1: New USB device found, idVendor=1d50, idProduct=606f, bcdDevice= 0.00
    [4369582.879517] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
    [4369582.879523] usb 1-1: Product: canable gs_usb
    [4369582.879528] usb 1-1: Manufacturer: canable.io
    [4369582.879532] usb 1-1: SerialNumber: 0022003B5043570520353339
    [4369582.905358] CAN device driver interface
    [4369582.911110] gs_usb 1-1:1.0: Configuring for 1 interfaces
    [4369582.914401] usbcore: registered new interface driver gs_usb

```

lsusb
```
    (...)
    Bus 001 Device 004: ID 1d50:606f OpenMoko, Inc. Geschwister Schneider CAN adapter
    (...)
```

#### 1.2 rules 파일 생성

- rules 파일을 생성한다.
- 아래의 파일명 혹은 중간의 명칭은 다른것으로 해도 관계없는듯?
- 위치와 앞의 숫자?와 확장명등의 포멧만 지키면 되는듯
    - 1) /etc/udev/rules.d/70-candle-usb.rules
    - 2) /etc/udev/rules.d/99-candle-usb.rules

ex) 아래 방법 위의 rules 파일에 작성할 갖가지 예시임
```bash
    # 방법1
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="606f", MODE="660", GROUP="users", TAG+="uaccess"

    (or)

    # 방법2
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="606f", ATTRS{serial}=="000C8005574D430A20333735", NAME="can5"
    
    (or)
    
    # 방법3
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="606f", ATTRS{serial}=="75834343639351A06141", SYMLINK+="ttyCAN"

    (or)

    # 방법4
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="606f", ATTRS{serial}=="0022003B5043570520353339", SYMLINK+="ttyCAN"
```

기타)
```bash
    USB 장치의 경우, idProduct, idVendor 등의 번호가 동일한 제품이 존재할 수 있는데, 
    이때는 ID_USB_INTERFACE_NUM를 사용하면, USB 허브 및 포트에 꼽힌 순서대로 인덱싱 
    번호를 얻을 수 있다. 
    
    이를 이용하면, 해당되는 장치에 대한 설정 가능

    KERNEL=="ttyUSB[0-9]*", MODE="0666", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", ENV{ID_USB_INTERFACE_NUM}=="01", SYMLINK+="ttyPIO"

    # 시도 2024.09.21 
    SUBSYSTEMS=="usb", MODE="0666", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="606f", SYMLINK+="ttyCAN%n"
```

- SUBSYSTEM은 디바이스의 서브 시스템으로, 위 예에서는tty로 한다. ls 명령 등으로 장치에 부여되어 있는 이름을 보면 ttyUSB*, ttyACM* 등의 식으로 그 시스템이 tty임을 확인할 수 있었다.
- ATTRS{idVendor}, ATTRS{idProduct}, ATTRS{serial}은 각각 Vendor ID(생산자), Product ID(제품번호), Seial Number(시리얼 번호)로, 앞서 알아낸 정보를 입력해준다.
- SYMLINK+에는 장치에 부여하게 될 고유의 이름이다. 이곳에 원하는 이름을 입력해준다.
- ACTION : 특정 상황에서 작업을 행하라는 뜻으로, ACTION=="add"은 장치가 연결되면 인식하라는 의미가 된다.
- KERNEL : 커널 이름으로, 디바이스가 입력해준 커널 이름과 일치할 때 작업을 행한다.
- MODE : 읽기, 쓰기 등의 권한을 말한다.

#### 1.3 udevadm 규칙 적용

- rules 파일 작성->저장 이후, 다음 명령어를 통해 규칙 적용.

```bash
    sudo udevadm control --reload-rules && sudo systemctl restart systemd-udevd && sudo udevadm trigger
```

- rules과 udev가 정상 적용되었으면 /dev 아래에 원하는 네이밍으로 연결된 장비가 보일것.

#### 1.4 udev monitor (옵션)

https://ko.linux-console.net/?p=15603

```bash
    udevd monitor
    # [2024.09.21]
    # 집미니 pc에서 해당 명령어 했는데 반응안함
    # 검색해도 이 명령어가 아니라 아래 명령어로 소개해줌
    # https://ko.linux-console.net/?p=15603
    udevadm monitor
    # 이건 됨
```

### 2. UCAN 연결

#### 2.1 장비 연결 확인

UCAN을 컴퓨터에 연결

```bash
    dsmeg | grep usb
    
    (or)

    lsusb

```

#### 2.2 slcan으로 can0 연결

- [2024.09.21] mini-pc ubuntu 에서 최근 시도시
- udev 룰 추가 후, 리로드 후 아래 설치
- 딱히 아래 utils로 인해서 변화 된건 없음

- https://velog.io/@juyeon048/CAN-ubuntu-18.04%EC%97%90-%EC%8B%9C%EB%A6%AC%EC%96%BCCAN-%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4-%EC%97%B0%EA%B2%B0%ED%95%98%EA%B8%B0

- slcand 사용전에 설치하면 될듯!

```bash
    sudo apt-get install can-utils
```

```bash
    sudo slcand -o -c -s8 /dev/ttyCAN1 can0
    sudo slcand -o -c -s6 /dev/ttyCAN1 can0
    # 참고 : CAN bitrate에 대한 -s 파라미터
    #       s0 = 10k
    #       s1 = 20k
    #       s2 = 50k
    #       s3 = 100k
    #       s4 = 125k
    #       s5 = 250k
    #       s6 = 500k
    #       s7 = 750k
    #       s8 = 1M

    (or)
    
    sudo ip link set can0 up type can bitrate 1000000
    sudo ip link set can0 up type can bitrate 500000

    # 아래 명령어를 통해 수신되는 메시지 확인
    candump can0
```

```
    sudo ip link set can0 down
    (or)
    sudo ifconfig can0 down
```

## B. 윈도우 연결

- 윈도우 연결은 너무 쉽다...
- canable c-to-c 케이블 이용해서 데스크탑 본체에 연결
- 장치관리자 보니 com3 으로 잡힘
- https://canable.io/getting-started.html 사이트에서는 드라이버도 설치하라고하는데
- [Cangaroo (Beta, CANable 2.0 support) for Windows (1/22/2023 ccdcb64)](https://canable.io/utilities/cangaroo-win32-ccdcb64.zip) 바로 윈도우용 설치 해보니 잘 연결됨.
- 사용한 데스크톱의 OS는 Windows 11 Pro 23H2


## 00? 참조

- 80-socketcan.rules
    - https://gist.github.com/3mb3dw0rk5/c98d26af122d6b6ed577a5153b46f7db