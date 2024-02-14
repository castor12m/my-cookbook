## goCD

https://github.com/gocd/docker-gocd-server

## 1. 서버

### 1.1. 도커 컨테이너 이용 시작

```bash
    docker run -itd --name [CONTAINER_NAME] -p [HOST_PORT]:8153 gocd/gocd-server:v23.5.0

    ex)
    docker run -d --name gocd -p 8152:8153 gocd/gocd-server:v23.5.0

    docker run -d --name gocd -p 8153:8153 -p 50001:50001 gocd/gocd-server:v23.5.0

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


### 2.1. 관련 설치

https://docs.gocd.org/current/installation/install/agent/linux.html

```bash
    sudo install -m 0755 -d /etc/apt/keyrings
    curl https://download.gocd.org/GOCD-GPG-KEY.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gocd.gpg
    sudo chmod a+r /etc/apt/keyrings/gocd.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gocd.gpg] https://download.gocd.org /" | sudo tee /etc/apt/sources.list.d/gocd.list
    sudo apt-get update
```
위 설치 진행하고 아래 명령어 수행

```bash
    sudo apt-get install go-agent
    >>>
    (...)
    Unpacking go-agent (23.5.0-18179) ...
    Setting up go-agent (23.5.0-18179) ...
    Detected Linux:
    Installing the go-agent daemon with systemd...
    Creating default service file...
    Created symlink /etc/systemd/system/multi-user.target.wants/go-agent.service → /etc/systemd/system/go-agent.service.
    Installation of GoCD Agent completed.
    Now please edit /usr/share/go-agent/wrapper-config/wrapper-properties.conf and set the server to the url address of your GoCD Server (http://example.com:8153/go).
    To ensure full end-to-end transport security between the agent and server
    see https://docs.gocd.org/current/installation/ssl_tls/end_to_end_transport_security.html
    Once that is done start the GoCD Agent with 'systemctl start go-agent'
```
go-agent 실행

잘 되어 있네..


## A. 일단 메모

### 에이전트 수행되는 워크스페이스

/var/lib/go-agent/pipelines/

아래에

파이프 라인 네임으로 생성됨

/var/lib/go-agent/pipelines/pipeline-name-0

이런식으로 생성되고 바로 깃자료들이 가져와져서 설치됨

콘솔로 다른 workspace 진입할려고 했는데 폴더 권한 때문인지 접근 안됫음...

```
    [go] Job Started: 2024-02-14 15:20:54 KST
    [go] Start to prepare pipeline-name-0/2/stage-name-0/1/job-name-0 on naraspace-gs [/var/lib/go-agent]
    [go] Start to build pipeline-name-0/2/stage-name-0/1/job-name-0 on naraspace-gs [/var/lib/go-agent]
    [go] Task: cd /stb/workspacetook: 0.3s
    Error happened while attempting to execute 'cd /stb/workspace'. 
    Please make sure [cd /stb/workspace] can be executed on this agent.

    [Debug Information] Environment variable PATH: /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
    [go] Task status: failed, took: 0.3s
    [go] Current job status: failed
    [go] Start to upload pipeline-name-0/2/stage-name-0/1/job-name-0 on naraspace-gs [/var/lib/go-agent]
    [go] Job completed pipeline-name-0/2/stage-name-0/1/job-name-0 on naraspace-gs [/var/lib/go-agent]
```