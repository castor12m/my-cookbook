## LVM (Logical Volume Manager)

https://greencloud33.tistory.com/41

LVM이란
LVM(Logical Volume Manager)는 리눅스의 저장 공간을 효율적이고 유연하게 관리하기 위한 커널의 한 부분이다.

 
LVM vs. 일반 disk partitioning
LVM이 아닌 기존 방식의 경우, 하드 디스크를 파티셔닝 한 후 OS 영역에 마운트하여 read/wirte를 수행했다.
이 경우 저장 공간의 크기가 고정되어서 증설/축소가 어렵다. 이를 보완하기 위한 방법으로 LVM을 구성할 수 있다.
LVM은 파티션 대신에 volume이라는 단위로 저장 장치를 다룬다.
스토리지의 확장,변경에 유연하며, 크기를 변경할 때 기존 데이터의 이전이 필요 없다.

 
LVM 사용의 장점
유연한 용량 조절
크기 조절이 가능한 storage pool
편의에 따른 장치 이름 지정
disk striping, mirror volume등을 제공

물리적 볼륨 / PV (Physical Volume)
- 실제 디스크 장치를 분할한 파티션된 상태를의미한다.
- PV는 일정한 크기의 PE들로 구성된다.

물리적 확장 / PE (Physical Extent)
- PV를 구성하는 일정한 크기의 Block.
- 보통 1PE는 4MB에 해당한다.
- PE와 LE는 1:1로 대응한다.

볼륨 그룹 / VG (Volume Group)
- PV들이 모여서 생성되는 단위이다. (모든걸 합친 거대한 지점토 덩어리의 느낌이다)
- 사용자는 VG를 원하는대로 쪼개서 LV로 만들게 된다.

논리적 볼륨 / LV (Logical Volume)
- 사용자가 최종적으로 사용하는 단위로, VG에서 필요한 크기로 할당받아 LV를 생성한다.


### 0. 메인 드라이브를 확장하기 위해서!

초기 설치시에 해당 드라이브를 LVM 으로 설정해서 설치해야함.

그렇지 않은 경우면 재설치를 해서 메인드라이브를 LVM 으로 변경!

https://sangchul.kr/entry/%EB%A6%AC%EB%88%85%EC%8A%A4-Ubuntu-%EC%84%A4%EC%B9%98-%EC%8B%9C-%ED%8C%8C%ED%8B%B0%EC%85%98-%EB%82%98%EB%88%84%EA%B8%B0

위 사이트를 참조 해서 하려 했으나 22.04는 더 쉽게 LVM 설정이 됨.

### 1. 파티션 설정

https://congabba.tistory.com/281

