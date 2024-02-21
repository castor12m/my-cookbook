
## docker-compose arg 적용 타이밍 확인

https://stackoverflow.com/questions/39597925/how-do-i-set-environment-variables-during-the-docker-build-process/63640896#63640896

## 1. 구성

```bash
  ├── docker-compose.yml            # 1.1.1)
  ├── readme.md
  ├── .env                          # 1.1.2)
  └── test-app
      ├── app.py
      ├── build.sh
      └── buildfile
          └── Dockerfile.option1    # 1.1.3)
```


### 1.1 세부 파일

#### 1.1.1 docker-compose.yml 

```
version: '3.7'

networks:
  default:
    name: dtest

services:
  test-app:
    image: naraspace/arg-timing-test
    container_name: arg-timing-test
    environment:
      - SAT_MODE_INFO=${SAT_MODE_CONFIG}
    build:
      context: ./test-app
      dockerfile: ./buildfile/Dockerfile.${SAT_MODE_CONFIG}
      args:
        some_variable_name: a_value

```

#### 1.1.2 .env

```
SAT_MODE_CONFIG=option1
SAT_MODE_KEY=flower-green-ice-nation
```

#### 1.1.3 Dockerfile.option1

```
FROM naraspace/base:0.1 AS build

WORKDIR /src

ARG some_variable_name
ARG env_top_key
# or with a hard-coded default:
#ARG some_variable_name=default_value

RUN echo "Test some_variable_name: $some_variable_name"
RUN echo "Test env_top_key: $env_top_key"

COPY . .

ENV SAT_MODE_INFO=OBS1B

RUN bash build.sh

FROM build AS final

CMD ["python", "app.py"]
```

아래와 같이 ARG에 기본값을 부여해도 됨

```
  (...)
  ARG some_variable_name=default_value1
  ARG env_top_key=default_top_key
  # or (아래와 같이 기본값 없이 아규먼트 선언만 해도 Docker-compose 파일 에서 입력한 값이 설정됨)
  #ARG some_variable_name
  #ARG env_top_key
  (...)
```

### 1.2 빌드 결과

```bash
  $ docker-compose up -d
  >>>
  
  [+] Running 1/1
  (...)
  => [test-app build 3/6] RUN echo "Test some_variable_name: a_value"
  => [test-app build 4/6] RUN echo "Test env_top_key: flower-green-ice-nation"
  => [test-app build 5/6] COPY . .
  => [test-app build 6/6] RUN bash build.sh
  => [test-app] exporting to image  
  (...)

  [+] Running 1/2
  ⠹ Network dtest              Created
  ✔ Container arg-timing-test  Started                                              
```