### [The Prerequisites]

git clone -b xilinx-v2020.1 https://github.com/Xilinx/qemu.git

# sudo apt-get build-dep qemu
# >>>
# Reading package lists... Done
# E: You must put some 'deb-src' URIs in your sources.list

cd qemu
mkdir build
cd build
../configure --target-list="aarch64-softmmu,microblazeel-softmmu,arm-softmmu" --enable-debug --enable-fdt --enable-sdl
make -j`nproc`

# export PATH=<your-path>/qemu/build/aarch64-softmmu/:$PATH
export PATH=`pwd`/aarch64-softmmu/:$PATH
