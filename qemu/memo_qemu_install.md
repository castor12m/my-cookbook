### * QEMU/KVM 설치

https://www.youtube.com/watch?v=vyLNpPY-Je0&list=PLqKkf220xDDbW9G0a4XXO50yvHWFq2uOD

https://www.youtube.com/watch?v=BgZHbCDFODk

```bash
    $ lscpu | grep Virtualization
    >>> 
    Virtualization:                  VT-x
    Virtualization type:             full

    $ apt update

    $ apt install -y qemu-kvm              # the emulator it self
    $ apt install -y qemu-system-arm
    $ apt install -y libvirt-daemon-system # runs virtualization in background
    $ apt install -y libvirt-clients
    $ apt install -y bridge-utils # important networking dependencies >> 설치시 $ brctl show 명령 사용 가능

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

### 성공.

```bash
    # https://www.baeldung.com/linux/qemu-from-terminal
    $ sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
    $ kvm-ok
    >>>
    INFO: /dev/kvm exists
    KVM acceleration can be used

    $ qemu-img create -f qcow2 myVirtualDisk.qcow2 10G
    $ file myVirtualDisk.qcow2 
    >>>
    myVirtualDisk.qcow2: QEMU QCOW2 Image (v3), 1073741824 bytes

    $ qemu-system-x86_64 \
    -enable-kvm                                                    \
    -m 4G                                                          \
    -hda myVirtualDisk.qcow2                                       \
    -boot d                                                        \ 
    -cdrom linuxmint-21.1-cinnamon-64bit.iso                       \
    -netdev user,id=net0,net=192.168.0.0/24,dhcpstart=192.168.0.9  \
    -device virtio-net-pci,netdev=net0
    # 에러발생
    #>>>
    # qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.80000001H:ECX.svm [bit 2]

    # https://github.com/GNS3/gns3-server/issues/1639
    # -cpu host 옵션 추가
    $ qemu-system-x86_64 -enable-kvm -m 4G -hda myVirtualDisk.qcow2 -boot d -cdrom linuxmint-21.1-cinnamon-64bit.iso -netdev user,id=net0,net=192.168.0.0/24,dhcpstart=192.168.0.9 -device virtio-net-pci,netdev=net0 -cpu host

    # qemu 윈도우 창이 뜸 성공

```

```bash
    $ qemu-system-x86_64 \
    -enable-kvm                                                    \
    -m 4G                                                          \
    -smp 2                                                         \
    -hda myVirtualDisk.qcow2                                       \
    -boot d                                                        \
    -cdrom linuxmint-21.1-cinnamon-64bit.iso                       \
    -netdev user,id=net0,net=192.168.0.0/24,dhcpstart=192.168.0.9  \
    -device virtio-net-pci,netdev=net0                             \
    -vga qxl                                                       \
    -device AC97

    Let’s look at the meaning of each option:

    -enable-kvm → KVM to boost performance
    -m 4G → 4GB RAM
    -smp 2 → 2CPUs
    -hda myVirtualDisk.qcow2 → our 20GB variable-size disk
    -boot d → boots the first virtual CD drive
    -cdrom linuxmint-21.1-cinnamon-64bit.iso → Linux Mint ISO
    -netdev user,id=net0,net=192.168.0.0/24,dhcpstart=192.168.0.9 → NAT with DHCP
    -device virtio-net-pci,netdev=net0 → network card
    -vga qxl → powerful graphics card
    -device AC97 → sound card
```

### 성공!

```bash
    $ git clone git://git.denx.de/u-boot.git 
    $ cd u-boot

    # https://u-boot.readthedocs.io/en/v2023.07.02/board/emulation/qemu-arm.html#building-u-boot
    $ make CROSS_COMPILE=arm-none-eabi- ARCH=arm qemu_arm_defconfig
    $ make qemu_arm_defconfig
    $ make
    $ qemu-system-arm -machine virt -nographic -bios u-boot.bin
    
