ref <br/>
: https://it-svr.com/docker-web-gui-portainer/ <br/>
: https://velog.io/@jaryeonge/Docker-Mac%EC%97%90-Homebrew%EB%A1%9C-docker-%EC%84%A4%EC%B9%98 <br/>

### 1. Install Docker

몇가지 방법 중에 선택

### 1.1 도커설치하기 - 스크립트 다운로드 및 실행하기

```bash
    $ curl -fsSL https://get.docker.com -o get-docker.sh
    $ sudo sh get-docker.sh
```

### 1.2 도커설치하기 - bomebrew 를 통한 설치

cask 옵션을 주게 되면 Docker Desktop on Mac을 설치하게 되고 docker-compose, docker-machine을 같이 설치해주어 한결 편하게 사용할 수 있다.

```bash
    $ brew install --cask docker
```

### 1.3 도커설치하기 - ubuntu + wsl

https://docs.docker.com/engine/install/ubuntu/

```bash
    #$ sudo apt-get update
    # $ sudo apt-get -y install ca-certificates curl gnupg
    # $ sudo install -m 0755 -d /etc/apt/keyrings
    # $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    # $ sudo chmod a+r /etc/apt/keyrings/docker.gpg
    
    # $ echo   "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    #   "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # $ sudo apt-get update
    # $ sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    # $ sudo apt-get -y install docker-compose
    # $ sudo chmod 666 /var/run/docker.sock

    #(wsl 에서 설치)
    #https://hahahoho5915.tistory.com/48

    #필요 패키지 설치
    sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
    sudo apt-get update
    
    #docker 공식 GPG 키
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
    
    #docker stable repo 사용
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    
    #docker 설치
    sudo apt install docker-ce docker-ce-cli containerd.io
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    (check)
    $ docker run -it ubuntu bash
```
### 1.4 도커설치하기 - wsl2에서 도커 데스크탑 없이 설치 관련

https://netmarble.engineering/docker-on-wsl2-without-docker-desktop/

### 1.5 도커설치하기 - ubuntu22.04 (2024.01.10시도)

https://docs.docker.com/engine/install/ubuntu/

```bash
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### 1.6 도커설치하기 - Debian GNU/Linux 12 (bookworm)  (2024.11.15)

https://blog.storyg.co/docker/%EB%8D%B0%EB%B9%84%EC%95%88(debian)%EC%97%90-%EB%8F%84%EC%BB%A4(docker)-%EC%84%A4%EC%B9%98-%ED%95%98%EA%B8%B0

```bash
    apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    apt-get update

    apt-get install docker-ce -y
```

---

### 2. Install Check

### 2.1 Check version of Docker

```bash
    $ docker --version
    >>
    Docker version 20.10.24, build 297e128

    $ docker-compose --version
    >>
    Docker Compose version v2.17.2

```

### 2.2 Check services status of Docker

ref : https://stackoverflow.com/questions/36594650/command-to-get-the-service-status-of-macos 

(in macOS)

```bash
    $ sudo launchctl list | grep docker
    >>>
    -       0       com.docker.socket
    3290    0       com.docker.vmnetd
```

---

### 3. Install Portainer 

Portainer는 도커 및 쿠버네티스를 관리하기위한 GUI 이미지입니다.
CE (Community Edition) 으로 설치. 

### 3.1 Portainer 컨테이너 생성

? 도커 컨테이너 생성명령어는 아래와같습니다. 여기서 8000 포트는 에이전트 관리용, 9443은 웹 접근용입니다. <br/>
? 기본적으로 디폴트가 https 설정이기때문에 자체 인증서가 바로 발급되나 사용하고계신 인증서가있으시면 관리탭에서 넣어주시면됩니다.

1) 볼륨 매칭용 데이터 저장 디렉터리 

```bash
    $ mkdir -p ~/data/portainer

    $ docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v ~/data/portainer:/data portainer/portainer-ce:latest
```

or

2) Docker 볼륨 생성

```bash
    $ docker volume create portainer_data

    $ docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

