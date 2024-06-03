https://canable.io/getting-started.html#socketcan-linux


### 1. 사전 설정

#### 1.1 rules 파일 생성

/etc/udev/rules.d/70-candle-usb.rules
or
/etc/udev/rules.d/99-candle-usb.rules

ex)
```
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="606f", MODE="660", GROUP="users", TAG+="uaccess"
```

or

ex)
```    
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="606f", ATTRS{serial}=="000C8005574D430A20333735", NAME="can5"
```

or

ex)
```
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="606f", ATTRS{serial}=="75834343639351A06141", SYMLINK+="ttyCAN"
```

기타)
```
    USB 장치의 경우, idProduct, idVendor 등의 번호가 동일한 제품이 존재할 수 있는데, 
    이때는 ID_USB_INTERFACE_NUM를 사용하면, USB 허브 및 포트에 꼽힌 순서대로 인덱싱 
    번호를 얻을 수 있다. 
    
    이를 이용하면, 해당되는 장치에 대한 설정 가능

    KERNEL=="ttyUSB[0-9]*", MODE="0666", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", ENV{ID_USB_INTERFACE_NUM}=="01", SYMLINK+="ttyPIO"
```


- SUBSYSTEM은 디바이스의 서브 시스템으로, 위 예에서는tty로 한다. ls 명령 등으로 장치에 부여되어 있는 이름을 보면 ttyUSB*, ttyACM* 등의 식으로 그 시스템이 tty임을 확인할 수 있었다.
- ATTRS{idVendor}, ATTRS{idProduct}, ATTRS{serial}은 각각 Vendor ID(생산자), Product ID(제품번호), Seial Number(시리얼 번호)로, 앞서 알아낸 정보를 입력해준다.
- SYMLINK+에는 장치에 부여하게 될 고유의 이름이다. 이곳에 원하는 이름을 입력해준다.
- ACTION : 특정 상황에서 작업을 행하라는 뜻으로, ACTION=="add"은 장치가 연결되면 인식하라는 의미가 된다.
- KERNEL : 커널 이름으로, 디바이스가 입력해준 커널 이름과 일치할 때 작업을 행한다.
- MODE : 읽기, 쓰기 등의 권한을 말한다.

#### 1.2 udevadm 규칙 적용

```
    sudo udevadm control --reload-rules && sudo systemctl restart systemd-udevd && sudo udevadm trigger
```

#### 1.3 udev monitor

https://ko.linux-console.net/?p=15603

```
    udevd monitor
```

### 2. UCAN 연결

UCAN을 컴퓨터에 연결

```
    dsmeg | grep usb
    
    (or)

    lsusb

```

```
    sudo slcand -o -c -s0 /dev/ttyACM0 can0

    (or)
    
    ip link set can0 up type can bitrate 1000000
```