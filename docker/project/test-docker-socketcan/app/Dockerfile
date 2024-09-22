FROM ubuntu:22.04

WORKDIR /app

# set timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update -qq
RUN apt install -qq -y init systemd tzdata curl
RUN apt install -qq -y libtool pkg-config build-essential libsocketcan-dev can-utils usbutils net-tools 
#iproute2
# RUN apt install -qq -y git openssh-server vim netcat automake autoconf
# RUN apt install -qq -y python3 python-is-python3 python3-pip python3-can python3.10-venv

ENTRYPOINT ["tail", "-f", "/dev/null"]
