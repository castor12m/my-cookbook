## 새로운 저장장치 파티션 설정 후, 마운트 까지!

### 1. 파티션 설정

```bash 
    $ sudo fdisk -l 
    >>>
    (...)

    Disk /dev/nvme2n1: 465.76 GiB, 500107862016 bytes, 976773168 sectors
    Disk model: Samsung SSD 980 PRO 500GB               
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes


    Disk /dev/nvme1n1: 931.51 GiB, 1000204886016 bytes, 1953525168 sectors
    Disk model: Samsung SSD 980 PRO 1TB                 
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes


    Disk /dev/nvme0n1: 931.51 GiB, 1000204886016 bytes, 1953525168 sectors
    Disk model: Samsung SSD 980 PRO 1TB                 
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: gpt
    Disk identifier: 8E25DF16-2FE6-481D-BE65-3BD863541813

    Device           Start        End    Sectors  Size Type
    /dev/nvme0n1p1    2048    1050623    1048576  512M EFI System
    /dev/nvme0n1p2 1050624 1953523711 1952473088  931G Linux filesystem

    (...)

    $ df -h
    >>>
    Filesystem      Size  Used Avail Use% Mounted on
    tmpfs           3.2G  3.2M  3.2G   1% /run
    /dev/nvme0n1p2  916G   87G  782G  10% /
    tmpfs            16G     0   16G   0% /dev/shm
    tmpfs           5.0M  4.0K  5.0M   1% /run/lock
    /dev/nvme0n1p1  511M  6.1M  505M   2% /boot/efi
    tmpfs           3.2G  1.7M  3.2G   1% /run/user/1000

    $ sudo fdisk /dev/nvme2n1
    >>>
    Welcome to fdisk (util-linux 2.37.2).
    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.

    The device contains 'ext4' signature and it will be removed by a write command. See fdisk(8) man page and --wipe option for more details.

    Device does not contain a recognized partition table.
    Created a new DOS disklabel with disk identifier 0x90df13fc.

    Command (m for help): n
    Partition type
    p   primary (0 primary, 0 extended, 4 free)
    e   extended (container for logical partitions)
    Select (default p): p
    Partition number (1-4, default 1): 1
    First sector (2048-976773167, default 2048): 
    Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-976773167, default 976773167): 

    Created a new partition 1 of type 'Linux' and of size 465.8 GiB.

    Command (m for help): p
    Disk /dev/nvme2n1: 465.76 GiB, 500107862016 bytes, 976773168 sectors
    Disk model: Samsung SSD 980 PRO 500GB               
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x90df13fc

    Device         Boot Start       End   Sectors   Size Id Type
    /dev/nvme2n1p1       2048 976773167 976771120 465.8G 83 Linux

    Command (m for help): w
    The partition table has been altered.
    Calling ioctl() to re-read partition table.
    Syncing disks.

    $ sudo fdisk -l 
    >>>
    (...)

    Disk /dev/nvme2n1: 465.76 GiB, 500107862016 bytes, 976773168 sectors
    Disk model: Samsung SSD 980 PRO 500GB               
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x90df13fc

    Device         Boot Start       End   Sectors   Size Id Type
    /dev/nvme2n1p1       2048 976773167 976771120 465.8G 83 Linux


    Disk /dev/nvme1n1: 931.51 GiB, 1000204886016 bytes, 1953525168 sectors
    Disk model: Samsung SSD 980 PRO 1TB                 
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes


    Disk /dev/nvme0n1: 931.51 GiB, 1000204886016 bytes, 1953525168 sectors
    Disk model: Samsung SSD 980 PRO 1TB                 
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: gpt
    Disk identifier: 8E25DF16-2FE6-481D-BE65-3BD863541813

    Device           Start        End    Sectors  Size Type
    /dev/nvme0n1p1    2048    1050623    1048576  512M EFI System
    /dev/nvme0n1p2 1050624 1953523711 1952473088  931G Linux filesystem
    (...)

```

### 2. 마운트

