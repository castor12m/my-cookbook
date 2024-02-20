## jenkins

https://5equal0.tistory.com/entry/Container-Jenkins-1-Docker-Container%EB%A1%9C-Jenkins-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0

## 1. 서버

### 1.1. 도커 컨테이너 이용 시작

```bash
    docker run -itd --name [CONTAINER_NAME] -p [HOST_PORT]:8080 jenkins/jenkins:lts

    ex)
    docker run -itd --name jenkins -p 8151:8080 jenkins/jenkins:lts

    docker run -itd --name jenkins -p 8151:8080 -p 50000:50000 jenkins/jenkins:lts

```

*lts 버전 말고 latest 버전하면 오작동이 많을 수 있음. lts 권장*

### 1.2. 초기 비밀번호 확인

아래 파일을 통해 초기 비밀번호 확인

/var/jenkins_home/secrets/initialAdminPassword 

or

해당 서비스 로그를 통해 확인

```
    (...)
    *************************************************************
    *************************************************************
    *************************************************************

    Jenkins initial setup is required. An admin user has been created and a password generated.
    Please use the following password to proceed to installation:

    404e02cd18c9************************

    This may also be found at: /var/jenkins_home/secrets/initialAdminPassword

    *************************************************************

    (...)
```

### 1.3. Getting Started 선택

Install suggested plugins : 기본적으로 필요한 플러그인들이 설치 됨.

Select plugins to install : 사용자가 원하는 플러그인 만 설치 가능.

## 2. 에이전트


### 2.1. Java 설치

https://www.jenkins.io/blog/2022/12/27/run-jenkins-agent-as-a-service/

Currently, openjdk 11 is recommended, and openjdk 17 is supported. Let’s go with openjdk 17:

java 17 추천 한다고함..

```bash
    sudo apt-get update
    sudo apt install -y --no-install-recommends openjdk-17-jdk-headless
```


### 2.2. Agent 추가

jekins 의 노드를 추가하여 제시되는 커맨드 라인을 agent PC의 입력한 root directory 에서 실행한다.

#### 2.2.1 에러

다음과 같이 포트 not reachable 인 경우

```bash
    INFO: Could not locate server among [http://naraspace-gs.local:8151/]; waiting 10 seconds before retry
    java.io.IOException: http://naraspace-gs.local:8151/ provided port:43649 is not reachable on host naraspace-gs.local
            at org.jenkinsci.remoting.engine.JnlpAgentEndpointResolver.resolve(JnlpAgentEndpointResolver.java:304)
            at hudson.remoting.Engine.innerRun(Engine.java:761)
            at hudson.remoting.Engine.run(Engine.java:543)
```

도커로 실행 시킨 경우 해당 포트도 함께 포워딩에 추가하여 컨테이너를 다시 실행 해준다.

### 2.3. Jenkins 유저 생성...

https://lahuman.jabsiri.co.kr/341

```bash
    # root 권한에서 진행
    # jenkins 계정 생성
    $ adduser jenkins
    >>>
    Adding user `jenkins' ...
    Adding new group `jenkins' (1001) ...
    Adding new user `jenkins' (1001) with group `jenkins' ...
    Creating home directory `/home/jenkins' ...
    Copying files from `/etc/skel' ...
    New password: 
    BAD PASSWORD: The password is shorter than 8 characters
    Retype new password: 
    passwd: password updated successfully
    Changing the user information for jenkins
    Enter the new value, or press ENTER for the default
            Full Name []: 
            Room Number []: 
            Work Phone []: 
            Home Phone []: 
            Other []: 
    Is the information correct? [Y/n] y

    >> 비번 넣어야되나? 몰라서 일단 password jenkins 로 설정
    >> 혹시 실수 해서 삭제 하고 싶은 경우
    $ sudo userdel -r jenkins

    # jenkins 사용자로 전환
    $ su - jenkins
    # HOME 디렉토리에서 다음을 진행합니다.
    # .ssh 디렉토리 생성 & 접근 권한 설정
    $ mkdir .ssh
    $ chmod 700 .ssh

    # 키 관리 파일 생성
    $ touch .ssh/authorized_keys
    $ chmod 600 .ssh/authorized_keys

    # 키생성 - 비밀번호는 입력하지 않아도 됩니다.
    $ ssh-keygen

    # .ssh 에 id_rsa.pub 파일 내의 값을 authorized_keys에 저장합니다.
    $ cat .ssh/id_rsa.pub >> .ssh/authorized_keys

    # id_rsa 파일을 값을 복사 합니다. 그리고 접속하려는 PC에서 다음과 같이 접속하여 사용합니다.
    # ssh -i 파일명 아이디@서버주소
    $ ssh -i id_rsa jenkins@10.0.0.1

