FROM ubuntu:22.04

RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime && echo Asia/Seoul > /etc/timezone

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt install -qq -y tzdata
RUN apt-get install -y sqlite libsqlite-dev

RUN mkdir /db

CMD /bin/bash