```bash
    (루트에 stb 폴더 명으로 마운트 할 계획)
    $ sudo mkdir -p /stb

    $ sudo blkid
    >>>
    /dev/nvme0n1p2: UUID="f6406d7f-82e1-48bf-8137-bad2e5d4b9a9" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="c30c1b72-c316-4276-9006-a91fc76f842e"
    (...)
    /dev/nvme0n1p1: UUID="E113-9758" BLOCK_SIZE="512" TYPE="vfat" PARTLABEL="EFI System Partition" PARTUUID="a5d7cac7-b592-48d0-bde1-87b0c3c0789e"
    (...)
    /dev/nvme2n1p1: LABEL="STB" UUID="479ce34f-1352-4384-8f48-a611bf2a8362" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="90df13fc-01"
    (...)

    $ sudo vi /etc/fstab
    >>>
    (아래 내용 추가)
    UUID=479ce34f-1352-4384-8f48-a611bf2a8362 /stb            ext4    errors=remount-ro 0       1

    $ sudo mount -a

    $ df -hT
    >>>
    Filesystem     Type   Size  Used Avail Use% Mounted on
    tmpfs          tmpfs  3.2G  3.2M  3.2G   1% /run
    /dev/nvme0n1p2 ext4   916G   87G  782G  10% /
    tmpfs          tmpfs   16G     0   16G   0% /dev/shm
    tmpfs          tmpfs  5.0M  4.0K  5.0M   1% /run/lock
    /dev/nvme0n1p1 vfat   511M  6.1M  505M   2% /boot/efi
    tmpfs          tmpfs  3.2G  1.7M  3.2G   1% /run/user/1000
    /dev/nvme2n1p1 ext4   458G   28K  435G   1% /stb

    $ lsblk
    >>>
    NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
    loop0         7:0    0     4K  1 loop /snap/bare/5
    loop1         7:1    0  63.5M  1 loop /snap/core20/2015
    loop2         7:2    0  63.9M  1 loop /snap/core20/2105
    loop3         7:3    0  74.1M  1 loop /snap/core22/1033
    loop4         7:4    0  73.9M  1 loop /snap/core22/864
    loop5         7:5    0 245.6M  1 loop /snap/firefox/3416
    loop6         7:6    0 245.9M  1 loop /snap/firefox/3600
    loop7         7:7    0 349.7M  1 loop /snap/gnome-3-38-2004/143
    loop8         7:8    0 496.9M  1 loop /snap/gnome-42-2204/132
    loop9         7:9    0   497M  1 loop /snap/gnome-42-2204/141
    loop10        7:10   0  91.7M  1 loop /snap/gtk-common-themes/1535
    loop11        7:11   0  12.3M  1 loop /snap/snap-store/959
    loop12        7:12   0  40.9M  1 loop /snap/snapd/20290
    loop13        7:13   0  40.4M  1 loop /snap/snapd/20671
    loop14        7:14   0   452K  1 loop /snap/snapd-desktop-integration/83
    nvme2n1     259:0    0 465.8G  0 disk 
    └─nvme2n1p1 259:5    0 465.8G  0 part /stb
    nvme1n1     259:1    0 931.5G  0 disk 
    nvme0n1     259:2    0 931.5G  0 disk 
    ├─nvme0n1p1 259:3    0   512M  0 part /boot/efi
    └─nvme0n1p2 259:4    0   931G  0 part /var/snap/firefox/common/host-hunspell

```

### Append 1. DDS(Data Distribution Service) Partition 종류

https://yunjipark0623.tistory.com/entry/%ED%8C%8C%ED%8B%B0%EC%85%98Partition-Primary-Partition-Extended-Partition-Logical-Partition

```yaml
    1. Primary Partition (주 영역)
    - 실제 데이터를 저장합니다. 운영체제 설치가 가능한 파티션입니다.
    - 파티션 생성시 MBR(Master Boot Record) Partition Table 16Byte가 소모됩니다.
    - 최소 1개부터 최대 4개까지 생성 가능합니다.

    2. Extended Partition (확장 영역)
    - 실제 데이터는 저장 불가능한 영역입니다. 부족한 파티션 테이블 영역을 확장시키는 용도로 사용합니다.
    - 실제 데이터를 담는 영역이 아니기 때문에 파일시스템 형식도 지정하지 못하고 마운트도 불가능합니다.
    - 논리 영역을 담는 바구니 역할을 합니다.
    - 1개만 생성가능하며, MBR Partition Table 16Byte가 소모됩니다.

    3. Logical Partition (논리 영역)
    - 확장 영역이 갖는 범위 안에서 생성되는 파티션입니다.
    - 실제 데이터를 저장 가능하고 운영체제 설치는 불가능합니다.
    - 제한 없이 생성가능합니다. (확장 영역의 디스크 할당 용량만큼)
```

### Append 2. Disklabel type: gpt

https://velog.io/@jinhasong/Mount-GPT-HDD

```bash
    #Change disk label type
    #4TB 이상의 HDD의 경우 MBR이 아닌 GPT로 disk label type을 변경해줘야 한다.
    #Disk label type을 변경하기 위해서는 parted 명령어를 이용하여 변경해야 한다.

    #Command
    $ parted /dev/sdb
    
    #ExampleLog
    #GNU Parted 3.2
    #Using /dev/sdb
    #Welcome to GNU Parted Type 'help' to view a list of commands.
    #(parted) mklabel gpt
    #Create partition
    #Command
    #(parted) mkpart
    #Partition name? []? <enter>
    #File system type? [ext2] <enter>
    #Start? 1
    #End? 3.7TB
    #(parted) q
    #Disk label을 변경후 해당 HDD에서 원하는 만큼의 용량을 할당한 파티션을 생성한다.
    #파티션 생성 시 파티션 이름과 file system type은 기본 값으로 두고 원하는 용량 만큼 start end를 설정한다.
    #모든 설정을 마친 후 q로 parted 명령어를 종료한다.
    #Format partition
    #생성한 파티션을 mkfs 명령어를 이용하여 포맷한다.

    #Command
    $ mkfs.ext4 /dev/sdb

    #Example Log
    #mke2fs 1.44.1 (29-July-2021)
    #Found a gpt partition table in /dev/sdb
    #Proceed anyway? (y,N) y
    #Creating filesystem with 1610612736 4k blocks and 201326592 inodes
    #Filesystem UUID: #########################
    #Super block backups stored on blocks:

    #Allocating group tables: done
    #Writing inode tables: done
    #Creating journal (262144 blocks):
    #done
```


### Append 3. partition format

https://promobile.tistory.com/371

```bash
    # ext4로 포맷
    $ sudo mkfs.ext4 /dev/nvme0n1p1

    # 현재 하드디스크 파티션 정보의 파일시스템 정보 확인
    $ sudo blkid
```

