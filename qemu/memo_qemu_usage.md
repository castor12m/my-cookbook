

https://huroint.tistory.com/17

```bash
    # 어떤 ARM 시스템을 에뮬레이팅 할 수 있는지 확인
    $ qemu-system-arm -M ?
    >>>

    Supported machines are:
    akita                Sharp SL-C1000 (Akita) PDA (PXA270)
    ast2500-evb          Aspeed AST2500 EVB (ARM1176)
    ast2600-evb          Aspeed AST2600 EVB (Cortex A7)
    borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
    canon-a1100          Canon PowerShot A1100 IS
    cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
    collie               Sharp SL-5500 (Collie) PDA (SA-1110)
    connex               Gumstix Connex (PXA255)
    cubieboard           cubietech cubieboard (Cortex-A8)
    emcraft-sf2          SmartFusion2 SOM kit from Emcraft (M2S010)
    highbank             Calxeda Highbank (ECX-1000)
    imx25-pdk            ARM i.MX25 PDK board (ARM926)
    integratorcp         ARM Integrator/CP (ARM926EJ-S)
    kzm                  ARM KZM Emulation Baseboard (ARM1136)
    lm3s6965evb          Stellaris LM3S6965EVB
    lm3s811evb           Stellaris LM3S811EVB
    mainstone            Mainstone II (PXA27x)
    mcimx6ul-evk         Freescale i.MX6UL Evaluation Kit (Cortex A7)
    mcimx7d-sabre        Freescale i.MX7 DUAL SABRE (Cortex A7)
    microbit             BBC micro:bit
    midway               Calxeda Midway (ECX-2000)
    mps2-an385           ARM MPS2 with AN385 FPGA image for Cortex-M3
    mps2-an505           ARM MPS2 with AN505 FPGA image for Cortex-M33
    mps2-an511           ARM MPS2 with AN511 DesignStart FPGA image for Cortex-M3
    mps2-an521           ARM MPS2 with AN521 FPGA image for dual Cortex-M33
    musca-a              ARM Musca-A board (dual Cortex-M33)
    musca-b1             ARM Musca-B1 board (dual Cortex-M33)
    musicpal             Marvell 88w8618 / MusicPal (ARM926EJ-S)
    n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
    n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
    netduino2            Netduino 2 Machine
    none                 empty machine
    nuri                 Samsung NURI board (Exynos4210)
    palmetto-bmc         OpenPOWER Palmetto BMC (ARM926EJ-S)
    raspi2               Raspberry Pi 2
    realview-eb          ARM RealView Emulation Baseboard (ARM926EJ-S)
    realview-eb-mpcore   ARM RealView Emulation Baseboard (ARM11MPCore)
    realview-pb-a8       ARM RealView Platform Baseboard for Cortex-A8
    realview-pbx-a9      ARM RealView Platform Baseboard Explore for Cortex-A9
    romulus-bmc          OpenPOWER Romulus BMC (ARM1176)
    sabrelite            Freescale i.MX6 Quad SABRE Lite Board (Cortex A9)
    smdkc210             Samsung SMDKC210 board (Exynos4210)
    spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
    swift-bmc            OpenPOWER Swift BMC (ARM1176)
    sx1                  Siemens SX1 (OMAP310) V2
    sx1-v1               Siemens SX1 (OMAP310) V1
    terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
    tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
    verdex               Gumstix Verdex (PXA270)
    versatileab          ARM Versatile/AB (ARM926EJ-S)
    versatilepb          ARM Versatile/PB (ARM926EJ-S)
    vexpress-a15         ARM Versatile Express for Cortex-A15
    vexpress-a9          ARM Versatile Express for Cortex-A9
    virt-2.10            QEMU 2.10 ARM Virtual Machine
    virt-2.11            QEMU 2.11 ARM Virtual Machine
    virt-2.12            QEMU 2.12 ARM Virtual Machine
    virt-2.6             QEMU 2.6 ARM Virtual Machine
    virt-2.7             QEMU 2.7 ARM Virtual Machine
    virt-2.8             QEMU 2.8 ARM Virtual Machine
    virt-2.9             QEMU 2.9 ARM Virtual Machine
    virt-3.0             QEMU 3.0 ARM Virtual Machine
    virt-3.1             QEMU 3.1 ARM Virtual Machine
    virt-4.0             QEMU 4.0 ARM Virtual Machine
    virt-4.1             QEMU 4.1 ARM Virtual Machine
    virt                 QEMU 4.2 ARM Virtual Machine (alias of virt-4.2)
    virt-4.2             QEMU 4.2 ARM Virtual Machine
    witherspoon-bmc      OpenPOWER Witherspoon BMC (ARM1176)
    xilinx-zynq-a9       Xilinx Zynq Platform Baseboard for Cortex-A9
    z2                   Zipit Z2 (PXA27x)
```

