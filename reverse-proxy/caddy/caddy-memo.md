## 0. ref
- link
    - https://keepworking.tistory.com/26
    ```
    캐디는 서버를 위한 확장 가능한 플랫폼이라 소개를 하는데 우리가 기존에 사용하던 nginx 또는 apache의 또 다른 대안이라 생각 할 수 있습니다.
    특정 디렉토리를 기준으로 http 서버를 열 수 있고 정말 다양한 기능을 제공하는데 저는 기본적으로 리버스 프록시 용도로 사용하고 있습니다.

    제가 서버가 한 3대 정도 가지고 있다고 하고 각 서버마다 하나의 사이트를 가지고 있으면
    제가 외부에서 접속하고자 하면 포트포워딩을 해서 80번 포트는 서버1, 81번 포트는 서버2, 82번 포트는 서버3 에 연결하는 식으로 구성이 가능할 겁니다.
     
    그러면 사용자 입장에서는 내도메인.com, 내도메인.com:81 내도메인.com:82 이런식으로 따로 접속을 해야 하는거지요
    그런데 포트를 여러개 뚫지 않고 하나의 포트로 여러 서버에 다양하게 접속하고 싶을 겁니다. 서버 하나 추가할때마다 포트포워딩을 새로 해주는 건 정말 번거로운 일이구요
     
    여기서 리버스 프록시는 하나의 포트로 들어오는 입력을 나누어 주는 역할을 합니다.
     
    80번 포트 -> 리버스 프록시 -> [서버1,서버2,서버3]
     
    이런 구조로 구성이 되는 거지요
     
    그럼 사용자는 어떤식으로 원하는 서버에 접속 하냐면 서버1.내도메인.com, 서버2.내도메인.com, 서버3.내도메인.com
    이런식으로 arecord 같은걸 설정 할 수 도 있고
    반대로 내도메인.com/서버1 ... 같은 형식으로 url에서 구분이 되게 해서 접속이 가능합니다.

    ```
    - https://cowboysj.tistory.com/69
    ```
    Go로 작성된 오픈소스 웹 서버이다.
    자동으로 tls 인증서를 발급해주는 기능이 있고 리버스 프록시 설정도 가능하다.
    Caddyfile이 nginx.conf 같은 역할을 한다.
    ```
    - https://svrforum.com/svr/1290939
    - https://caddyserver.com/docs/install#debian-ubuntu-raspbian

## 1. memo

### 1.1 EC2 이용

- 1. install caddy on EC2
    - https://caddyserver.com/docs/install#debian-ubuntu-raspbian
    - EC2는 보안그룹에서 443번이 뚫려있어야 한다!

```bash
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
```

- 2. edit 'caddy.service' file
    - sudo vi /etc/systemd/system/caddy.service

```text
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
Type=notify
User=caddy
Group=caddy
ExecStart=/usr/bin/caddy run --environ --config /etc/caddy/Caddyfile
ExecReload=/usr/bin/caddy reload --config /etc/caddy/Caddyfile --force
TimeoutStopSec=5s
LimitNOFILE=1048576
LimitNPROC=512
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
```

- 3. edit 'Caddyfile' file
    - sudo vi /etc/caddy/Caddyfile

```text
{
        admin 0.0.0.0:2020
}

ec2 PUBLIC IP주소.nip.io {
        tls internal
        reverse_proxy localhost:8080
       
}
```

- 4. run Caddy
```bash
sudo systemctl daemon-reload
sudo systemctl enable --now caddy
systemctl status -l caddy
sudo caddy start
```


### 1.2 docker 이용


```bash
docker pull caddy:2-alpine

sudo mkdir /data/caddy
sudo mkdir /data/caddy/data
sudo vi Caddyfile
```

- vi /data/caddy/Caddyfile
```bash
[HOSTNAME] {
  reverse_proxy web:3000 # 프로젝트가 뜨는 port 입력
}
```

- vi docker-compose.yml
```yml
networks:
  proxy:
    driver: overlay

services:
  web:
    image: [IMAGE_NAME]
    ports:
      - target: 3000 # 프로젝트가 실행되었을 때의 port를 입력해주세요.
        published: 3000
        protocol: tcp
        mode: host
    networks:
      - proxy

  caddy:
    hostname: [HOST_NAME] # 배포되었을 때의 host를 입력해주세요.
    image: caddy:2-alpine
    restart: unless-stopped
    ports:
      - target: 443
        published: 443
        protocol: tcp
        mode: host
      - target: 80
        published: 80
        protocol: tcp
        mode: host
    networks:
      - proxy
    volumes:
      - /data/caddy/Caddyfile:/etc/caddy/Caddyfile
      - /data/caddy/data:/data
      - /data/caddy/config:/config
  
```