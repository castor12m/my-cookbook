https://www.youtube.com/watch?v=GTrekHE8A00

## 0. 사전 설치

비주얼스튜디오 설치

## 1. WDK 설치

https://learn.microsoft.com/ko-kr/windows-hardware/drivers/download-the-wdk

위 링크의 WDK 설치 항목에서 

"WDK 10.0.22621 다운로드" 로 다운받고 설치

```
    (다운로드시 마이크로스프트에서 WDK 할때 정보 가져가는거 동의 여부 있길레 그냥 비동의 했는데 설치가능)

    설치 다되면 비주얼스튜디오의 윈도우 드라이버 키트 VSIX 도 이어서 설치가능
```

## 2. 예제 컴파일

```ps
    C:\workspace\my_cookbook\try_something\wdk\test>cl testFile.c "C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\km\x64\ntoskrnl.lib" /I "C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\km" /link /subsystem:native /driver:wdm -entry:DriverEntry
    Microsoft (R) C/C++ 최적화 컴파일러 버전 19.37.32825(x64)
    Copyright (c) Microsoft Corporation. All rights reserved.

    testFile.c
    Microsoft (R) Incremental Linker Version 14.37.32825.0
    Copyright (C) Microsoft Corporation.  All rights reserved.

    /out:testFile.exe
    /subsystem:native
    /driver:wdm
    -entry:DriverEntry
    testFile.obj
    "C:\Program Files (x86)\Windows Kits\10\Lib\10.0.22621.0\km\x64\ntoskrnl.lib"

    C:\workspace\my_cookbook\try_something\wdk\test>
```

파일 확장명 수정

```
    ren testFile.exe testFile.sys
```

## 3. 적용 확인

shift 키 누르며 재시작

문제해결 > 고급옵션 > 시작 설정 > .. > 7) Disable Driver signature enforcement

```bash
    (cmd 관리자 권한 실행)
    $ sc create nirsDriver binPath= C:\workspace\my_cookbook\try_something\wdk\test\testFile.sys type= kernel
    >>>
    [SC] CreateService 성공

    
    # DebugView 관리자 권한 실행
    # Capture -> Capture Kernel 적용
    # Capture -> Enable Verbose Kernel Output 적용

    $ sc start nirsDriver

    $ sc delete nirsDriver

    $ sc stop nirsDriver
```
DebugView 에 안뜨는뎁??


## ?. 테스트

"Native Tools Command Prompt" 실행

## ?. DebugView

https://learn.microsoft.com/ko-kr/sysinternals/downloads/debugview

## ?. WinDbg 관련

https://learn.microsoft.com/ko-kr/windows-hardware/drivers/debugger/debugger-download-tools

## ?. WDK 공식 샘플

https://github.com/Microsoft/Windows-driver-samples

## ?. WDM 참조 공식

https://learn.microsoft.com/ko-kr/windows-hardware/drivers/kernel/introduction-to-wdm

https://learn.microsoft.com/ko-kr/windows-hardware/drivers/ddi/wdm/