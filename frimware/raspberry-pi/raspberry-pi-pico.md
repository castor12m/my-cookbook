macOS 기준 설명

## 0. 기본 정보

Raspberry Pi Pico 의 모델명은 RP2040

## 1. 연결, 환경설정, 기본빌드 설명 (in macOS)
### 1.1. 연결시

USB A type - USB C type 케이블을 통해 연결시

RPI-RP2 로 연결됨

저장장치로 잡히며 해당 디바이스에 다음 파일이 있음.

```
    INDEX.HTM
    INFO_UF2.TXT
```

### 1.2. 환경 관련 설치

https://www.robertthasjohn.com/post/how-to-set-up-the-raspberry-pi-pico-for-development-on-macos

```bash
    $ brew install cmake
    $ brew tap ArmMbed/homebrew-formulae
     ---------------x $ brew install arm-none-eabi-gcc # 기존 설치법 이였으나 사용 x, 1.4.1절 참조
    $ brew install --cask gcc-arm-embedded   

    # 환경설정 추가
    $ which arm-none-eabi-gcc
    >>>
    /opt/homebrew/bin/arm-none-eabi-gcc

    $ export PICO_TOOLCHAIN_PATH=/opt/homebrew/bin

    # 환경변수 적용 확인
    $ printenv PICO_TOOLCHAIN_PATH
    >>>
    /opt/homebrew/bin
```

https://engschool.tistory.com/128

툴체인을 특정 버전을 사용할 것이라면 https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads에서 macOS용 설치파일로 설치


### 1.3. pico-sdk 설치

```bash
    $ git clone -b master https://github.com/raspberrypi/pico-sdk.git 
    $ cd pico-sdk
    $ git submodule update --init

    $ pwd
    $ export PICO_SDK_PATH=/Users/castor/workspace/my_cookbook/raspberry_pi/git_block/pico/pico-sdk
        or
    $ export PICO_SDK_PATH=`pwd`

    # 재부팅시에도 지속 적용하고 싶다면 아래에 저장
    $ source ~/.zshrc

    # 환경변수 적용 확인
    $ printenv PICO_SDK_PATH
    >>>
    /Users/castor/workspace/my_cookbook/raspberry_pi/git_block/pico/pico-sdk

```

### 1.4. pico-examples 빌드

```bash
    $ git clone -b master https://github.com/raspberrypi/pico-examples.git

    $ cd pico-examples

    $ mkdir build

    $ cd build
```

최상위 CmakeList.txt 파일을 열어서 

```
    add_subdirectory(blink)
```

을 제외하고 다른 add_subdirectory는 모두 주석처리

```bash
    $ cmake ..

    $ make -j4
```

빌드가 완료 되면 ./build 폴더 내부에 CMakelist에 열어놓은 blink 폴더 하위에 다음 파일들이 생성됨

```
    ./blink
    ├── CMakeFiles
    ├── Makefile
    ├── blink.bin
    ├── blink.dis
    ├── blink.elf
    ├── blink.elf.map
    ├── blink.hex
    ├── blink.uf2
    ├── cmake_install.cmake
    └── elf2uf2
```


#### 1.4.1. make 시 에러

https://github.com/raspberrypi/pico-feedback/issues/355

```
    [  1%] Building ASM object pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default.dir/compile_time_choice.S.obj
    [  2%] Linking ASM executable bs2_default.elf
    arm-none-eabi-gcc: fatal error: cannot read spec file 'nosys.specs': No such file or directory
    compilation terminated.
    make[2]: *** [pico-sdk/src/rp2_common/boot_stage2/bs2_default.elf] Error 1
    make[1]: *** [pico-sdk/src/rp2_common/boot_stage2/CMakeFiles/bs2_default.dir/all] Error 2
    make: *** [all] Error 2
```

```bash
    $ brew uninstall arm-none-eabi-gcc
    $ brew auto remove
    $ brew install --cask gcc-arm-embedded    
```


### 1.5. 빌드파일 Flashing

https://www.robertthasjohn.com/post/how-to-set-up-the-raspberry-pi-pico-for-development-on-macos


```bash
    1. Open a Finder window

    2. Navigate to any of the build folders within the pico-examples folder

    3. Navigate to the blink folder (assuming you are using my example)

    4. Locate the .uf2 file but don't do anything yet

    5. Hold down the Boot button while connecting the pico to the computer (if you have a power button then this would be the time to turn it on).

    6. Keep holding the Boot button until the pico appears as a drive in your finder window. This takes approximately 3 seconds.

    7. Release the Boot button

    8. copy the uf2 file across to the pico board
```