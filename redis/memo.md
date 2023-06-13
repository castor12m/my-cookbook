## reids 실행, brew services in mac

ref : https://stackoverflow.com/questions/6910378/how-can-i-stop-redis-server

```
    $ brew services start|run redis 
    $ brew services stop redis
    $ brew services restart redis
```

## redis 실행, docker 이미지

ref <br/>
: https://hub.docker.com/_/redis <br/>
: https://emflant.tistory.com/235 <br/>
: https://velog.io/@coastby/redis-docker%EB%A1%9C-redis-%EB%9D%84%EC%9A%B0%EA%B8%B0 <br/>

```
    1) redis container 실행
    $ docker run -p 6379:6379 --name (redis 컨테이너 이름) -d redis:latest --requirepass "(비밀번호)"
    
    ex)$ docker run -p 6379:6379 --name docker_redis -d redis:alpine --requirepass "foobared"

    2) redis container - redis-cli 접근
    $ docker exec -i -t (redis 컨테이너 이름) redis-cli -a "비밀번호"

    ex)$ docker exec -i -t docker_redis redis-cli -a "foobared"   

```