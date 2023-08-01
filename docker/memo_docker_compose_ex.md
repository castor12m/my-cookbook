
### 예제 1. 

ref : https://scarlett-dev.gitbook.io/all/docker/docker-compose-+-db+-1

엔진엑스 + 몽고db + 익스프레스 환경을 셋팅

```dockerfile

version: "3"
services:

  redis:
    image: redis:alpine
    ports:
      - "6379"
    networks:
      - frontend
    deploy:
      replicas: 2
      update_config:
        parallelism: 2
        delay: 10s
      restart_policy:
        condition: on-failure

  db:
    image: postgres:9.4
    volumes:
      - db-data:/var/lib/postgresql/data
    networks:
      - backend
    deploy:
      placement:
        constraints: [node.role == manager]

  vote:
    image: dockersamples/examplevotingapp_vote:before
    ports:
      - 5000:80
    networks:
      - frontend
    depends_on:
      - redis
    deploy:
      replicas: 2
      update_config:
        parallelism: 2
      restart_policy:
        condition: on-failure

  result:
    image: dockersamples/examplevotingapp_result:before
    ports:
      - 5001:80
    networks:
      - backend
    depends_on:
      - db
    deploy:
      replicas: 1
      update_config:
        parallelism: 2
        delay: 10s
      restart_policy:
        condition: on-failure

  worker:
    image: dockersamples/examplevotingapp_worker
    networks:
      - frontend
      - backend
    deploy:
      mode: replicated
      replicas: 1
      labels: [APP=VOTING]
      restart_policy:
        condition: on-failure
        delay: 10s
        max_attempts: 3
        window: 120s
      placement:
        constraints: [node.role == manager]

  visualizer:
    image: dockersamples/visualizer:stable
    ports:
      - "8080:8080"
    stop_grace_period: 1m30s
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
    deploy:
      placement:
        constraints: [node.role == manager]

networks:
  frontend:
  backend:

volumes:
  db-data:    

```


### 예제 2. 

ref : https://darrengwon.tistory.com/793

```dockerfile

version: '3'

volumes:
  postgres_data: {}

services:
  db:
    image: postgres
    volumes:
      - postgres_data:/var/lib/postgres/data
    environment:
      - POSTGRES_DB=djangosample
      - POSTGRES_USER=sampleuser
      - POSTGRES_PASSWORD=samplesecret
      
  django:
    build:
      context: .
      dockerfile: ./compose/django/Dockerfile-dev
    volumes:
      - ./:/app/
    command: ["./manage.py", "runserver", "0:8000"]
    environment:
     - DJANGO_DB_HOST=db
    depends_on:
      - db
    restart: always
    ports:
      - 8000:8000

```


### 예제 3. 

ref : https://darrengwon.tistory.com/793

flask + redis 조합

```dockerfile
    # dockerfile
    FROM python:3.7-alpine

    WORKDIR /code

    ENV FLASK_APP app.py
    ENV FLASK_RUN_HOST 0.0.0.0

    RUN apk add --no-cache gcc musl-dev linux-headers
    COPY requirements.txt requirements.txt
    RUN pip install -r requirements.txt

    COPY . .

    CMD ["flask", "run"]
```

```dockerfile
    # docker-compose
    version: '3'

    services:
        redis:
            image: redis
            ports:
             - 6379:6379
            restart: always

        flask:
            image: whateveryouwant
            build:
             context: .
             dockerfile: .
            ports:
             - 5000:5000
            depends_on:
             - redis
            restart: always
```

### 예제 4.

container 계속 실행 시키는 트릭

```
  (dockcer-compose)
  ...
    command: "ping -D -i 10 0.0.0.0"
  ...
  
```
```
  (Dockerfile)
  ...
  ENTRYPOINT ["tail", "-f", "/dev/null"]
```