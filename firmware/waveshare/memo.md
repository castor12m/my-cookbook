

### 0. ref

- CH34X USB to Serial macOS Driver Installation Instruction
    - file:///Users/castor/workspace/my-cookbook/firmware/waveshare/ch34xser_macos/CH34X_DRV_INSTAL_INSTRUCTIONS.pdf

### 1. 기록

OSX 15.0 (Sequoia)


```bash
    git clone https://github.com/WCHSoftGroup/ch34xser_macos.git

    cd ch34xser_macos

    # 실행
    CH34xVCPDriver.dmg 

    # 런치패드에 CH34xVCPDriver 생성되면 클릭 후,
    # install 버튼 클릭
    # 당장은 아무일도 안일어남...

    # 맥 '시스템 정보' 'USB' 장비에 다음이 잡힘

    USB To UART+SPI+I2C:

    제품 ID:	0x55db
    공급업체 ID:	0x1a86
    버전:	4.41
    일련 번호:	0123456789
    속도:	최대 12Mb/초
    제조업체:	wch.cn
    위치 ID:	0x00112120 / 15
    사용 가능한 전류량(mA):	500
    필요한 전류량(mA):	200
    추가 동작 전류(mA):	0

```

```
    ls -al /dev/tty.wch* 

    # 아무것도 안잡힘

    # 맥 '시스템 설정' -> '개인 정보 보호 및 보안' -> '개발자 도구'
    # '+' 버튼 눌러서 'CH34xVCPDriver 추가

    # 실패
```

문서 내용 중 https://developer.apple.com/library/archive/technotes/tn2459/_index.html 글로 소개되는 부분이 있는데,

KEXT에 내용을 언급.

KEXT 는 Kernel Extensions 으로 타사의 커널 확장에 대한 보안을 위한 장치 기능을 하는데,

이를 풀어주기 위해서 macOS 복구 모드로 진입해야되는 것으로 보임.

그래서 일단 여기까지 알아보고 이후 진행은 중단.