```

```bash
    ```
        (https://u-boot.readthedocs.io/en/v2023.07.02/board/emulation/qemu-arm.html#building-u-boot 사이트 내용)
        QEMU ARM¶
        QEMU for ARM supports a special ‘virt’ machine designed for emulation and virtualization purposes. This document describes how to run U-Boot under it. Both 32-bit ARM and AArch64 are supported.

        The ‘virt’ platform provides the following as the basic functionality:

        A freely configurable amount of CPU cores

        U-Boot loaded and executing in the emulated flash at address 0x0

        A generated device tree blob placed at the start of RAM

        A freely configurable amount of RAM, described by the DTB

        A PL011 serial port, discoverable via the DTB

        An ARMv7/ARMv8 architected timer

        PSCI for rebooting the system

        A generic ECAM-based PCI host controller, discoverable via the DTB

        Additionally, a number of optional peripherals can be added to the PCI bus.

        See Devicetree in QEMU for information on how to see the devicetree actually generated by QEMU.

        Building U-Boot¶
        Set the CROSS_COMPILE environment variable as usual, and run:

        For ARM:

        $ make qemu_arm_defconfig
        $ make
        For AArch64:

        $ make qemu_arm64_defconfig
        $ make
        Running U-Boot¶
        The minimal QEMU command line to get U-Boot up and running is:

        For ARM:

        $ qemu-system-arm -machine virt -nographic -bios u-boot.bin
        For AArch64:

        $ qemu-system-aarch64 -machine virt -nographic -cpu cortex-a57 -bios u-boot.bin
        Note that for some odd reason qemu-system-aarch64 needs to be explicitly told to use a 64-bit CPU or it will boot in 32-bit mode. The -nographic argument ensures that output appears on the terminal. Use Ctrl-A X to quit.

        Additional persistent U-boot environment support can be added as follows:

        Create envstore.img using qemu-img:

        $ qemu-img create -f raw envstore.img 64M
        Add a pflash drive parameter to the command line:

        $ ... -drive if=pflash,format=raw,index=1,file=envstore.img
        Additional peripherals that have been tested to work in both U-Boot and Linux can be enabled with the following command line parameters:

        To add a Serial ATA disk via an Intel ICH9 AHCI controller, pass e.g.:
    ```

    $ ... -drive if=none,file=disk.img,format=raw,id=mydisk \
    $ ... -device ich9-ahci,id=ahci -device ide-drive,drive=mydisk,bus=ahci.0
    # To add an Intel E1000 network adapter, pass e.g.:

    $ ... -netdev user,id=net0 -device e1000,netdev=net0
    # To add an EHCI-compliant USB host controller, pass e.g.:

    $ ... -device usb-ehci,id=ehci
    # To add an NVMe disk, pass e.g.:

    $ ... -drive if=none,file=disk.img,id=mydisk -device nvme,drive=mydisk,serial=foo
    # To add a random number generator, pass e.g.:

    $ ... -device virtio-rng-pci
    # These have been tested in QEMU 2.9.0 but should work in at least 2.5.0 as well.

    # Enabling TPMv2 support¶
    # To emulate a TPM the swtpm package may be used. It can be built from the following repositories:

    # https://github.com/stefanberger/swtpm.git

    # Swtpm provides a socket for the TPM emulation which can be consumed by QEMU.

    # In a first console invoke swtpm with:

    $ ... swtpm socket --tpmstate dir=/tmp/mytpm1   \
    --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock --log level=20
    # In a second console invoke qemu-system-aarch64 with:

    $ ... -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
    -tpmdev emulator,id=tpm0,chardev=chrtpm \
    -device tpm-tis-device,tpmdev=tpm0
    # Enable the TPM on U-Boot’s command line with:

    $ ... tpm2 startup TPM2_SU_CLEAR
    # Debug UART¶
    # The debug UART on the ARM virt board uses these settings:

    CONFIG_DEBUG_UART=y
    CONFIG_DEBUG_UART_PL010=y
    CONFIG_DEBUG_UART_BASE=0x9000000
    CONFIG_DEBUG_UART_CLOCK=0
```

### 용어.

https://ko.wikipedia.org/wiki/SCSI

SCSI (Small Computer System Interface)

스커지/스카시 (scuzzy->본단어의 뜻 지저분한?), 컴퓨터에 주변기기를 연결할 때 직렬방식으로 연결하기 위한 표준.


### qemu 마운트

```bash
    (마운트)
    $ sudo mount -t ext2 -o rw,loop {mount_커널이미지?} {mount_할_포스트디렉토리}
    $ sudo mount -t ext2 -o rw,loop output/images/rootfs.ext2 /home/embeddedcraft/try

    (마운트해제)
    $ sudo unmount try

```