```

### 3.2 Portainer Check

```bash
    $ docker ps
    >>
    CONTAINER ID   IMAGE                           COMMAND        CREATED          STATUS          PORTS                                                      NAMES
    71587d4d7a52   portainer/portainer-ce:latest   "/portainer"   17 seconds ago   Up 16 seconds   0.0.0.0:8000->8000/tcp, 0.0.0.0:9443->9443/tcp, 9000/tcp   portainer
```

https://[IP]:9443

http 는 안됨, https 여야함 확인 필수

### 4. 관리자 계정 생성 (기록용)

ID : admin <br/>
PS : Naraspace!23


### 5. Docker Image 확인

```bash
    $ docker images
    or
    $ docker image ls
```


### 5. Docker Container Tar 형태로 저장

```bash
    (ref : https://www.leafcats.com/240)

    # 1. docker save (docker image -> tar)
    #  docker 이미지를 tar파일로 저장하기 위해서는 docker save 커맨드를 사용한다.
    #  docker save [옵션] <파일명> [이미지명]
    #  저장할 파일명을 지정하는 옵션은 -o 를 사용한다.
    $ docker save -o nginx.tar nginx:latest

    # 2. docker load (tar -> docker image)
    #  tar파일로 만들어진 이미지를 다시 docker image로 되돌리기 위해서는 docker load 커맨드를 사용한다.
    #  docker load -i tar파일명

    # 3. docker export (docker container -> tar)
    #  docker는 이미지 뿐 아니라 container를 tar파일로 저장하는 명령어를 제공한다.ß
    #  docker export <컨테이너명 or 컨테이너ID> > xxx.tar

    # 4. docker import (tar -> docker image)
    #  export 커맨드를 통해 만들어진 tar 파일을 다시 docker image로 생성하는 명령어이다.
    #  docker import <파일 or URL> - [image name[:tag name]]
    #  ※ root 권한으로 실행하지 않을 경우, 액세스 권한이 없는 파일들이 포함되지 않는 문제가 발생할 수 있다.

    # (중요) export - import 와 save - load의 차이
    # docker export의 경우 컨테이너를 동작하는데 필요한 모든 파일이 압충된다. 즉, tar파일에 컨테이너의 루트 파일시스템 전체가 들어있는 것이다. 반면에 docker save는 레이어 구조까지 포함한 형태로 압축이 된다.
    # 즉, 기반이 되는 이미지가 같더라도 export와 save는 압축되는 파일 구조와 디렉터리가 다르다.
    # 결론은 export를 통해 생성한 tar 파일은 import로, save로 생성한 파일은 load로 이미지화 해야 한다.
```

```bash
    $ docker images
    >>>
    REPOSITORY               TAG       IMAGE ID       CREATED       SIZE
    portainer/portainer-ce   latest    910800a96b4a   8 days ago    265MB
    ubuntu                   jammy     bab8ce5c00ca   7 weeks ago   69.2MB

    $ docker container ls
    >>> 
    CONTAINER ID   IMAGE                           COMMAND        CREATED        STATUS        PORTS                                                      NAMES
    babecb126072   ubuntu:jammy                    "/bin/bash"    2 hours ago    Up 2 hours                                                               ubuntu_test
    71587d4d7a52   portainer/portainer-ce:latest   "/portainer"   25 hours ago   Up 25 hours   0.0.0.0:8000->8000/tcp, 0.0.0.0:9443->9443/tcp, 9000/tcp   portainer

    (ref : https://tech.cloudmt.co.kr/2022/06/29/%EB%8F%84%EC%BB%A4%EC%99%80-%EC%BB%A8%ED%85%8C%EC%9D%B4%EB%84%88%EC%9D%98-%EC%9D%B4%ED%95%B4-3-3-docker-image-dockerfile-docker-compose/)
    (컨테이너 tar 형태로 아카이브 파일로 생성)
    $ docker container export babecb126072 > fsw_container_220426.tar

    (압축 파일 확인 )
    $ tar -tvf fsw_container_220426.tar | head -10
    >>> 컨테이너에 루트파일을 토대로 폴더 구조가 보임.

    (tar 파일 이미지화 방법1.)
    $ cat fsw_container_220426.tar| docker import - test
    or
    (tar 파일 이미지화 방법2.)
    $ docker import fsw_container_220426.tar > test
    $ docker images
    >>>
    REPOSITORY               TAG       IMAGE ID       CREATED         SIZE
    <none>                   <none>    0322a8abb16b   4 seconds ago   949MB
    portainer/portainer-ce   latest    910800a96b4a   8 days ago      265MB
    ubuntu                   jammy     bab8ce5c00ca   7 weeks ago     69.2MB
    $ docker tag 0322a8abb16b test 
    or
    (tar 파일 이미지화 방법3.)
    ----$ docker image import fsw_container_220426.tar | - test
    ---- x 방법2랑 결과 같음

    (docker image 삭제)
    $ docker rmi 0322a8abb16b
```

### 6. Docker SSH 접속.

ref : https://whitehairhan.tistory.com/77

해당 컨테이너에서 다음 설정

```
    $ vim /etc/ssh/sshd_config

    (수정전)
    ...
    prohibit-password
    ...

    (수정후)
    ...
    PermitRootLogin yes # prohibit-password
    ...

    $ service ssh start
```
/.ssh/config 설정시 다음과 같이 포트를 설정한다면

```
    Host docker_ssh
    HostName localhost
    User root
    Port 8022
```

```
    (아!, 그리고 아래와 같이 컨테이너를 실행해야 외부 8022 포트가 해당 컨테이너 포트 22와 연결됨.)

    $ docker run --it  .... -p 8022:22 ...
```

### 6.1 client 에서 rsa 생성 후, private key 복사

```
    $ ssh-keygen -t rsa -f uitos_fsw_rsa -N ''
    $ cp uitos_fsw_rsa ~/.ssh
```

### 6.2 client ssh config 에 private key 등록

```
    (~/.ssh/config)

    (linux 계열 host pc)
    Host docker_8024
      HostName 0.0.0.0
      Port 8024
      User root
      IdentityFile /Users/castor/.ssh/uitos_fsw_rsa  << 추가

    (window host pc)
    Host docker_8024
      HostName localhost
      Port 8024
      User root
      IdentityFile C:\Userscastor.ssh\uitos_fsw_rsa  << 추가

```

### 6.3 컨테이너 재생성시 known_host 에 기록된 핑거프린트 삭제

```
    // sed 관련 테스트
    (https://sed.js.org/)
    $ sed -i '' '/^\[0.0.0.0\]:8024/d' ~/.ssh/known_hosts
```


### 6.4 터미널로 ssh 접속하려는 경우 rsa key를 같이 하는 방법

```
    (https://serverpilot.io/docs/how-to-use-ssh-public-key-authentication/)
    $ ssh -i ~/.ssh/uitos_fsw_rsa root@0.0.0.0 -p 8024
```

### 6.5 git credentials

```bash
    git setting
    (https://stackoverflow.com/questions/68905174/recursively-clone-submodules-from-github-using-an-access-token)

    RUN git config --system credential.helper store
    RUN echo "https://{git_id}:{git_token}@github.com"
    # ex) https://castor103:****************************@github.com
    
    (직접 입력 대신 파일로 하도록 수정)
    RUN cat /home/share/pubkey/git_user_credential.txt > ~/.git-credentials

```

### 6.6 dockerfile ssh settings

```dockerfile
    # ssh setting
    COPY ./share /home/share/pubkey
    RUN mkdir /var/run/sshd
    RUN mkdir /root/.ssh
    RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
    RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
    RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
    RUN cat /home/share/pubkey/*.pub >> ~/.ssh/authorized_keys
    #RUN echo 'root:1234' | chpasswd
```

### 7. 실행중인 컨테이너에 포트 바인딩 혹은 볼륨 추가

ref <br/>
: https://medium.com/sjk5766/%EC%8B%A4%ED%96%89%EC%A4%91%EC%9D%B8-container%EC%97%90-port-or-volume-%EC%B6%94%EA%B0%80-ae8889344c68 <br/>
: https://velog.io/@nohsangwoo/docker-container-%EC%B6%94%EA%B0%80-%ED%8F%AC%ED%8A%B8-%EC%98%A4%ED%94%88


실행중인 컨테이너에 실시간으로 포트를 추가하는 기능은 없다
컨테이너의 변경 사항이 없다면 컨테이너를 stop 후
docker run에 -p 옵션을 추가하여 실행
컨테이너의 변경 사항이 있다면 docker commit를 사용해서 변경된 내용이 적용된 컨테이너를 만들어서 -p 옵션으로 재실행한다. 

```bash
    $ docker stop container_name
    $ docker commit container_name new_container_name
    $ docker run -p new_port1:new_port2 new_container_name

    # (이런식으로 프로토콜 지정도 가능)
    $ .... -p 8088:8088/tcp ... 
```

### 8 Docker Volumes

ref : https://blog.naver.com/PostView.naver?blogId=oxcow119&logNo=222412860960&categoryNo=0&parentCategoryNo=0

```bash
    # 1. docker volume create
    $ docker voluem create [volume_name]

    # 2. docker volume list check
    $ docker volume list

    # 3. docker volume list check detail
    $ docker volume inspect [volume_name]

    # 4. docker volume mount (mount option 을 통한 볼륨 마운트)
    $ docker run --mount source=[volume_name],destination=[path_in_container] [docker_image]
    # ex)
    $ docker run -it --name=volume1 --mount source=data,destination=/data ubuntu

    # 5. docker volume remove
    $ docker volume rm [volume_name]

```


### 8.1 bind, volume, tmpf 

```bash
    #bind :
    #bind 마운트를 사용하면 호스트 시스템의 선언된 디렉터리가 컨테이너에 마운트 됩니다.
    #디렉터리 경로를 본인의 환경에 맞게 사용하는 장점이 있으나, 디렉터리 경로가 분산되어 관리가 어려워질 수도 있습니다.
    -v <호스트의 디렉터리 경로>:<컨테이너에서 마운트되는 경로>[:rw|ro]
    
    #volume :
    #Docker에서 관리하는 호스트 파일 시스템의 일부(Linux의 경우 /var/lib/docker/volumes/)에 저장됩니다.
    #Docker에서 데이터를 유지하는 가장 좋은 방법입니다. (라고 도커 공식문서에 기재되어 있습ㄴ)
    -v <볼륨 이름>:<컨테이너에서 마운트되는 경로>[:rw|ro]

    #tmpfs :
    #호스트 시스템의 메모리에 저장됩니다.
    #보안 혹은 비영구 상태 데이터를 작성해야 하는 이유로 데이터를 유지하지 않으려는 경우에 가장 잘 사용됩니다.
    --tmpfs <컨테이너에서 마운트되는 경로>

    #읽기와 쓰기 권한(rw) 또는 읽기 전용 권한(ro)을 부여할 수 있습니다.
```

---

### 9. 몇가지 기능들

### 9.1 실행중인 컨테이너 자원 할당 정보 확인

ref : https://cumulus.tistory.com/35

```bash
    $ docker stats
    >>> 
    CONTAINER ID   NAME          CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O     PIDS
    380ee721f8d8   ubuntu_fsw    0.00%     920KiB / 7.667GiB     0.01%     27.3kB / 280B     0B / 0B       1
    babecb126072   ubuntu_test   0.00%     211.5MiB / 7.667GiB   2.69%     253MB / 2.03MB    0B / 1.52GB   3
    71587d4d7a52   portainer     0.00%     15.33MiB / 7.667GiB   0.20%     8.77MB / 33.4MB   23.3MB / 0B   9
```

### 9.2 컨테이너 리소스 할당?

docker가 설치된 'host machine'의 'desktop docker'의 우측 상단의 [ ⚙︎ 설정아이콘] 클릭 -> Resources -> Advanced.

```
    도커
    cpu 최대 12. 메모리 최대 32 GB

    패러렐즈 (기본)
    cpu 최대 4개, 메모리 최대 8 GB

    패러렐즈 (비지니스)
    cpu 최대 32개, 메모리 최대 128 GB

```

### 9.2 공유메모리, cpu

``` bash
    # 공유 메모리
    # 값을 정해주지 않으면 기본값으로 64MB의 shm
    # ex) 8 GB 설정 옵션
    --shm-size=8G
```

### 9.3 도커 실행 환경 기능 확인

```bash
    $ docker system info
    >>>
    Client:
        Context:    default
        Debug Mode: false
        Plugins:
        buildx: Docker Buildx (Docker Inc., v0.10.4)
        compose: Docker Compose (Docker Inc., v2.17.2)
        dev: Docker Dev Environments (Docker Inc., v0.1.0)
        extension: Manages Docker exte
        ...
```

### 9.4 도커 디스크 상태 확인

```bash
    $ docker system df
    >>>
    TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE
    Images          4         3         4.018GB   2.804GB (69%)
    Containers      3         3         899.7MB   0B (0%)
    Local Volumes   0         0         0B        0B
    Build Cache     8         0         1.456kB   1.456kB
```


---

### 10. docker-compose (예비)

ref : https://docs.docker.com/compose/install/

linux의 경우 docker compose를 별도로 설치해줘야 한다.

```
    $ sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    $ sudo chmod +x /usr/local/bin/docker-compose
```

ref : https://siane.tistory.com/338

최신 도커 컴포즈 설치

```bash
    #버전확인
    docker-compose -v
    Docker Compose version [설치된 버전]

    #기존 설치 삭제
    sudo apt remove docker-compose -y

    #jq library 설치
    sudo apt install jq -y

    #최신 버전 설치
    VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
    DESTINATION=/usr/bin/docker-compose
    sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
    sudo chmod 755 $DESTINATION

    #설치 버전 확인
    docker-compose -v
    Docker Compose version [최신버전]

    해당글 확인 버전 (우분투 22.04 기준)

    25 서버에서 설치 확인
```

데비안? 

https://stackoverflow.com/questions/49839028/how-to-upgrade-docker-compose-to-latest-version

curl + grep 이용 설치법

```bash 
    VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')
    DESTINATION=/usr/local/bin/docker-compose
    sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
    sudo chmod 755 $DESTINATION
    ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose
    docker-compose --version
```

#### 10.1 docker-compose 실례

ref : https://engineer-mole.tistory.com/221

동작 확인을 실행할 예제 환경에 대해서 

```
    (Working dir)
    +- docker-compose.yml
    +- app-server/
        +- Dockerfile
        +- src/
            +- app.js
```

```js
    app-sever/src/app.js
    ================================================================
    var redis = require('redis');
    var redis_client = redis.createClient(6379, "noderedis");
    var listen_port = 10080;

    require('http').createServer(function (request, response) {
        redis_client.incr('counter', function(error, reply) {
            response.writeHead(200, {'Content-Type': 'text/plain'});
            response.end("You accessed here " + reply + " times.\n");
        });
    }).listen(listen_port, '0.0.0.0');
    console.log("Server is running on port " + listen_port + ".");
```

```Dockerfile
    app-sever/Dockerfile
    ================================================================
    FROM node:5
    RUN npm -g install redis
    ENV NODE_PATH /usr/local/lib/node_modules

    ENTRYPOINT ["node", "app.js"]
```

```Dockerfile
    docker-compose.yml
    ================================================================
    nodeapp:                    # ? 임의로 네이밍 지정할수 있음? 컨테이너의 이름으로 되는듯
        build: "./app-server"
        container_name: "nodeapp"
        working_dir: "/usr/src/app"
        ports:
         - "10080:10080"
        volumes:
         - "$PWD/app-server/src:/usr/src/app"
        links:                  # ? 정확히 무슨 역할 
         - "noderedis"
    noderedis:
        image: "redis:3"
        container_name: "noderedis"
```

 Dockerfile에 "ENTRYPOINT"를 쓰지 않은 경우에는 docker-compose.yml에 아래와 같이 기재하는 방법으로 대응할 수 있다.

 ```
    nodeapp:
        ......
        command: node app.js
 ```

 모두 작성 후, docker-compose.yml 파일이 있는 디렉토리에서 다음 실행

 ```bash
    $ docker-compose up
 ```


 실행 후 도커 이미지와 컨테이너 상황

 ```
    $ docker images
    REPOSITORY                           TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
    dockercomposeexamplesimple_nodeapp   latest              7d39370b4309        23 hours ago        643.5 MB
    redis                                3                   0c4334bed751        4 days ago          151.3 MB
    node                                 5                   285fd945c0b6        2 weeks ago         642.7 MB
    debian                               jessie              23cb15b0fcec        4 weeks ago         125.1 MB

    $ docker ps -a
    CONTAINER ID        IMAGE                                COMMAND                  CREATED             STATUS              PORTS                                NAMES
    e48a2014b88d        dockercomposeexamplesimple_nodeapp   "node app.js"            4 minutes ago       Up 4 minutes        0.0.0.0:10080->10080/tcp   nodeapp
    b8b47ca9a285        redis:3                              "/entrypoint.sh redis"   23 hours ago        Up 4 minutes        6379/tcp                             noderedis
 ```

docker-compose.yml 의 각 요소에 대한 설명
 ```dockerfile
    nodeapp:                            # <- 서비스명
        image: "tsutomu/nodeapp"          # <- 사용하는Docker이미지명(이후에 빌드한다)
        container_name: "nodeapp"         # <- 컨테이너명. 지정하지 않은 경우에 Docker compose로 임의로 결정된다.
        working_dir: "/usr/src/app"       # <- 컨테이너 내의 워킹 디렉토리. docker run커맨드의 -w/--workdir에 상당한다.
        ports:                            # <- Expose할 포트. docker run커맨드의 -p/--publish에 상응한다.
         - "10080:10080"
        volumes:                          # <- Bind mount하는 디렉토리. volume. docker run커맨드의 -v/--volume에 상당한다.
         - "$PWD/app-server/src:/usr/src/app"
        links:                            # <- 다른 컨테이너와 접속할 때의 컨테이너명. docker run 커맨드의 -link에 해당한다.
         - "noderedis"
    noderedis:
        image: "redis:3"                  # <- 이미지ID와 tag
        container_name: "noderedis"
  
 ```



#### 10.2 docker-compose 관련 커맨드

ref : https://darrengwon.tistory.com/793

 ```bash
    $ docker-compose up
    
    $ docker-compose up -d # background 실행 옵션 -d (detached) 
    
    $ docker-compose down # 실행중인 컨테이너 종료
    
    $ docker-compose up --force-recreate #도커 컨테이너 새로 만들기

    
    # 도커 이미지 빌드 후 compose up
    # -build 플래그 여부의 차이는,
    # --build가 붙으면 캐싱된 이미지를 체크하지 않고 무조건 빌드를 하고 시작하라는 의미입니다.
    $ docker-compose up --build 

    $ docker-compose start # 정지한 컨테이너를 재개
    $ docker-compose start mysql # mysql 컨테이너만 재개

    $ docker-compose restart # 이미 실행 중인 컨테이너 다시 시작
    $ docker-compose restart redis # 이미 실행중인 redis 재시작

    $ docker-compose stop # gracefully stop함.
    $ docker-compose stop wordpress

    $ docker-compose down # stop 뿐만 아니라 컨테이너 삭제까지

    $ docker-compose logs
    $ docker-compose logs -f # 로그 watching

    $ docker-compose ps # 컨테이너 목록

    $ docker-compose exec [컨테이너] [명령어]
    $ docker-compose exec wordpress bash # wordpress에서 bash 명령어 실행

    $ docker-compose build # build 부분에 정의된 대로 빌드
    $ docker-compose build wordpress # wordpess 컨테이너만 빌드

    $ docker-compose run [service] [command] # 이미 docker-compose 가동 중인 것과 별개로 하나 더 올릴 때
    $ docker-compose run nginx bash
 
 ```

#### 10.2 docker-compose 관련 문법

ref : https://darrengwon.tistory.com/793

* environment

여기서, dockerfile의 환경변수와 docker-compose.yml의 환경변수가 중복되어서 올라가면 어떻게 되느냐?는 의문이 생깁니다.

우선순위는 다음과 같습니다. 즉, docker.compose.yml이 덮어쓰게 됩니다.

1. docker-compose [run / exec] -e key:value
2. docker-compose.yml의 environment
3. Dockerfile의 ENV

* link (legacy)

docker cli 사용할 때 --link와 동일하다. {연결할 컨테이너 이름}:{해당 컨테이너에서 참고할 이름}

그러나 기본적으로 docker-compose 내부에선 모든 컨터네이너가 소통할 수 있기 때문에 사용되지 않음.

```dockerfile
    services:
        nginx:
            image: nginx
            ports:
             - 8080:80
            volumes:
             - ./:/usr/share/nginx/html
            link:
             - mysql:db
```