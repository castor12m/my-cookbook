
## 0. ref
- 남규씨 자료
    - https://gainful-maize-c29.notion.site/Frontier-S-ICB-1400a095fa60805aaa67d804e7cb0e46

## 1. USB Pass-though to WSL

- 윈도우 OS가 탑재된 데스크탑에 연결된 USB장치를 WSL에서 접근하기 위해서는
- USB pass-through를 활성화 해줘야함.

### 1.1 방법

1. 다음 링크에서 usbipd.msi 파일을 다운 받아 윈도우에서 실행.
    - https://github.com/dorssel/usbipd-win/releases

2. 윈도우에서 관리자 권한으로 PowerShell을 실행, 다음과 같이 USB 장치 목록을 확인

```powershell
    PS C:\Windows\system32>usbipd list
    Connected:
    BUSID  VID:PID    DEVICE                                                        STATE
    1-11   048d:5702  USB 입력 장치                                                  Not shared
    3-1    046d:c52b  Logitech USB Input Device, USB 입력 장치                       Not shared
    5-2    0403:6001  USB Serial Converter                                         Not shared
```

3. 출력된 목록에서 연결하고 자하는 USB 장치(여기서는 5-2) 의 USB-ID를 확인

4. USB 장치를 바인딩

```powershell
    PS C:\Windows\system32>usbipd bind --busid 5-2
```

5. USB 목록을 출력 해보면 다음과 같이 Not shared 에서 Shared 로 변경 된것을 확인
- 사용하는 USB 장치는 USB 포트에 따라 USB ID가 변경 될 수 있다.

```powershell
    PS C:\Windows\system32>usbipd list
    Connected:
    BUSID  VID:PID    DEVICE                                                        STATE
    1-11   048d:5702  USB 입력 장치                                                  Not shared
    3-1    046d:c52b  Logitech USB Input Device, USB 입력 장치                       Not shared
    5-2    0403:6001  USB Serial Converter                                          Shared
```

6. USB 장치를 WSL에 할당

```powershell
    PS C:\Windows\system32>usbipd attach --wsl --busid 5-2
    usbipd: info: Using WSL distribution 'Ubuntu' to attach; the device will be available in all WSL 2 distributions.
    usbipd: info: Using IP address 172.26.128.1 to reach the host.
    PS C:\Windows\system32>usbipd list
    Connected:
    BUSID  VID:PID    DEVICE                                                        STATE
    1-11   048d:5702  USB 입력 장치                                                  Not shared
    3-1    046d:c52b  Logitech USB Input Device, USB 입력 장치                       Not shared
    5-2    0403:6001  USB Serial Converter                                          Attached
```

7. 올바르게 WSL에 할당 되었다면 다음 명령어를 WSL에서 수행하면 장치라 검색될 것

```bash
    $ dmesg | awk '/tty/ && /USB/ {print "/dev/"$NF}'
```