

## socat 이용 방법

이것도 안됨

```
    brew install socat

    socat -d -d PTY,link=/tmp/ttyCustomUSB0,mode=777 /dev/tty.usbmodem54340398631
```

macOS에서는 안되는듯?
