## 1. team blog opensource 후보군

https://www.webfx.com/blog/web-design/open-source-blogging-platforms-for-developers/

```bash
    # 흠..
    https://github.com/getpelican/pelican/

    https://github.com/jsantell/poet?tab=readme-ov-file

    https://github.com/jekyll/jekyll

    # 편리하게 서비스되는데 정적페이지 서비스
    # 레포지토리 readme 따라서 실행하면 바로됨
    https://github.com/hexojs/hexo

    #
    https://github.com/BookStackApp/BookStack.git
```

## 2. 후보군 실행기

### 2.1. BookStack
    
https://www.bookstackapp.com/docs/admin/installation/

```
    (도커 실행 방법 사용)
    $ git clone https://github.com/BookStackApp/BookStack.git
    $ cd BookStack
    $ docker-compose up -d --build
    >>>
    ! mailhog The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested   
    --> macOS 안되는듯..
    --> amd64 아키텍쳐 전용인듯
```

### 2.2. docker-bookstack

https://github.com/linuxserver/docker-bookstack?tab=readme-ov-file

```bash
    $ mkdir linuxserver-bookstack
    $ cd linuxserver-bookstack
    $ vi docker-compose.yml
```

docker-compose.yml 생성 후, 아래 내용 기입    

```yaml
version: "2"
services:
  bookstack:
    image: lscr.io/linuxserver/bookstack
    container_name: bookstack
    environment:
      - PUID=1000
      - PGID=1000
      - APP_URL=http://localhost:10001
      - DB_HOST=bookstack_db
      - DB_PORT=3306
      - DB_USER=bookstack
      - DB_PASS=<yourdbpass>
      - DB_DATABASE=bookstackapp
    volumes:
      - ./bookstack_app_data:/config
    ports:
      - 10001:80
    restart: unless-stopped
    depends_on:
      - bookstack_db
  bookstack_db:
    image: lscr.io/linuxserver/mariadb
    container_name: bookstack_db
    environment:
      - PUID=1000
      - PGID=1000
      - MYSQL_ROOT_PASSWORD=<yourdbpass>
      - TZ=Europe/London
      - MYSQL_DATABASE=bookstackapp
      - MYSQL_USER=bookstack
      - MYSQL_PASSWORD=<yourdbpass>
    volumes:
      - ./bookstack_db_data:/config
    restart: unless-stopped
```

```
    $ docker-compose up -d
```

로그인 정보

id : admin@admin.com
pw : password

guest@example.com

### 2.3. Ubuntu 타깃 한방 설치 및 실행

https://github.com/BookStackApp/devops/blob/main/scripts/installation-ubuntu-22.04.sh

aws에 해당 스크립트로 설치

asw에서 80 이랑 443 포트 열어놓음