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