FROM ubuntu:22.04

WORKDIR /app

RUN apt update -y
RUN apt install -qq -y libtool pkg-config build-essential autoconf automake uuid-dev libsocketcan-dev can-utils
RUN apt install -qq -y net-tools iputils-ping iproute2 git openssh-server vim netcat
RUN apt install -qq -y python3 python-is-python3 python3-pip python3-can python3.10-venv


ENTRYPOINT ["tail", "-f", "/dev/null"]
