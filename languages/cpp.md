
### int8_t print format

#### 현상

```c++
    int8_t temp = -40;
    printf("temp : %02X\n", temp);

    >>>
    temp : FFFFFFD8
```

#### 이유

https://copyprogramming.com/howto/c-c-printing-bytes-in-hex-getting-weird-hex-values

According to CppReference,  %02x  is compatible with  unsigned int  . When supplying the arguments to  printf()  , which is a variadic function,  buff[i]  is automatically converted to  int  . Subsequently, the format specifier  %02x  enables  printf()  to interpret the value as  int  . Consequently, values like  (char)-1  that may be negative are interpreted and displayed as  (int)-1  , which explains the observed behavior.

#### 방법

1) %hhx 이용법

```c++
    int8_t temp_8 = -40;
    int32_t temp_32 = -40;

    printf("temp_8  %d, %x %02X\n", temp_8, temp_8, temp_8);
    printf("temp_8  %d, %hhx %02hhX\n", temp_8, temp_8, temp_8);

    printf("temp_32 %d, %x %02X\n", temp_32, temp_32, temp_32);
    printf("temp_32 %d, %hhx %02hhX\n", temp_32, temp_32, temp_32);
    
    >>>>
    temp_8  -40, ffffffd8 FFFFFFD8
    temp_8  -40, d8 D8
    
    temp_32 -40, ffffffd8 FFFFFFD8
    temp_32 -40, d8 D8
```

2) (unsigned ...) 로 캐스팅

```c++
    int8_t temp_8 = -40;

    printf("temp_8  %d, %x %02X\n", temp_8, temp_8, temp_8);
    printf("temp_8  %d, %x %02X\n", (uint8_t)temp_8, (uint8_t)temp_8, (uint8_t)temp_8);

    temp_8  -40, ffffffd8 FFFFFFD8
    temp_8  216, d8 D8
```