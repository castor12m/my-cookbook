# ref : https://www.specialguy.net/148

# [사전 설치]

sudo apt install cmake

# [본문]

sudo apt install libgtest-dev

# - 설치
cd /usr/src/gtest
sudo mkdir build
cd build
sudo cmake ..
sudo make
sudo make install

# ref : https://tech.sangron.com/archives/453
# copy or symlink libgtest.a and libgtest_main.a to your /usr/lib folder
# - install 안되는 경우.
sudo cp *.a /usr/lib

# ref : https://stackoverflow.com/questions/13513905/how-to-set-up-googletest-as-a-shared-library-on-linux
# - 사용법
# Now to compile your programs that uses gtest, you have to link it with:
# -lgtest -lgtest_main -lpthread

# #include <gtest/gtest.h>
# TEST(MathTest, TwoPlusTwoEqualsFour) {
#     EXPECT_EQ(2 + 2, 4);
# }

# int main(int argc, char **argv) {
#     ::testing::InitGoogleTest( &argc, argv );
#     return RUN_ALL_TESTS();
# }