```bash
    $ sudo apt-get install lvm2

    # check disk infos
    $ sudo fdisk -l
    >>>
    (...)

    Disk /dev/nvme1n1: 931.51 GiB, 1000204886016 bytes, 1953525168 sectors
    Disk model: Samsung SSD 980 PRO 1TB                 
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes

    (...)  

    $ sudo fdisk /dev/nvme1n1 
    ## fdisk command ##
    # d : delete a partition
    # f : list free unpartitioned space
    # l : list known partition types
    # n : add a new partition
    # p : print the partition table
    # t : change a partition type
    # v : verify the partition table
    # i : print information about the partition
    >>>
    Welcome to fdisk (util-linux 2.37.2).
    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.

    The device contains 'ext4' signature and it will be removed by a write command. See fdisk(8) man page and --wipe option for more details.

    Device does not contain a recognized partition table.
    Created a new DOS disklabel with disk identifier 0xf1f322c6.

    Command (m for help): n
    Partition type
    p   primary (0 primary, 0 extended, 4 free)
    e   extended (container for logical partitions)
    Select (default p): p
    Partition number (1-4, default 1): 1
    First sector (2048-1953525167, default 2048): 
    Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-1953525167, default 1953525167): 

    Created a new partition 1 of type 'Linux' and of size 931.5 GiB.

    Command (m for help): t
    Selected partition 1
    Hex code or alias (type L to list all): L

    00 Empty            24 NEC DOS          81 Minix / old Lin  bf Solaris        
    01 FAT12            27 Hidden NTFS Win  82 Linux swap / So  c1 DRDOS/sec (FAT-
    02 XENIX root       39 Plan 9           83 Linux            c4 DRDOS/sec (FAT-
    03 XENIX usr        3c PartitionMagic   84 OS/2 hidden or   c6 DRDOS/sec (FAT-
    04 FAT16 <32M       40 Venix 80286      85 Linux extended   c7 Syrinx         
    05 Extended         41 PPC PReP Boot    86 NTFS volume set  da Non-FS data    
    06 FAT16            42 SFS              87 NTFS volume set  db CP/M / CTOS / .
    07 HPFS/NTFS/exFAT  4d QNX4.x           88 Linux plaintext  de Dell Utility   
    08 AIX              4e QNX4.x 2nd part  8e Linux LVM        df BootIt         
    09 AIX bootable     4f QNX4.x 3rd part  93 Amoeba           e1 DOS access     
    0a OS/2 Boot Manag  50 OnTrack DM       94 Amoeba BBT       e3 DOS R/O        
    0b W95 FAT32        51 OnTrack DM6 Aux  9f BSD/OS           e4 SpeedStor      
    0c W95 FAT32 (LBA)  52 CP/M             a0 IBM Thinkpad hi  ea Linux extended 
    0e W95 FAT16 (LBA)  53 OnTrack DM6 Aux  a5 FreeBSD          eb BeOS fs        
    0f W95 Ext'd (LBA)  54 OnTrackDM6       a6 OpenBSD          ee GPT            
    10 OPUS             55 EZ-Drive         a7 NeXTSTEP         ef EFI (FAT-12/16/
    11 Hidden FAT12     56 Golden Bow       a8 Darwin UFS       f0 Linux/PA-RISC b
    12 Compaq diagnost  5c Priam Edisk      a9 NetBSD           f1 SpeedStor      
    14 Hidden FAT16 <3  61 SpeedStor        ab Darwin boot      f4 SpeedStor      
    16 Hidden FAT16     63 GNU HURD or Sys  af HFS / HFS+       f2 DOS secondary  
    17 Hidden HPFS/NTF  64 Novell Netware   b7 BSDI fs          fb VMware VMFS    
    18 AST SmartSleep   65 Novell Netware   b8 BSDI swap        fc VMware VMKCORE 
    1b Hidden W95 FAT3  70 DiskSecure Mult  bb Boot Wizard hid  fd Linux raid auto
    1c Hidden W95 FAT3  75 PC/IX            bc Acronis FAT32 L  fe LANstep        
    1e Hidden W95 FAT1  80 Old Minix        be Solaris boot     ff BBT            

    Aliases:
    linux          - 83
    swap           - 82
    extended       - 05
    uefi           - EF
    raid           - FD
    lvm            - 8E
    linuxex        - 85
    Hex code or alias (type L to list all): 8e
    Changed type of partition 'Linux' to 'Linux LVM'.

    Command (m for help): p
    Disk /dev/nvme1n1: 931.51 GiB, 1000204886016 bytes, 1953525168 sectors
    Disk model: Samsung SSD 980 PRO 1TB                 
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0xf1f322c6

    Device         Boot Start        End    Sectors   Size Id Type
    /dev/nvme1n1p1       2048 1953525167 1953523120 931.5G 8e Linux LVM

    Command (m for help): w
    The partition table has been altered.
    Calling ioctl() to re-read partition table.
    Syncing disks.

    $ sudo fdisk -l
    >>>
    (...)

    Disk /dev/nvme1n1: 931.51 GiB, 1000204886016 bytes, 1953525168 sectors
    Disk model: Samsung SSD 980 PRO 1TB                 
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0xf1f322c6

    Device         Boot Start        End    Sectors   Size Id Type
    /dev/nvme1n1p1       2048 1953525167 1953523120 931.5G 8e Linux LVM

    (...)

```

### 2. 물리 볼륨 생성

```bash
    $ sudo pvdisplay
    >>>
    (아무것도 출력 안 됨)

    $ sudo pvcreate /dev/nvme1n1p1

    $ sudo pvdisplay
    >>>
      "/dev/nvme1n1p1" is a new physical volume of "931.51 GiB"
    --- NEW Physical volume ---
    PV Name               /dev/nvme1n1p1
    VG Name               
    PV Size               931.51 GiB
    Allocatable           NO
    PE Size               0   
    Total PE              0
    Free PE               0
    Allocated PE          0
    PV UUID               QyQUuu-syeI-JKAm-K5NM-2x76-cFMk-C2pMtN
```


