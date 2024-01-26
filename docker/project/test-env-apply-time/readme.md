
## docker-compose env 적용 타이밍 확인


## 1. 구성

```bash
  ├── docker-compose.yml  # 1)
  ├── readme.md
  ├── .env                # 2)
  └── test-app
      ├── Dockerfile      # 3)
      ├── app.py          # 4)
      └── build.sh        # 5)
```

- .1) docker-compose.yml

```docker-compose
  version: '3.7'

  networks:
    default:
      name: dtest

  services:
    test-app:
      image: naraspace/env-timing-test
      container_name: env-timing-test
      environment:
        - SAT_MODE_INFO=${SAT_MODE_CONFIG}
      build:
        context: ./test-app


```

- .2) .env

```
  SAT_MODE_CONFIG=obs1a
```

- .3) test-app/Dockerfile

```dockerfile
  FROM naraspace/base:0.1 AS build

  WORKDIR /src

  COPY . .

  ENV SAT_MODE_INFO=FIRE_SAT

  RUN bash build.sh

  FROM build AS final

  CMD ["python", "app.py"]
```

- .4) test-app/app.py

```python
  import time
  import os


  env_value = os.environ['SAT_MODE_INFO']

  print('test')
  print(f"env_value = {env_value}")

  f= open("env_check_in_run.txt","w+")
  f.write(f"{env_value}\r\n")
  f.close()

  i = 0
  while i <= 0:
      time.sleep(1)
```

- .5) test-app/build.sh

```sh
  echo $SAT_MODE_INFO >> env_check_in_build.txt
```

## 2. 결과

빌드 명령

```
  $ docker-compose up -d --build
```

컨테이너에 생성된 파일 

```
  $ ls -al
  total 28
  drwxr-xr-x 1 root root 4096 Jan 25 16:41 .
  drwxr-xr-x 1 root root 4096 Jan 25 16:41 ..
  -rw-r--r-- 1 root root  150 Jan 25 16:37 Dockerfile
  -rw-r--r-- 1 root root  227 Jan 25 16:39 app.py
  -rw-r--r-- 1 root root   45 Jan 25 16:39 build.sh
  -rw-r--r-- 1 root root    9 Jan 25 16:39 env_check_in_build.txt
  -rw-r--r-- 1 root root    7 Jan 25 16:41 env_check_in_run.txt
  $ 
  $ cat env_check_in_build.txt
  FIRE_SAT
  $ cat env_check_in_run.txt
  obs1a
  $ 
  $ 
```


## 3. 전략

.env 옵션에 따라

빌드시 사용하는 Dockerfile을 다르게 가져가기

### 3.1. 새 구성

```bash
  ├── docker-compose.yml    # 1)
  ├── readme.md
  ├── .env                  # 2)
  └── test-app
      ├── Dockerfile.bss    # 3)
      ├── Dockerfile.obs1b  # 4)
      ├── app.py
      ├── build.sh
      └── show.sh           # 5)     
```

- .1) docker-compose.yml

```docker-compose
  version: '3.7'

  networks:
    default:
      name: dtest

  services:
    test-app:
      image: naraspace/env-timing-test
      container_name: env-timing-test
      environment:
        - SAT_MODE_INFO=${SAT_MODE_CONFIG}
      build:
        context: ./test-app
        dockerfile: ./Dockerfile.${SAT_MODE_CONFIG}
```

- .2) .env

```
  SAT_MODE_CONFIG=obs1b
```

- .3) test-app/Dockerfile.bss

```dockerfile
  FROM naraspace/base:0.1 AS build

  WORKDIR /src

  COPY . .

  ENV SAT_MODE_INFO=BSS

  RUN bash build.sh

  FROM build AS final

  CMD ["python", "app.py"]
```

- .4) test-app/Dockerfile.obs1b

```dockerfile
  FROM naraspace/base:0.1 AS build

  WORKDIR /src

  COPY . .

  ENV SAT_MODE_INFO=OBS1B

  RUN bash build.sh

  FROM build AS final

  CMD ["python", "app.py"]
```

- .5) test-app/show.sh

```sh
  echo env_check_in_build.txt read :
  cat env_check_in_build.txt
  echo ""

  echo env_check_in_run.txt read :
  cat env_check_in_run.txt
  echo ""

```

### 3.2. 해당 빌드 결과

빌드 명령

```
  $ docker-compose up -d --build
```

```
  $ ls -al
  total 40
  drwxr-xr-x 1 root root 4096 Jan 25 17:02 .
  drwxr-xr-x 1 root root 4096 Jan 25 17:01 ..
  -rw-r--r-- 1 root root  150 Jan 25 16:37 Dockerfile
  -rw-r--r-- 1 root root  145 Jan 25 16:54 Dockerfile.bss
  -rw-r--r-- 1 root root  147 Jan 25 16:54 Dockerfile.obs1b
  -rw-r--r-- 1 root root  227 Jan 25 16:39 app.py
  -rw-r--r-- 1 root root   45 Jan 25 16:39 build.sh
  -rw-r--r-- 1 root root    6 Jan 25 17:01 env_check_in_build.txt
  -rw-r--r-- 1 root root    7 Jan 25 17:02 env_check_in_run.txt
  -rw-r--r-- 1 root root  142 Jan 25 17:01 show.sh
  $ bash ./show.sh
  env_check_in_build.txt read :
  OBS1B

  env_check_in_run.txt read :
  obs1b
```