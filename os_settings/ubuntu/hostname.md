```bash
    $ hostname
    >>>
    nst-server1
```

```bash
    $ ifconfig
    >>>
    enp0s31f6: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
            inet 192.168.0.25  netmask 255.255.254.0  broadcast 192.168.1.255
            inet6 fe80::d67e:4c3:a025:abce  prefixlen 64  scopeid 0x20<link>
            ether c8:7f:54:56:ef:fa  txqueuelen 1000  (Ethernet)
            RX packets 12754759  bytes 8375251768 (8.3 GB)
            RX errors 0  dropped 254  overruns 0  frame 0
            TX packets 2030262  bytes 628026613 (628.0 MB)
            TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
            device interrupt 19  memory 0x85700000-85720000  
```

```bash
    $ cat /etc/resolv.conf 
    >>>
    # This is /run/systemd/resolve/stub-resolv.conf managed by man:systemd-resolved(8).
    # Do not edit.
    #
    # This file might be symlinked as /etc/resolv.conf. If you're looking at
    # /etc/resolv.conf and seeing this text, you have followed the symlink.
    #
    # This is a dynamic resolv.conf file for connecting local clients to the
    # internal DNS stub resolver of systemd-resolved. This file lists all
    # configured search domains.
    #
    # Run "resolvectl status" to see details about the uplink DNS servers
    # currently in use.
    #
    # Third party programs should typically not access this file directly, but only
    # through the symlink at /etc/resolv.conf. To manage man:resolv.conf(5) in a
    # different way, replace this symlink by a static file or a different symlink.
    #
    # See man:systemd-resolved.service(8) for details about the supported modes of
    # operation for /etc/resolv.conf.

    nameserver 127.0.0.53
    options edns0 trust-ad
    search .        
```

```bash
    $ hostnamectl
    >>>
    Static hostname: nst-server1
        Icon name: computer-desktop
            Chassis: desktop
        Machine ID: 8277e9527f304c7d84cd8d6b24a75b11
            Boot ID: 7f49cbea51a040559f9a32c111a58ed6
    Operating System: Ubuntu 22.04.3 LTS              
            Kernel: Linux 6.2.0-39-generic
        Architecture: x86-64
```


https://x86.co.kr/nassd/5983705

NAS 등 로컬 네트워크안에서 ip 대신 host name을 이용하여 접속할 때 

예: 시놀로지 dsm이 172.30.1.2 에 seo 라는 host name 을 가지고 있을 때 PC( 윈도우, 매그 리눅스) 나 IOS 계열 스마트폰(아이폰) 또는 태블릿(아이패드) 에서는  ' https:/ / seo.local:5001  또는  https: / / 172.30.1.2:5001 두 방법으로 접속이 가능합니다