### 3. 볼륨 그룹 생성

```bash
    $ sudo pvdisplay
    >>>
      "/dev/nvme1n1p1" is a new physical volume of "931.51 GiB"
    --- NEW Physical volume ---
    PV Name               /dev/nvme1n1p1
    VG Name               
    PV Size               931.51 GiB
    Allocatable           NO
    PE Size               0   
    Total PE              0
    Free PE               0
    Allocated PE          0
    PV UUID               QyQUuu-syeI-JKAm-K5NM-2x76-cFMk-C2pMtN

    ('vg_gs' 명칭으로 볼륨 그룹 생성)
    $ vgcreate vg_gs /dev/nvme1n1p1
    ex) vgcreate [볼륨그룹명칭] [물리장치Path]                  # 물리장치 하나만 지정
    ex) vgcreate [볼륨그룹명칭] [물리장치Path0] [물리장치Path1]   # 물리장치 복수개 지정
    >>>
    Volume group "vg_gs" successfully created

    $ sudo pvdisplay
    >>>
      --- Physical volume ---
    PV Name               /dev/nvme1n1p1
    VG Name               vg_gs
    PV Size               931.51 GiB / not usable 4.71 MiB
    Allocatable           yes 
    PE Size               4.00 MiB
    Total PE              238466
    Free PE               238466
    Allocated PE          0
    PV UUID               QyQUuu-syeI-JKAm-K5NM-2x76-cFMk-C2pMtN

  
```

### 4. 논리 볼륨 생성

```bash
    $ sudo pvdisplay
    >>>
      "/dev/nvme1n1p1" is a new physical volume of "931.51 GiB"
    --- NEW Physical volume ---
    PV Name               /dev/nvme1n1p1
    VG Name               
    PV Size               931.51 GiB
    Allocatable           NO
    PE Size               0   
    Total PE              0
    Free PE               0
    Allocated PE          0
    PV UUID               QyQUuu-syeI-JKAm-K5NM-2x76-cFMk-C2pMtN

    $ sudo lvcreate -l 100%FREE -n gs_sw vg_gs
    ex)  lvcreate -L 10G -n [생성할볼륨명칭] [볼륨그룹명칭]
    ex)  lvcreate -l 100%FREE -n [생성할볼륨명칭] [볼륨그룹명칭]
    >>>
    Logical volume "gs_sw" created.

    $ sudo pvdisplay
    >>>
      --- Physical volume ---
    PV Name               /dev/nvme1n1p1
    VG Name               vg_gs
    PV Size               931.51 GiB / not usable 4.71 MiB
    Allocatable           yes (but full)
    PE Size               4.00 MiB
    Total PE              238466
    Free PE               0
    Allocated PE          238466
    PV UUID               QyQUuu-syeI-JKAm-K5NM-2x76-cFMk-C2pMtN
 
```

### 5. Mount

```bash
    $ sudo mkdir -p /gs

    $ mount /dev/vg_gs/gs_sw /gs
```


### !!6. 볼륨 그룹 확장

https://moonoostar.tistory.com/84

```bash
    $ sudo vgextend vgubuntu /dev/nvme1n1p1
    >>>
    Volume group "vgubuntu" successfully extended

    $ sudo pvscan
    >>>
    PV /dev/nvme0n1p2   VG vgubuntu        lvm2 [<931.01 GiB / 0    free]
    PV /dev/nvme1n1p1   VG vgubuntu        lvm2 [<931.51 GiB / <931.51 GiB free]
```

### !!7. 로직 볼륨 확장

https://moonoostar.tistory.com/84