```

### 2.4. Agent as a service

```bash
    sudo mkdir -p /usr/local/jenkins-service
    sudo chown jenkins /usr/local/jenkins-service

    # agent.jar  다운받았던 폴더에서 진행
    sudo mv agent.jar /usr/local/jenkins-service

    # Agent 시작 스크립트 생성
    sudo vi /usr/local/jenkins-service/start-agent.sh
    >>>
    아래와 같이 작성
    jnlpUrl 옵션에 대한 인자와 -workDir 옵션에 대한 인자는 본인의 agent 설정에 맞게 수정!
    ================================================================
    #!/bin/bash
    cd /usr/local/jenkins-service
    # Just in case we would have upgraded the controller, we need to make sure that the agent is using the latest version of the agent.jar
    curl -sO http://my_ip:8080/jnlpJars/agent.jar
    java -jar agent.jar -jnlpUrl http://my_ip:8080/computer/My%20New%20Ubuntu%2022%2E04%20Node%20with%20Java%20and%20Docker%20installed/jenkins-agent.jnlp -secret my_secret -workDir "/home/jenkins"
    exit 0
    ================================================================

    sudo chmod +x /usr/local/jenkins-service/start-agent.sh
```

```bash
    # 서비스 관련 설정 파일 생성
    sudo vi /etc/systemd/system/jenkins-agent.service

    WorkingDirectory 및 User는 본인의 상황에 맞게 수정
    ================================================================
    [Unit]
    Description=Jenkins Agent

    [Service]
    User=jenkins
    WorkingDirectory=/home/jenkins
    ExecStart=/bin/bash /usr/local/jenkins-service/start-agent.sh
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ================================================================
```

```bash
    # 서비스 실행...
    sudo systemctl enable jenkins-agent.service
    >>>
    Created symlink /etc/systemd/system/multi-user.target.wants/jenkins-agent.service → /etc/systemd/system/jenkins-agent.service.

```

실패!!

```bash
    # Let’s have a look at the system logs before starting the daemon:
    journalctl -f &

    >>>
    COMMAND=/usr/bin/systemctl enable jenkins-agent.service
    2월 13 21:50:11 naraspace-gs polkitd(authority=local)[967]: Registered Authentication Agent for unix-process:3489620:69138961 (system bus name :1.583 [/usr/bin/pkttyagent --notify-fd 5 --fallback], object path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-8)
    2월 13 21:50:16 naraspace-gs polkit-agent-helper-1[3489631]: pam_unix(polkit-1:auth): authentication failure; logname= uid=1001 euid=0 tty= ruser=nst rhost=  user=nst
    2월 13 21:50:18 naraspace-gs polkitd(authority=local)[967]: Operator of unix-process:3489620:69138961 FAILED to authenticate to gain authorization for action org.freedesktop.systemd1.manage-unit-files for system-bus-name::1.584 [systemctl enable jenkins-agent.service] (owned by unix-user:jenkins)
    2월 13 21:50:18 naraspace-gs polkitd(authority=local)[967]: Unregistered Authentication Agent for unix-process:3489620:69138961 (system bus name :1.583, object path /org/freedesktop/PolicyKit1/AuthenticationAgent, locale en_US.UTF-8) (disconnected from bus)
```

성공은 안됏지만 성공한다면 다음과 링크와 같이 로그 뜸

https://www.jenkins.io/blog/2022/12/27/run-jenkins-agent-as-a-service/


```bash
    $ sudo passwd root
    >>>
    루트 유저 비밀번호 없다면 설정

    $ su

    $ echo 'jenkins ALL=(ALL) ALL' >> /etc/sudoers

    $ su - jenkins


