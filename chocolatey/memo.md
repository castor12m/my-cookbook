### 1. *install chocolatey*

ref : 
  - https://digiconfactory.tistory.com/entry/CHOCOLATEY-%EC%9C%88%EB%8F%84%EC%9A%B0-%ED%8C%A8%ED%82%A4%EC%A7%80-%EB%A7%A4%EB%8B%88%EC%A0%80-%EC%84%A4%EC%B9%98
  - https://chocolatey.org/install
```powershell
    (관리자 모드 필수)
    > Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

```