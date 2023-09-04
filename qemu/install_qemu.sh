sudo apt update
sudo apt install -y qemu-kvm                # the emulator it self
sudo apt install -y qemu-system-arm
sudo apt install -y libvirt-daemon-system   # runs virtualization in background
sudo apt install -y libvirt-clients
sudo apt install -y bridge-utils            # important networking dependencies >> 설치시 $ brctl show 명령 사용 가능
sudo apt install -y gcc-arm-none-eabi gcc-arm-linux-gnueabi

sudo apt-get install -y gcc-arm-linux-gnueabi
sudo apt-get install -y libsdl2-dev libpixman-1-dev
sudo apt-get install -y virt-manager gdb-multiarch
sudo apt-get install -y flex bison
sudo apt-get install -y libncurses-dev