```

!!!!!!! 아니 xxxxxxxxx systemctl start 로 하니까 되네... 아놔..

```bash
    nst@naraspace-gs:/stb/workspace$ systemctl start jenkins-agent
    ==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ===
    Authentication is required to start 'jenkins-agent.service'.
    Authenticating as: nst,,, (nst)
    Password: 
    ==== AUTHENTICATION COMPLETE ===

    nst@naraspace-gs:/stb/workspace$ systemctl status jenkins-agent
    ● jenkins-agent.service - Jenkins Agent
        Loaded: loaded (/etc/systemd/system/jenkins-agent.service; enabled; vendor preset: enabled)
        Active: active (running) since Wed 2024-02-14 15:26:55 KST; 5s ago
    Main PID: 4149896 (bash)
        Tasks: 43 (limit: 38093)
        Memory: 101.9M
            CPU: 1.169s
        CGroup: /system.slice/jenkins-agent.service
                ├─4149896 /bin/bash /usr/local/jenkins-service/start-agent.sh
                └─4149903 java -jar agent.jar -jnlpUrl http://naraspace-gs.local:8151/computer/testpc%2D25/jenkins-agent.>

    2월 14 15:26:55 naraspace-gs bash[4149903]: Feb 14, 2024 3:26:55 PM hudson.remoting.jnlp.Main$CuiListener status
    2월 14 15:26:55 naraspace-gs bash[4149903]: INFO: Connecting to naraspace-gs.local:50000
    2월 14 15:26:55 naraspace-gs bash[4149903]: Feb 14, 2024 3:26:55 PM hudson.remoting.jnlp.Main$CuiListener status
    2월 14 15:26:55 naraspace-gs bash[4149903]: INFO: Trying protocol: JNLP4-connect
    2월 14 15:26:55 naraspace-gs bash[4149903]: Feb 14, 2024 3:26:55 PM org.jenkinsci.remoting.protocol.impl.BIONetworkLa>
    2월 14 15:26:55 naraspace-gs bash[4149903]: INFO: Waiting for ProtocolStack to start.
    2월 14 15:26:55 naraspace-gs bash[4149903]: Feb 14, 2024 3:26:55 PM hudson.remoting.jnlp.Main$CuiListener status
    2월 14 15:26:55 naraspace-gs bash[4149903]: INFO: Remote identity confirmed: ed:7a:2a:ed:cc:47:92:5b:85:4d:3c:ae:7a:b>
    2월 14 15:26:55 naraspace-gs bash[4149903]: Feb 14, 2024 3:26:55 PM hudson.remoting.jnlp.Main$CuiListener status
    2월 14 15:26:55 naraspace-gs bash[4149903]: INFO: Connected
```


## A. 일단 메모


### 젠킨스 토큰 관련

https://seosh817.tistory.com/299


### agent 자동 실행 설정 관련

https://2mukee.tistory.com/325

```
    Agent Node 자동실행 설정

    vi ~~~/jenkins-agent.sh
    java -jar agent.jar -jnlpUrl http://~~~~ -secret @secret-file -workDir "~~~"

    chmod 700 ~~~/jenkins-agent.sh
    vi /usr/lib/systemd/system/jenkins-agent.service
    [Unit]
    Description=jenkins agent
    After=syslog.target network.target

    [Service]
    Type=simple
    User=root
    Group=root
    ExecStart=~~~/jenkins-agent.sh -d
    WorkingDirectory=~~~

    [Install]
    WantedBy=multi-user.target

    systemctl daemon-reload
    systemctl enable jenkins-agent
    systemctl start jenkins-agent
```


### agent 공개키 방식 접속 롼련

https://seosh817.tistory.com/370


## B. 젠킨스 파이프라인

https://bob-full.tistory.com/10

### Declarative

```
    pipeline {
        agent none
        stages{
            stage('Parallel Test') {
                parallel { 
                    stage('Build-test-1') {
                        steps{ build 'Build-test-1' }
                    }
                    stage('Build-test-2') {
                        steps{ build 'Build-test-2' }
                    }
                    stage('Build-test-3') {
                        steps{ build 'Build-test-3' }
                    }
                }
            }
            stage('Build-test-4') {
                steps{
                    build 'Build-test-4'
                }
            }
        }
    }
```

### Scripted

```
    node {
    stage('Parallel-test') {
        parallel 'Build-test-1' : {
            build job : 'Build-test-1'
        } , 'Build-test-2' : {
            build job : 'Build-test-2'
        } , 'Build-test-3' : {
            build job : 'Build-test-3'
        }
    }
    stage('Build-test-4') {
        build job : 'Build-test-4'
    }
    }
```

### Declarative + Scripted Mix

```
    node {
    stage('Parallel-test') {
        parallel 'Build-test-1' : {
            build job : 'Build-test-1'
        } , 'Build-test-2' : {
            build job : 'Build-test-2'
        } , 'Build-test-3' : {
            build job : 'Build-test-3'
        }
    }
    }
    pipeline {
        agent none 
        stages {
            stage('Build-test-4') {
                steps {
                    build 'Build-test-4'
                }
            }
        }
    }
```


## C. 플러그인 추천

https://creampuffy.tistory.com/202

```bash
    # 멀티브랜치 아이템이 깃헙 webhook을 받아 동작할 수 있게 해주는 도구
    multibranch-scan-webhook-trigger

    # 파이프라인 시각화 도구
    blueocean

    # 빌드 결과 슬랙 알림 도구
    slack

```