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


# 오류 대응

# 1. buildroot-a91에서 make 했는데 다음 에러
# /usr/bin/make -j1 O=/media/psf/vmspace/qemu_ws/target_nstobc/buildroot-at91/output HOSTCC="/usr/bin/gcc" HOSTCXX="/usr/bin/g++" syncconfig
# make[1]: warning: -j1 forced in submake: resetting jobserver mode.
# make[1]: Entering directory '/media/psf/vmspace/qemu_ws/target_nstobc/buildroot-at91'
# make[1]: Leaving directory '/media/psf/vmspace/qemu_ws/target_nstobc/buildroot-at91'
# You seem to have the current working directory in your
# LD_LIBRARY_PATH environment variable. This doesn't work.
# make: *** [support/dependencies/dependencies.mk:27: dependencies] Error 1

# https://github.com/abhiTronix/raspberry-pi-cross-compilers/issues/34
# >>>
# unset LD_LIBRARY_PATH
#