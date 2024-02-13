## goCD

https://github.com/gocd/docker-gocd-server

## 1. 서버

### 1.1. 도커 컨테이너 이용 시작

```bash
    docker run -itd --name [CONTAINER_NAME] -p [HOST_PORT]:8153 gocd/gocd-server:v23.5.0

    ex)
    docker run -d --name gocd -p 8152:8153 gocd/gocd-server:v23.5.0

    docker run -d --name gocd -p 8152:8153 -p 50001:50001 gocd/gocd-server:v23.5.0

    docker run -d --name gocd -p 8152:8153 gocd/gocd-server:latest << 안됨..

```

*the requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested*

아래 링크를 통해 macOS도 설치 할 수 있을듯? 시도는 안함

https://velog.io/@dipokalhhj/GoCD-Pipeline-%EA%B5%AC%EC%B6%95

https://docs.gocd.org/current/installation/install/server/osx.html


### 1.2. git 설정

비공개 저장소 사용하려면 id 및 password 필요한듯... 토큰 안되는듯

아.. 프롬프트에서 gh 설치해서 되려나?

아니면 git 주소에 id:토큰 넣으면 될듯?

## 2. 에이전트