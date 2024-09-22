
- 도커에서 zmqproxy 로그 자료

```bash
root@e7a841cc022a:/src/test/libcsp# ifconfig
can0: flags=193<UP,RUNNING,NOARP>  mtu 16
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 10  (UNSPEC)
        RX packets 16  bytes 65 (65.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 268  bytes 2026 (2.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.18.0.8  netmask 255.255.0.0  broadcast 172.18.255.255
        ether 02:42:ac:12:00:08  txqueuelen 0  (Ethernet)
        RX packets 911581  bytes 67464246 (67.4 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 911351  bytes 49209930 (49.2 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

vxcan1: flags=193<UP,RUNNING,NOARP>  mtu 72
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 1000  (UNSPEC)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

root@e7a841cc022a:/src/test/libcsp# python ./buildall_pc.py ^C
root@e7a841cc022a:/src/test/libcsp# ./build/csp_server_client -c vxcan1 -d 6 -h 10
4
Usage:
 -a <address>     local CSP address
 -d <debug-level> debug level, 0 - 6
 -r <address>     run client against server address
 -c <can-device>  add CAN device
 -k <kiss-device> add KISS device (serial)
 -z <zmq-device>  add ZMQ device, e.g. "localhost"
 -R <rtable>      set routing table
 -t               enable test mode
root@e7a841cc022a:/src/test/libcsp# ./build/csp_server_client -c vxcan1 -d 6 -a 10
4
[2024-09-22 18:44:06.158] Initialising CSP
[2024-09-22 18:44:06.158] Semaphore init: 0x577b361b6120
[2024-09-22 18:44:06.158] Semaphore init: 0x577b361b60e0
[2024-09-22 18:44:06.158] RDP 0x577b37a276f0: Creating RDP queues
[2024-09-22 18:44:06.158] Semaphore init: 0x577b37a27748
[2024-09-22 18:44:06.158] RDP 0x577b37a27778: Creating RDP queues
[2024-09-22 18:44:06.158] Semaphore init: 0x577b37a277d0
[2024-09-22 18:44:06.158] RDP 0x577b37a27800: Creating RDP queues
[2024-09-22 18:44:06.158] Semaphore init: 0x577b37a27858
[2024-09-22 18:44:06.158] RDP 0x577b37a27888: Creating RDP queues
[2024-09-22 18:44:06.158] Semaphore init: 0x577b37a278e0
[2024-09-22 18:44:06.158] RDP 0x577b37a27910: Creating RDP queues
[2024-09-22 18:44:06.158] Semaphore init: 0x577b37a27968
[2024-09-22 18:44:06.158] RDP 0x577b37a27998: Creating RDP queues
[2024-09-22 18:44:06.158] Semaphore init: 0x577b37a279f0
[2024-09-22 18:44:06.158] RDP 0x577b37a27a20: Creating RDP queues
[2024-09-22 18:44:06.158] Semaphore init: 0x577b37a27a78
[2024-09-22 18:44:06.158] RDP 0x577b37a27aa8: Creating RDP queues
[2024-09-22 18:44:06.158] Semaphore init: 0x577b37a27b00
[2024-09-22 18:44:06.158] RDP 0x577b37a27b30: Creating RDP queues
[2024-09-22 18:44:06.158] Semaphore init: 0x577b37a27b88
[2024-09-22 18:44:06.158] RDP 0x577b37a27bb8: Creating RDP queues
[2024-09-22 18:44:06.158] Semaphore init: 0x577b37a27c10
[2024-09-22 18:44:06.158] INIT CAN: device: [vxcan1], bitrate: 0, promisc: 0
Connection table
[00 0x577b37a276f0] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[01 0x577b37a27778] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[02 0x577b37a27800] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[03 0x577b37a27888] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[04 0x577b37a27910] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[05 0x577b37a27998] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[06 0x577b37a27a20] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[07 0x577b37a27aa8] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[08 0x577b37a27b30] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[09 0x577b37a27bb8] S:0, 0 -> 0, 0 -> 0, sock: (nil)
Interfaces
LOOP       tx: 00000 rx: 00000 txe: 00000 rxe: 00000
           drop: 00000 autherr: 00000 frame: 00000
           txb: 0 (0.0B) rxb: 0 (0.0B) MTU: 0

CAN        tx: 00000 rx: 00000 txe: 00000 rxe: 00000
           drop: 00000 autherr: 00000 frame: 00000
           txb: 0 (0.0B) rxb: 0 (0.0B) MTU: 2042

Route table
10/5 LOOP
0/0 CAN
[2024-09-22 18:44:06.158] GET: 0x577b37a286d0
[2024-09-22 18:44:06.158] Server task started
[2024-09-22 18:44:06.158] Wait: 0x577b361b6120 timeout 4294967295
[2024-09-22 18:44:06.158] Post: 0x577b361b6120
[2024-09-22 18:44:06.158] Binding socket 0x577b37a27778 to port 32
[2024-09-22 18:44:41.040] GET: 0x577b37a28c68
[2024-09-22 18:44:41.040] INP: S 1, D 10, Dp 1, Sp 12, Pr 2, Fl 0x00, Sz 0 VIA: CAN
[2024-09-22 18:44:41.040] Wait: 0x577b361b6120 timeout 4294967295
[2024-09-22 18:44:41.040] Post: 0x577b361b6120
CSP Connection: Source = 1:12, Dest = 10:1
[2024-09-22 18:44:41.041] SERVICE: Ping received
[2024-09-22 18:44:41.041] OUT: S 10, D 1, Dp 12, Sp 1, Pr 2, Fl 0x00, Sz 0 VIA: CAN (1)
[2024-09-22 18:44:41.041] FREE: 0x577b37a28c68
[2024-09-22 18:44:41.042] Wait: 0x577b361b6120 timeout 4294967295
[2024-09-22 18:44:41.042] Post: 0x577b361b6120
^C
root@e7a841cc022a:/src/test/libcsp# ./build/csp_server_client -c vxcan1 -d 6 -a 10 -z localhost
4
[2024-09-22 18:45:01.869] Initialising CSP
[2024-09-22 18:45:01.869] Semaphore init: 0x5f14d117e120
[2024-09-22 18:45:01.869] Semaphore init: 0x5f14d117e0e0
[2024-09-22 18:45:01.869] RDP 0x5f14d2a576f0: Creating RDP queues
[2024-09-22 18:45:01.869] Semaphore init: 0x5f14d2a57748
[2024-09-22 18:45:01.869] RDP 0x5f14d2a57778: Creating RDP queues
[2024-09-22 18:45:01.870] Semaphore init: 0x5f14d2a577d0
[2024-09-22 18:45:01.870] RDP 0x5f14d2a57800: Creating RDP queues
[2024-09-22 18:45:01.870] Semaphore init: 0x5f14d2a57858
[2024-09-22 18:45:01.870] RDP 0x5f14d2a57888: Creating RDP queues
[2024-09-22 18:45:01.870] Semaphore init: 0x5f14d2a578e0
[2024-09-22 18:45:01.870] RDP 0x5f14d2a57910: Creating RDP queues
[2024-09-22 18:45:01.870] Semaphore init: 0x5f14d2a57968
[2024-09-22 18:45:01.870] RDP 0x5f14d2a57998: Creating RDP queues
[2024-09-22 18:45:01.870] Semaphore init: 0x5f14d2a579f0
[2024-09-22 18:45:01.870] RDP 0x5f14d2a57a20: Creating RDP queues
[2024-09-22 18:45:01.870] Semaphore init: 0x5f14d2a57a78
[2024-09-22 18:45:01.870] RDP 0x5f14d2a57aa8: Creating RDP queues
[2024-09-22 18:45:01.870] Semaphore init: 0x5f14d2a57b00
[2024-09-22 18:45:01.870] RDP 0x5f14d2a57b30: Creating RDP queues
[2024-09-22 18:45:01.870] Semaphore init: 0x5f14d2a57b88
[2024-09-22 18:45:01.870] RDP 0x5f14d2a57bb8: Creating RDP queues
[2024-09-22 18:45:01.870] Semaphore init: 0x5f14d2a57c10
[2024-09-22 18:45:01.870] INIT CAN: device: [vxcan1], bitrate: 0, promisc: 0
[2024-09-22 18:45:01.870] INIT ZMQHUB: pub(tx): [tcp://localhost:6000], sub(rx): [tcp://localhost:7000], rx filters: 0
[2024-09-22 18:45:01.871] Semaphore init: 0x5f14d2a5e9d0
Connection table
[00 0x5f14d2a576f0] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[01 0x5f14d2a57778] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[02 0x5f14d2a57800] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[03 0x5f14d2a57888] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[04 0x5f14d2a57910] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[05 0x5f14d2a57998] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[06 0x5f14d2a57a20] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[07 0x5f14d2a57aa8] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[08 0x5f14d2a57b30] S:0, 0 -> 0, 0 -> 0, sock: (nil)
[09 0x5f14d2a57bb8] S:0, 0 -> 0, 0 -> 0, sock: (nil)
Interfaces
LOOP       tx: 00000 rx: 00000 txe: 00000 rxe: 00000
           drop: 00000 autherr: 00000 frame: 00000
           txb: 0 (0.0B) rxb: 0 (0.0B) MTU: 0

CAN        tx: 00000 rx: 00000 txe: 00000 rxe: 00000
           drop: 00000 autherr: 00000 frame: 00000
           txb: 0 (0.0B) rxb: 0 (0.0B) MTU: 2042

ZMQHUB     tx: 00000 rx: 00000 txe: 00000 rxe: 00000
           drop: 00000 autherr: 00000 frame: 00000
           txb: 0 (0.0B) rxb: 0 (0.0B) MTU: 1400

Route table
10/5 LOOP
0/0 ZMQHUB
[2024-09-22 18:45:01.871] GET: 0x5f14d2a586d0
[2024-09-22 18:45:01.871] Server task started
[2024-09-22 18:45:01.871] Wait: 0x5f14d117e120 timeout 4294967295
[2024-09-22 18:45:01.871] Post: 0x5f14d117e120
[2024-09-22 18:45:01.871] Binding socket 0x5f14d2a57778 to port 32
[2024-09-22 18:45:03.567] GET: 0x5f14d2a58c68
[2024-09-22 18:45:03.567] INP: S 1, D 10, Dp 1, Sp 12, Pr 2, Fl 0x00, Sz 0 VIA: CAN
[2024-09-22 18:45:03.567] Wait: 0x5f14d117e120 timeout 4294967295
[2024-09-22 18:45:03.567] Post: 0x5f14d117e120
CSP Connection: Source = 1:12, Dest = 10:1
[2024-09-22 18:45:03.567] SERVICE: Ping received
[2024-09-22 18:45:03.567] OUT: S 10, D 1, Dp 12, Sp 1, Pr 2, Fl 0x00, Sz 0 VIA: ZMQHUB (1)
[2024-09-22 18:45:03.567] Wait: 0x5f14d2a5e9d0 timeout 1000
[2024-09-22 18:45:03.567] Post: 0x5f14d2a5e9d0
[2024-09-22 18:45:03.567] FREE: 0x5f14d2a58c68
[2024-09-22 18:45:03.568] Wait: 0x5f14d117e120 timeout 4294967295
[2024-09-22 18:45:03.568] Post: 0x5f14d117e120
^C
root@e7a841cc022a:/src/test/libcsp# 
```


- host 에서 사용했던 cansend 명령 데이터

```bash
cansend vxcan0 01500001#82a04c000000
```