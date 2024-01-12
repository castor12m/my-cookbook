

## 1. 미리 설치하면 유용한 것들

## 1.1. macPorts 설치

https://www.macports.org/install.php

brew와의 차이

https://www.scivision.dev/homebrew-macports-fink/

brew는 대중적인 macOS 패키지라면

macPorts는 소스 코드를 컴파일하여 설치 배포하기 위한 패키지이다.

## 1.2. stlink 설치

stlink 관련 설치 할것들

https://ports.macports.org/port/stlink/

```bash
    $ sudo port install stlink
    >>>
    Password:
    --->  Computing dependencies for stlink
    The following dependencies will be installed: 
    brotli
    bzip2
    cmake
    curl
    curl-ca-bundle
    expat
    gettext-runtime
    icu
    libarchive
    libb2
    libcxx
    libiconv
    libidn2
    libpsl
    libunistring
    libusb
    libuv
    libxml2
    lz4
    lzo2
    ncurses
    nghttp2
    openssl
    openssl3
    pkgconfig
    xz
    zlib
    zstd
    Continue? [Y/n]: y

    (...)

```

### 1.3. lsusb 설치

```bash
    brew install lsusb
```

```bash
    # ST 인식 전 모습
    $ lsusb
    Bus 000 Device 002: ID 8087:0b40 Intel Corporation USB3.0 Hub 
    Bus 000 Device 004: ID 2188:5500 CalDigit TS4 USB3.2 Gen2 HUB 
    Bus 000 Device 007: ID 2188:5502 CalDigit TS4 USB3.2 Gen2 HUB 
    Bus 000 Device 012: ID 2109:0812 VIA Labs, Inc. USB3.0 Hub 
    Bus 000 Device 008: ID 2188:5501 CalDigit TS4 USB3.2 Gen2 HUB 
    Bus 000 Device 001: ID 2188:5802 CalDigit TS4 USB2.0 Hub 
    Bus 000 Device 003: ID 0451:ace1 Texas Instruments TPS DMC Family  Serial: A7865616BFB2C980E14CD567FF10472
    Bus 000 Device 005: ID 2188:5510 CalDigit TS4 USB2.0 HUB 
    Bus 000 Device 006: ID 2188:7112 CalDigit Composite Device 
    Bus 000 Device 010: ID 2188:5512 CalDigit TS4 USB2.0 HUB 
    Bus 000 Device 013: ID 2109:2812 VIA Labs, Inc. USB2.0 Hub 
    Bus 000 Device 014: ID 05e3:0608 Genesys Logic, Inc. USB2.0 Hub 
    Bus 000 Device 015: ID 1a86:55d3 1a86 USB Single Serial  Serial: 5434039861
    Bus 000 Device 011: ID 05ac:024f Apple Inc. Keychron K8 
    Bus 000 Device 009: ID 2188:5511 CalDigit TS4 USB2.0 HUB 
    Bus 000 Device 000: ID 8087:0b40 Intel Corporation USB 3.1 Bus 

    # ST 인식된 모습
    $ lsusb
    Bus 000 Device 002: ID 8087:0b40 Intel Corporation USB3.0 Hub 
    Bus 000 Device 004: ID 2188:5500 CalDigit TS4 USB3.2 Gen2 HUB 
    Bus 000 Device 007: ID 2188:5502 CalDigit TS4 USB3.2 Gen2 HUB 
    Bus 000 Device 012: ID 2109:0812 VIA Labs, Inc. USB3.0 Hub 
    Bus 000 Device 008: ID 2188:5501 CalDigit TS4 USB3.2 Gen2 HUB 
    Bus 000 Device 001: ID 2188:5802 CalDigit TS4 USB2.0 Hub 
    Bus 000 Device 003: ID 0451:ace1 Texas Instruments TPS DMC Family  Serial: A7865616BFB2C980E14CD567FF10472
    Bus 000 Device 005: ID 2188:5510 CalDigit TS4 USB2.0 HUB 
    Bus 000 Device 006: ID 2188:7112 CalDigit Composite Device 
    Bus 000 Device 010: ID 2188:5512 CalDigit TS4 USB2.0 HUB 
    Bus 000 Device 013: ID 2109:2812 VIA Labs, Inc. USB2.0 Hub 
    Bus 000 Device 014: ID 05e3:0608 Genesys Logic, Inc. USB2.0 Hub 
    Bus 000 Device 015: ID 1a86:55d3 1a86 USB Single Serial  Serial: 5434039861
    Bus 000 Device 016: ID 0483:3748 STMicroelectronics STM32 STLink  Serial: Uÿm?p
                                                                                IIF2?g
    Bus 000 Device 011: ID 05ac:024f Apple Inc. Keychron K8 
    Bus 000 Device 009: ID 2188:5511 CalDigit TS4 USB2.0 HUB 
    Bus 000 Device 000: ID 8087:0b40 Intel Corporation USB 3.1 Bus 
```


## 2. 설치

https://www.e-tinkers.com/2021/01/how-to-install-stm32cubeide-on-mac-and-stm32-lora-discovery-kit/

### 2.1. st-link server 설치

### 2.2. cubeIDE 설치


## 3. cubeIDE 이용 예시

https://vuzwa.tistory.com/entry/STM32-4-STM32CubeIDE-%EC%82%AC%EC%9A%A9%EB%B0%A9%EB%B2%95

https://spacebike.tistory.com/14#google_vignette


## 3.1. 초기 프로젝트 생성시

https://m.blog.naver.com/chcbaram/222588355548

보드 선택

RCC에서 HSE를 Crystal/Ceramic Resonator로 선택합니다. 

SYS에서 Debug를 Serial Wire로 선택합니다. 

클럭 설정에서는 외부 입력은 8Mhz, PLL 소스는 HSE 그리고 System Clock Mux를 PLLCLK로 한 다음에 HCLK는 최대 속도인 설정합니다. 


### 3.1.1 절대 주의!

https://stackoverflow.com/questions/4258746/disable-automatic-perspective-change-in-eclipse

!!!! 주의 generate code 시에 "Open the associated perspective" 관련 문구 뜨면 절대 No 할것..  yes 하면 무한대기탐..


### 3.2. c++ 로 사용시

https://igotit.tistory.com/entry/STM32CubeIDE-%EC%9E%84%EB%B2%A0%EB%94%94%EB%93%9C-%EC%BD%94%EB%93%9C%EC%97%90%EC%84%9C-C-%ED%81%B4%EB%9E%98%EC%8A%A4-%ED%99%9C%EC%9A%A9

프로젝트 트리에서 프로젝트 마우스 우클릭

Convert to C++ 선택

main.c 파일명을 main.cpp 로 수정

빌드해서 확인

c++ 클래스 main.cpp 에 넣어서 확인

빌드 확인

### 3.2.1. 에러발생 : main 함수가 undefined 되어있다고 뜰때,

https://swiftcam.tistory.com/184

3.2 의 c++ 전환이 안된것



### 3.2.2. 에러발생 : cubeIDE c++ MX_FREERTOS_Init(); undefined

https://community.st.com/t5/stm32cubemx-mcus/cubeide-shows-undefined-reference-to-mx-freertos-init-if/td-p/79885

freertos.c 파일명을 freertos.cpp 로 수정


## 4. 기타 정보

STM32F429I-DISC1 개발보드 회로도 획득시

https://www.st.com/en/evaluation-tools/32f429idiscovery.html#cad-resources





## Append 1. macPort 관련 사이트

https://guide.macports.org/