```bash
    $ sudo lvscan
    >>>
    ACTIVE            '/dev/vgubuntu/root' [<929.10 GiB] inherit
    ACTIVE            '/dev/vgubuntu/swap_1' [1.91 GiB] inherit

    $ sudo lvextend -l +100%FREE -n /dev/vgubuntu/root
    >>>
    Size of logical volume vgubuntu/root changed from <929.10 GiB (237849 extents) to <1.82 TiB (476315 extents).
    Logical volume vgubuntu/root successfully resized.

    $ sudo lvscan
    ACTIVE            '/dev/vgubuntu/root' [<1.82 TiB] inherit
    ACTIVE            '/dev/vgubuntu/swap_1' [1.91 GiB] inherit

    # 파일 시스템이 ext4인 경우에는 redsize2fs 명령어를 통해 확장된 용량을 적용 해줘야 한다.
    $ sudo resize2fs /dev/vgubuntu/root
    >>>
    resize2fs 1.46.5 (30-Dec-2021)
    Filesystem at /dev/vgubuntu/root is mounted on /; on-line resizing required
    old_desc_blocks = 117, new_desc_blocks = 233
    The filesystem on /dev/vgubuntu/root is now 487746560 (4k) blocks long.

    $ df -Th
    >>>
    Filesystem                Type   Size  Used Avail Use% Mounted on
    tmpfs                     tmpfs  3.2G  2.6M  3.2G   1% /run
    /dev/mapper/vgubuntu-root ext4   1.8T  9.7G  1.7T   1% /
    tmpfs                     tmpfs   16G     0   16G   0% /dev/shm
    tmpfs                     tmpfs  5.0M  4.0K  5.0M   1% /run/lock
    /dev/nvme0n1p1            vfat   511M  6.1M  505M   2% /boot/efi
    tmpfs                     tmpfs  3.2G  168K  3.2G   1% /run/user/1000
    /dev/nvme2n1p1            ext4   458G  2.0G  433G   1% /stb

```

### Appen 1. lv vg 삭제 관련

https://2factor.tistory.com/9

```bash
    LVM 생성 및 용량 수정 , 용량 추가 ..
     
    # fdisk 로 파티션 생성 .. 
    # 파일타입을  linux LVM (8e) 로 교체후 저장
     
    # pv 생성
    $ pvcreate /dev/sdb1
    $ pvcreate /dev/sdb2
    $ pvscan
    $ pvdisplay
     
    # vg 생성
    $ vgcreate VG이름 /dev/sdb1 /dev/sdb2
    $ vgscan
    $ vgdisplay
     
    # lv 생성
    $ lvcreate -L 용량 (G,M,K) -n  LV이름 VG이름     <-- VG이름은 위에 vg 생성시 입력햇던 이름기입
    $ lvscan
    $ lvdisplay
     
    # LVM 용량 수정(확장만 가능)
    $ lvresize -L 용량 (G,M,K) LV경로
    $ lvscan
    # 이상태에서 마운트 해봐야 lvdisplay  에서는 용량이 추가 되었지만 mount 시 용량은 변경이 없다.
    $ e2fsck -f LV경로
    $ resize2fs LV경로
     
    # * 수정 테스트시 mount 상태에서도 경고메세지만 나오고 이상없이 진행되었다. 
     
    # LVM  용량 추가 (하드디스크 하나 추가 - pv 가 새로 생성)
    # fdisk 로 파티션 생성
    # file 타입을 linux LVM (8e) 로 변경
    $ pvcreate /dev/sdc1
     
    $ vgextend VG이름 /dev/sdc1
    $ vgdisplay
     
    $ lvresize -L 용량 (G,M,K) LV이름
    $ lvscan
    # 이상태에서 마운트 해봐야 lvdisplay  에서는 용량이 추가 되었지만 mount 시 용량은 변경이 없다.
    $ e2fsck -f LV이름
    $ resize2fs LV이름
     
    # 참고. 파티션 라벨명 변경 . e2label /파티션이름 /라벨명
    # 참고2. lvm 을 해체하고자 하면 만든 순서의 반대로 진행
    $ lvremove /dev/VG이름/LV이름
    $ vgremove /dev/VG이름
    $ pvremove /dev/sdb1 /dev/sdb2 /dev/sdc1
```

```bash
    781  sudo lvremove /dev/vg_gs/gs_sw
    782  sudo lvdisplay
    783  sudo vgdisplay
    784  vgremove /dev/vg_gs
    785  sudo vgremove /dev/vg_gs
    786  sudo vgdisplay
    787* sudsudo pvdisplay
    788  sudo vgcreate vg1 /dev/nvme1n1p1
    789  sudo vgdisplay
    790  sudo lvcreate -l 100%FREE -n gs vg1
    791  sudo lvdiplay
    792  sudo lvdisplay
    793  history
```

