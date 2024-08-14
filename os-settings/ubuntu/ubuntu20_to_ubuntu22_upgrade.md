---- 아래 하지말것 안됨.
---- 네트워크 끊겨서 업그레이드를 할 수 없게 됨.

https://ko.linux-console.net/?p=3627

```
    $ apt-get update -y
    $ apt-get upgrade -y
    $ apt-get dist-upgrade -y
    그런 다음 다음 명령을 사용하여 원하지 않는 패키지를 모두 제거하십시오.

    $ apt-get autoremove
    그런 다음 다음 명령을 사용하여 APT 패키지 캐시를 정리합니다.

    $ apt-get clean
    그런 다음 시스템을 다시 시작하여 모든 업데이트를 적용하십시오.

    $ reboot
    do-release-upgrade 도구를 사용하여 Ubuntu 22.04로 업데이트
    이제 do-release-upgrade 도구를 사용하여 Ubuntu 22.04로 업그레이드할 수 있습니다. 다음 명령을 실행합니다.

    $ do-release-upgrade
    화면에 표시된 업그레이드 단계를 진행하십시오. 이 도구는 때때로 입력을 요청하며 옵션을 선택/확인한 후에만 계속됩니다.

    도구가 완료되면 서버를 재부팅하십시오. 업그레이드 프로세스 중에 이 작업을 수행하지 않은 경우 수동으로 수행하십시오.

    $ reboot
    Ubuntu 22.04 업그레이드 확인
    이 시점에서 서버는 Ubuntu 22.04로 업그레이드됩니다. 이제 다음 명령을 사용하여 확인할 수 있습니다.

    $ lsb_release -a
    >>>
    No LSB modules are available.
    Distributor ID: Ubuntu
    Description:    Ubuntu 22.04.1 LTS
    Release:        22.04
    Codename:       jammy
```