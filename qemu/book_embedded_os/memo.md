
### 2 장

##### 2.1 크로스 컴파일러 설치

abi = application binary interface
eabi = embedded abi

```bash
    $ sudo apt install -y gcc-arm-none-eabi
    $ arm-none-eabi-gcc --version
    >>>
    arm-none-eabi-gcc (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]
    Copyright (C) 2019 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```
##### 2.2 qemu 설치

```bash
    # qemu-system-arm 설치
    $ sudo apt install -y qemu-system-arm    

    # qemu-system-arm 버전확인
    $ qemu-system-arm --version
    >>>
    QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.27)
    Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

    # qemu-system-arm 에서 지원하는 머신 확인
    $ qemu-system-arm -M ?
    Supported machines are:
    akita                Sharp SL-C1000 (Akita) PDA (PXA270)
    ...
    z2                   Zipit Z2 (PXA27x)

```


### 3 장

##### 3.1 어셈블리어 파일 빌드

```S
    (/boot/Entry.S)

    .text
        .code 32

        .global vector_start
        .global vector_end

        vector_start:
            MOV R0, R1
        vector_end:
            .space 1024, 0

    .end
```

```bash
    # 어셈블리어 컴파일
    $ arm-none-eabi-as -march=armv7-a -mcpu=cortex-a8 -o Entry.o ./Entry.S
    >>>
    ./Entry.S: Assembler messages:
    ./Entry.S: Warning: end of file not at end of a line; newline inserted
    # 경고는 뜨지만 오브젝트 파일 생성됨

    # arm-none-eabi-objcopy 명령을 통하여 바이너리만 뽑아내기
    $ arm-none-eabi-objcopy -O binary Entry.o Entry.bin
    # Entry.bin 파일 생성됨

    # 바이너리 파일 살펴보기
    $ hexdump  Entry.bin 

    0000000 0001 e1a0 0000 0000 0000 0000 0000 0000
    0000010 0000 0000 0000 0000 0000 0000 0000 0000
    *
    0000404

    # or 아래 명령으로도 볼수 있음
    $ xxd Entry.bin 
    >>>
    00000000: 0100 a0e1 0000 0000 0000 0000 0000 0000  ................
    00000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    00000020: 0000 0000 0000 0000 0000 0000 0000 0000  ................
    ....
    00000400: 0000 0000   

```


##### 3.2  실행 파일 만들기

#링커스크립트

```linkerscript
    (/navilos.ld)

    ENTRY(vector_start)
    SECTIONS
    {
        . = 0x00;

        .text :
        {
            *(vector_start)
            *(.text .rodata)
        }
        .data :
        {
            *(.data)
        }
        .bss :
        {
            *(.bss)
        }
    }
```

```bash
    $  arm-none-eabi-ld -n -T ./navilos.ld -nostdlib -o navilos.axf boot/Entry.o
    # navilos.axf 파일 생성

    $ arm-none-eabi-objdump -D navilos.axf 
    >>>
    navilos.axf:     file format elf32-littlearm
    Disassembly of section .text:
    00000000 <vector_start>:
    0:   e1a00001        mov     r0, r1
    00000004 <vector_end>:
            ...
    Disassembly of section .ARM.attributes:

    00000000 <.ARM.attributes>:
    0:    00002441        andeq   r2, r0, r1, asr #8
    4:    61656100        cmnvs   r5, r0, lsl #2
    8:    01006962        tsteq   r0, r2, ror #18
    c:    0000001a        andeq   r0, r0, sl, lsl r0
    10:   726f4305        rsbvc   r4, pc, #335544320      ; 0x14000000
    14:   2d786574        cfldr64cs       mvdx6, [r8, #-464]!     ; 0xfffffe30
    18:   06003841        streq   r3, [r0], -r1, asr #16
    1c:   0841070a        stmdaeq r1, {r1, r3, r8, r9, sl}^
    20:   44020901        strmi   r0, [r2], #-2305        ; 0xfffff6ff
    24:   Address 0x0000000000000024 is out of bounds.


    # qemu 로 navilos.axf  실행시켜보기
    $ qemu-system-arm -M realview-pb-a8 -kernel navilos.axf -S -gdb tcp::1234,ipv4
    >>>
    pulseaudio: set_sink_input_volume() failed
    pulseaudio: Reason: Invalid argument
    pulseaudio: set_sink_input_mute() failed
    pulseaudio: Reason: Invalid argument
    # 여기서 커서가 계속 대기중

    # 실행된 navilos.axf 터미널은 그대로 둔 상태에서 다음 수행

    # gdb 설치
    $ sudo apt install gdb-multiarch

    # navilos.axf와 gdb 연결
    $ gdb-multiarch navilos.axf
    >>>
    ...
    ...
    (gdb) 
    
    # gdb 터미널에서 아래 실행
    (gdb) target remote:1234
    >>>
    Remote debugging using :1234
    0x00000000 in vector_start ()

    (gdb) x/4b 0
    0x0 <vector_start>:     1       0       -96     -31
    # 책이랑 결과가 다른데..?

    # https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=tkdldjs35&logNo=220639025435
    # (gdb) x/x [$register] 이용

    (gdb) x/x 2
    >>>
    0xa0

    # 다시 쳐보니 헥스로 나옴... 뭐지
    (gdb) x/4b 0
    0x0 <vector_start>:     0x01    0x00    0xa0    0xe

```

##### 3.4 make file 만들기

```makefile
    (/Makefile)
    ARCH = armv7-a
    MCPU = cortex-a8

    CC = arm-none-eabi-gcc
    AS = arm-none-eabi-as
    LD = arm-none-eabi-ld
    OC = arm-none-eabi-objcopy

    LINKER_SCRIPT = ./navilos.ld

    ASM_SRCS = $(wildcard boot/*.S)
    ASM_OBJS = $(patsubst boot/%.S, build/%.o, $(ASM_SRCS))

    navilos = build/navilos.axf
    navilos_bin = build/navilos.bin

    .PHONY: all clean run debug gdb

    all: $(navilos)

    clean:
        @rm -fr build

    run: $(navilos)
        qemu-system-arm -M realview-pb-a8 -kernel $(navilos)

    debug: $(navilos)
        qemu-system-arm -M realview-pb-a8 -kernel $(navilos) -S -gdb tcp::1234,ipv4

    gdb:
        gdb-multiarch $(navilos)
	    # arm-none-eabi-gdb

    $(navilos): $(ASM_OBJS) $(LINKER_SCRIPT)
        $(LD) -n -T $(LINKER_SCRIPT) -o $(navilos) $(ASM_OBJS)
        $(OC) -O binary $(navilos) $(navilos_bin)

    build/%.o: boot/%.S
        mkdir -p $(shell dirname $@)
        $(AS) -march=$(ARCH) -mcpu=$(MCPU) -g -o $@ $<
```

```bash

    $ make all
    >>>
    # clean 된 상태에서는 이렇게 로그 뜨면서 빌드 됨
    mkdir -p build
    arm-none-eabi-as -march=armv7-a -mcpu=cortex-a8 -g -o build/Entry.o boot/Entry.S
    boot/Entry.S: Assembler messages:
    boot/Entry.S: Warning: end of file not at end of a line; newline inserted
    arm-none-eabi-ld -n -T ./navilos.ld -o build/navilos.axf  build/Entry.o
    arm-none-eabi-objcopy -O binary build/navilos.axf build/navilos.bin

    # 한번 빌드가 제대로 되었다면 이렇게 로그 뜨면서 빌드가 안됨
    make: Nothing to be done for 'all'.

```