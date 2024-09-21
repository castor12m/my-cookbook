
# mini-pc

- canable c-to-c 케이블 전후, 추가된 dmesg, lsusb 기록

dmesg
```
    (...)
    [4369582.705694] usb 1-1: new full-speed USB device number 4 using xhci_hcd
    [4369582.879503] usb 1-1: New USB device found, idVendor=1d50, idProduct=606f, bcdDevice= 0.00
    [4369582.879517] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
    [4369582.879523] usb 1-1: Product: canable gs_usb
    [4369582.879528] usb 1-1: Manufacturer: canable.io
    [4369582.879532] usb 1-1: SerialNumber: 0022003B5043570520353339
    [4369582.905358] CAN device driver interface
    [4369582.911110] gs_usb 1-1:1.0: Configuring for 1 interfaces
    [4369582.914401] usbcore: registered new interface driver gs_usb

```

lsusb
```
    (...)
    Bus 001 Device 004: ID 1d50:606f OpenMoko, Inc. Geschwister Schneider CAN adapter
    (...)
```