### 포트포워딩? 가능?

https://k1rha.tistory.com/entry/qemu-for-window-%EC%97%90%EC%84%9C-%ED%8F%AC%ED%8A%B8%ED%8F%AC%EC%9B%8C%EB%94%A9-%ED%95%98%EC%97%AC-%EB%82%B4%EB%B6%80%EC%97%90-%EC%A0%91%EC%86%8D%ED%95%98%EA%B8%B0-How-to-networking-in-qemu

```bash
    $ ... -redir tcp:8080::80 -redir tcp:22222::22 
```

### QEMU 에서 빠져 나오기

https://www.hackerschool.org/HardwareHacking/%EA%B3%B5%EC%9C%A0%EA%B8%B0%20%ED%95%B4%ED%82%B9%20-%20ARM%20exploitation.pdf

**추천! 위 사이트 내용 좋음

ctrl + a + x

ctrl + a 먼저 눌렀다가 뗀후 이어서 x

### 관련 내용중 qemu-system-arm 옵션 참고용으로 적음 . 리눅스 커널 빌드 테스트 

https://hyeyoo.com/148

**추천! 위 사이트 내용 좋음

``` bash
    # 커널 소스 다운
    $ wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.15.5.tar.xz
    $ tar -xvf linux-5.15.5.tar.xz
    $ cd linux-5.15.5

    # 우선 기본 설절인 defconfig 로 빌드
    $ make defconfig
    $ make -j6

    # 사이즈 확인
    $ size vmlinux
    >>>
    text	           data	    bss	     dec	    hex filename
    19994945	6728404	2216168	28939517	1b994fd	vmlinux
    # defconfig로 빌드하면 약 27MiB 정도의 바이너리가 생긴다. vmlinux는 커널을 정적으로 링크한 바이너리 파일로, 압축되지 않은 상태이므로 실제 메모리에 올라왔을 때와 크기가 거의 비슷하다.

    # ...

    # 커널로만 부팅
    $ qemu-system-arm -M versatilepb -kernel arch/arm/boot/zImage -dtb arch/arm/boot/dts/versatile-pb.dtb -append "serial=ttyAMA0" -nographic

    # ...

    # initramfs와 함께 부팅
    $ qemu-system-arm -M versatilepb -kernel arch/arm/boot/zImage -dtb arch/arm/boot/dts/versatile-pb.dtb -append "root=/dev/mem" -nographic -m 6750K -initrd rootfs.cpio.gz
```

### 펌웨어 분석?

https://devdori.tistory.com/45

```bash
    $ sudo apt-get install binwalk

    # 대상 펌웨어 아키텍쳐 식별
    $ binwalk -A {대상 파일}
    ex) $ binwalk -A t24xxxxxxx_.bin

    # 대상 펌웨어 파일 시스템 추출
    $ binwalk -e {대상 파일}

    # ...

    # ssh를 위한 22번 및 cgi(common gateway interface)를 위한 80 포트를 포트 포워딩
    $ qemu-system-arm -M versatilepb -kernel vmlinuz-3.2.0-4-versatile -initrd initrd.img-3.2.0-4-versatile -hda debian_wheezy_armel_standard.qcow2 -append "root=/dev/sda1" -redir tcp:2080::80 -redir tcp:2022::22

```