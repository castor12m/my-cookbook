FROM ubuntu:22.04 AS base

WORKDIR /src

RUN apt update
RUN apt install -qq -y net-tools iputils-ping

VOLUME /temp_data

FROM base AS final

WORKDIR /home
COPY ./test.sh .

CMD [ "/bin/bash", "-c", "./test.sh" ]