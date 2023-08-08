FROM ubuntu:22.04 AS base

WORKDIR /src

RUN apt update
RUN apt install -qq -y net-tools iputils-ping

VOLUME /temp_data

FROM base AS final

WORKDIR /home

#RUN ls -al /data_temp >> result.txt

#ENTRYPOINT ["./data_mediator", "--redis=tcp://foobared@redis:6379", "--option=0"]

#ENTRYPOINT [ "/bin/bash", "-c" ]