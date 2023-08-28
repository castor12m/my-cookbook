### * QEMU/KVM 설치

https://www.youtube.com/watch?v=vyLNpPY-Je0&list=PLqKkf220xDDbW9G0a4XXO50yvHWFq2uOD

https://www.youtube.com/watch?v=BgZHbCDFODk

```bash
    $ lscpu | grep Virtualization
    >>> 
    Virtualization:                  VT-x
    Virtualization type:             full

    $ apt update

    $ apt install qemu-kvm              # the emulator it self
    $ apt install qemu-system-arm

    $ apt install libvirt-daemon-system # runs virtualization in background
    $ apt install libvirt-clients
    $ apt install bridge-utils # important networking dependencies >> 설치시 $ brctl show 명령 사용 가능
   

    $ adduser $USER kvm

    # restart
    $ reboot

    $ groups
    >>>
    ... kvm ... libvirt     # kvm, libvirt 가 포함되어 있어야함

    $ virsh list --all      # kvm install 확인
    >>>
    Id Name State
    -------------------
    
    $ apt install virt-manager      # the graphical program we'll use to work with our VM

    (유분투 GUI 환경에서 Virtual Machine Manager 실행)
    >>> 실행하면 QEMU/KVM 항목이 있으면 제대록 설치 된것.

```

### * 도커에서 qemu 사용하는 경우도 있는듯.

https://github.com/wanyoungj/qemu_zynqmp.git

```license
    BSD 3-Clause License

    Copyright (c) 2017, wanyoungj
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

    * Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
    FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
    SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
    CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  
```

```dockerfile
    FROM ubuntu:17.04

    # Install necessary packages
    RUN apt-get update && apt-get install -y \
        libglib2.0-dev \
        libgcrypt20-dev \
        zlib1g-dev \
        autoconf \
        automake \
        libtool \
        bison \
        flex \
        wget unzip python \ 
        libpixman-1-dev \
        libfdt-dev \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

    # get and configure qemu source
    RUN wget https://github.com/Xilinx/qemu/archive/xilinx-v2017.2.zip && unzip xilinx-v2017.2.zip
    RUN cd qemu-xilinx-v2017.2 && ./configure --target-list="aarch64-softmmu,microblazeel-softmmu" --enable-fdt --disable-kvm --disable-xen

    # Deploy qemu
    RUN cd /qemu-xilinx-v2017.2 && make && make install
    RUN mkdir /share_fs

    # Network setting
    EXPOSE 1440
 
```

### QEMU Zynq-7000

https://embed-me.com/qemu-how-to-emulate-your-zynq-7000/

```
    $ git clone -b xilinx-v2020.1 https://github.com/Xilinx/qemu.git
```

### ! ERROR: "cc" either does not exist or does not work

https://stackoverflow.com/questions/53302328/qbox-configuration-error-unable-to-find-cc

```
    $ sudo apt-get install gcc
```

# ERROR: User requested feature sdl configure was not able to find it. Install SDL2-devel

https://askubuntu.com/questions/1401615/unable-to-install-sdl2

```
    $ sudo apt-get install libsdl2-dev
```

# ERROR: pixman >= 0.21.8 not present. Please install the pixman devel package.

https://stackoverflow.com/questions/37887693/qemu-not-installing-in-ubuntu

```
    $ sudo apt-get install libpixman-1-dev
```

### boot Petalinux

https://github.com/k0nze/qemu_zynq_linux_setup/blob/master/README.md

https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842316/Linux+Prebuilt+Images
 
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/577634350/Linux+Release+Archives

```bash
    $ https://gitlab.com/qemu-project/qemu.git

    (https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842326/Zynq+2016.4+Release)
    # 위 링크에서 파일 다운로드

    $ tar xf ./2016.4-zc702-release.tar.xz 
    >>>
    zc702 $ ls -al
    BOOT.bin
    devicetree.dtb
    fsbl-zc702-zynq7.elf
    u-boot.elf
    uImage
    uramdisk.image.gz

    $ cd qemu/build/aarch64-softmmu
    $ qemu-system-aarch64 -M xilinx-zynq-a9 -serial /dev/null -serial mon:stdio -display none -kernel ../../../zc702/uImage -dtb ../../../zc702/devicetree.dtb --initrd ../../../zc702/uramdisk.image.gz
    >>> 실행됨..

    zc702-zynq7 logins : root
    root@zc702-zynq7:~# cat /proc/cpuinfo 
    processor       : 0
    model name      : ARMv7 Processor rev 0 (v7l)
    BogoMIPS        : 166.66
    Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32 
    CPU implementer : 0x41
    CPU architecture: 7
    CPU variant     : 0x3
    CPU part        : 0xc09
    CPU revision    : 0

    Hardware        : Xilinx Zynq Platform
    Revision        : 0000
    Serial          : 0000000000000000


 ```

### 여러가지 시도

```bash
    $ qemu-system-arm -M ? | grep ARM926

    integratorcp         ARM Integrator/CP (ARM926EJ-S)
    musicpal             Marvell 88w8618 / MusicPal (ARM926EJ-S)
    palmetto-bmc         OpenPOWER Palmetto BMC (ARM926EJ-S)
    realview-eb          ARM RealView Emulation Baseboard (ARM926EJ-S) 1
    versatileab          ARM Versatile/AB (ARM926EJ-S)
    versatilepb          ARM Versatile/PB (ARM926EJ-S)

    $ qemu-system-arm -M versatilepb -kernel zImage -dtb obc-obs1.dtb -drive file=obc_disk.img,format=raw -append "root=/dev/ram0 console=ttyS0"

    $ qemu-system-arm -M realview-eb -serial /dev/null -serial mon:stdio -kernel zImage -dtb obc-obs1.dtb -drive file=obc_disk.img,format=raw -append "root=/dev/ram0 console=ttyS0"
    >>>
    ...무반응

    # https://www.opensourceforu.com/2014/10/how-to-cross-compile-the-linux-kernel-with-device-tree-support/
    $ export PATH=/opt/qemu-arm/bin:$PATH
qemu-system-arm -M vexpress-a9 -m 1024 -serial stdio \
-kernel /mnt/sdcard/zImage \
-dtb /mnt/sdcard/vexpress-v2p-ca9.dtb \
-initrd /mnt/sdcard/rootfs.img -append root=/dev/ram0 console=ttyAMA0

    #https://lukaszgemborowski.github.io/articles/minimalistic-linux-system-on-qemu-arm.html
    $ qemu-system-arm -M versatilepb -kernel ./zImage -dtb obc-obs1.dtb  -serial stdio -append "serial=ttyAMA0"

    $ qemu-system-arm -M vexpress-a9 -m 1024 -serial stdio -kernel zImage -dtb obc-hyvrid.dtb -initrd rootfs.ubi -drive file=obc_disk.img,format=raw
```

```
    (https://www.qemu.org/download/)
    $ wget https://download.qemu.org/qemu-8.1.0.tar.xz
    $ ./configure --target-list=arm-softmmu --enable-fdt --disable-kvm --disable-xen
    $ tar xvJf qemu-8.1.0.tar.xz
```