
## 0. ref

- GPT 만세


## 1. 기록

- containous/whoami 이미지를 예시로 가이드로 해줘서 따라해봄.
- containous/whoami 사용하게 되면 아래의 url로 응답을 받을수 있다.

- 정보 링크
    - https://hub.docker.com/r/containous/whoami

```bash
    Tiny Go webserver that prints os information and HTTP request to output

    Usage
    Paths
    /data?size=n[&unit=u]: creates a response with a size n. The unit of measure, if specified, accepts the following values: KB, MB, GB, TB (optional, default: bytes).
    /echo: webSocket echo.
    /bench: always return the same response (1).
    /[?wait=d]: returns the whoami information (request and network information). The optional wait query parameter can be provided to tell the server to wait before sending the response. The duration is expected in Go's time.Duration⁠ format (e.g. /?wait=100ms to wait 100 milliseconds).
    /api: returns the whoami information as JSON.
    /health: heath check
    GET, HEAD, ...: returns a response with the status code defined by the POST
    POST: changes the status code of the GET (HEAD, ...) response.
```


### 1.1 Reverse Proxy 사용 않는 경우.

- 다음과 같이 서비스하는 컨테이너를 포트포워딩 시켜야함.

docker-compose.yml
```yml
version: '3'

services:
  whoami:
    image: containous/whoami
    restart: always
    ports:
      - '3000:80'
      - '3030:443'
```

### 1.2 Reverse Proxy 사용하는 경우.

- Rewrite docker-compose.yml file with the following contents.
- Add an nginx.conf file to the same directory.

docker-compose.yml
```yml
version: '3'

services:
  nginx:
    image: nginx:latest
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - whoami

  whoami:
    image: containous/whoami
    restart: always
    # ports:
    #   - '3000:80'
    #   - '3030:443'
```

nginx.conf
```conf
events { }

http {
    upstream whoami {
        server whoami:80;
    }

    server {
        listen 80;
        #server_name localhost;  # 실제 도메인 또는 IP로 수정 가능
        server_name 192.168.2.84;  # 실제 도메인 또는 IP로 수정 가능

        location / {
            proxy_pass http://whoami;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}

```

#### 1.2.1 다음과 같이 웹브라우져로 접속하는 경우 정보가 나옴

- 1) http://192.168.2.84/ 
```txt
Hostname: c667ea210d26
IP: 127.0.0.1
IP: ::1
IP: 172.18.0.2
RemoteAddr: 172.18.0.3:60484
GET / HTTP/1.1
Host: 192.168.2.84
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
Accept-Encoding: gzip, deflate
Accept-Language: ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7
Connection: close
Upgrade-Insecure-Requests: 1
X-Forwarded-For: 192.168.1.12
X-Real-Ip: 192.168.1.12
```

- 2) http://192.168.2.84/bench
```
1
```

- 3) http://192.168.2.84/data?size=6
```
|ABCD|
```


### 1.3 기존 웹서비스가 이미 도커로 실행되어 있는 경우, 추가로 컨테이너를 생성하여 reverse proxy 하려면?!

- 특정 server에 이미 도커로 'web 서비스'가 3000번으로 실행되고 있을때,
- 해당 도커컴포즈 파일 수정없이, 추가적인 리버스프록시를 위한 도커컴포즈 파일 생성으로 리버스프록시 기능을 수행하고싶었음.
- 192.168.0.45 번 ip로 서비스되고 있는 서버가 내부라우터에 test1.local 로 연결되는 상황
- 'web 서비스' 의 컨테이너를 inspect 하여 도커 네트워크 네이밍이 'dummy_default' 라는것을 알았을때 다음과 같이 작성

docker-compose.yml
```yml
version: "3"
services:
  nginx:
    image: nginx
    ports:
      - 80:80
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    restart: always
    networks:
      - dummy_default

networks:
  dummy_default:
    external: true
```

nginx.conf
```conf
events { }

http {
    
    server {
        listen 80;
        server_name test1.local;

        location / {
            proxy_pass http://192.168.0.45:3100;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}
```

### 1.4 https 로 3200 포트로 서비스 되는 앱이 존재 할때, ngix로 http://{host}:3200 요청시 https://{host}:3200 리다이렉트 

- 기존 컴포즈 파일
```yml
services:
  gen-email-signature:
    image: naraspace/gen-email-signature:1.0
    container_name: gen-email-signature
    restart: always
    build:
      context: ./gen-email-signature
    ports:
      - "3200:3200"
    volumes:
      - ./gen-email-signature/public/data.csv:/app/public/data.csv

```

- 도커컴포즈 파일 및 nginx.conf 작성하고 pem 키 다음과 같이 마운트
  - 주의!
    - gen-email-signature 에서 사용하는 pem 키를 복사하여 
    - nginx 에 마운트하는 ./certs 에 사용할것.
    - 결론 : gen-email-signature와 nginx 에서 연결되는 pem 키가 동일하지 않으면 동작 안됨!

- nginx 추가한 컴포즈 파일
```yml
services:
  gen-email-signature:
    image: naraspace/gen-email-signature:1.0
    container_name: gen-email-signature
    restart: always
    build:
      context: ./gen-email-signature
    ports:
      - "3200:3200"
    volumes:
      - ./gen-email-signature/public/data.csv:/app/public/data.csv
    networks:
      - app_network  # Nginx와 통신할 내부 네트워크

  nginx:
    image: nginx:latest
    container_name: nginx-proxy
    restart: always
    ports:
      - "443:443"  # HTTPS 트래픽 처리
      - "80:80"    # HTTP 트래픽 처리 (HTTPS 리디렉트 가능)
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./certs:/etc/nginx/certs:ro
    depends_on:
      - gen-email-signature
    networks:
      - app_network

networks:
  app_network:
    driver: bridge
```

- nginx.conf
```conf
events {
    worker_connections 1024;
}

http {
    server {
        listen 80;
        server_name 192.168.2.84;

        location / {
            return 301 https://$host$request_uri;
        }
    }

    server {
        listen 443 ssl;
        server_name 192.168.2.84;

        ssl_certificate /etc/nginx/certs/localhost.pem;
        ssl_certificate_key /etc/nginx/certs/localhost-key.pem;

        location / {
            proxy_pass https://gen-email-signature:3200;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto https;
        }
    }
}

```

- 잘못됫 이슈...
  - 신기한데...위 와 같이 적용하기 전에 다음먼저 적용한다음
  - 위 설정으로 복구하면 http://192.168.2.84:3200 도 redirect 되나?
  - 아래와 같이 설정할떄는 3200으로 서비스 되는거 expose :3200 으로 수정하고
  - nginx도 port 3200:3200 으로 열어줘야하긴함.
  - !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  - 알고 보니 개발하는 과정에서 쿠키 이슈 떄문이였음,
  - 다른 pc에서는 결국 !!! http://192.168.2.84:3200 는 접속 안됨

  ```conf
  events {
      worker_connections 1024;
  }

  http {
      server {
          listen 80;
          server_name 192.168.2.84;

          location / {
              return 301 https://$host$request_uri;
          }
      }

      server {
          listen 443 ssl;
          server_name 192.168.2.84;
          
          ssl_certificate /etc/nginx/certs/localhost.pem;
          ssl_certificate_key /etc/nginx/certs/localhost-key.pem;

          location / {
              proxy_pass https://gen-email-signature:3200;
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto https;
          }
      }

      server {
          listen 3200;
          server_name 192.168.2.84;

          location / {
              return 301 https://$host:3200$request_uri;
          }
      }

  }
  ```