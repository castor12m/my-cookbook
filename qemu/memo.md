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
