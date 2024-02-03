
https://blog.naver.com/roboholic84/221065527428

라즈베리파이 5인치 800x480 HDMI LCD 터치스크린 모니터


## 1. config.txt 하단에 다음 붙여넣기

시작 전 3가지경우가 있을 텐데요.

라즈베리파이가 처음이신 경우 운영체제 설치하기부터 시작하신 후부터,

처음이 아닌 분들은 SD 카드를 뽑아서 컴퓨터에 연결시킨 후부터

따라하시면 되겠습니다.

SD 카드에 들어가서 config.txt 파일을 엽니다.

## 1.1. 5 inch Display

5인치 사용자 분들은

```
    max_usb_current=1
    hdmi_group=2
    hdmi_mode=87
    hdmi_cvt 800 480 60 6 0 0 0
    hdmi_drive=1
```

## 1.2. 7 inch Display

5인치 사용자 분들은

```
    max_usb_current=1
    hdmi_group=2
    hdmi_mode=87
    hdmi_cvt=1024 600 60 6 0 0 0
    hdmi_drive=1
    hdmi_force_hotplug=1
```