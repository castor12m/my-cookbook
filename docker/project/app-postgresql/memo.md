
### install

``` bash
    $ docker build -t postgres-ko:14 .
    $ docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=password -v postgres14-data:/var/lib/postgresql/data postgres-ko:14

    ex)
    $ docker run -d -p 5432:5432 -e POSTGRES_PASSWORD=1234 -v postgres14-data:/var/lib/postgresql/data --name postgresql_test postgres-ko:14
```

### check

```bash
    $ docker exec -it postgresql_test /bin/bash

    (postgresql_test) $ psql -U postgres
                      $ psql -h localhost -p 5432 -U postgres 
    postgres=#  \l

    # [psql 기본 명령어]
    # https://shawn-dev.oopy.io/4a432950-75eb-464a-b8b8-61265123c699
    # GUI 툴로도 DB 를 조작할 수 있지만 CLI 로 postgreSQL 를 다루기 위해서는 psql (postgreSQL 쉘) 을 사용한다. 
    # psql 은 커맨드 앞에 \ 를 붙힌다.
    # psql 도움말 : \?
```

### db uri

https://www.bearpooh.com/122

```bash
    # postgresql://{PostgreSQL_ID}:{PostgreSQL_Password}@{PostgreSQL_Address}:{Port}/{Dabtase_Name}

    ex)
    id = postgres   # 기본 ID 인듯
    pw = postgresql
    $ export DB_URI = 'postgresql://postgres:postgresql@{host_ip}@5432/postgres'

	
    postgresql://postgres:postgresql@172.17.0.4@5432/postgres
```

### psql 명령어

https://postgrescheatsheet.com/#/queries

https://rianshin.tistory.com/68

```bash
    # 접속
    $ psql -U postgres
    
    # 데이터 베이스 목록
    postgres=# \l

    # 비밀번호 변경
    postgres=# \password postgres

    # 주이!! 명령어 입력할때, create 전에 한칸띄우기 해야 명령어됨......?
    # 아닐 때도 있네,, 이전에 입력된 문자열 버퍼가 뭐 남나?
    # 아니면 세미콜론 같이 붙여서
    # ex)  create database superset;
    # ...
    # 성공하면 다음과 같이 됨
    #   $ postgres=#  create database superset;
    #   >>> CREATE DATABASE
    postgres=# create database superset

    # 테이블 만들기
    postgres=# create table testa (key char(16) primary key, val1 integer, val2 integer);
    # 행 추가
    insert into testa values('key00A', 90, 100);
    insert into testa values('key00B', 80, 90);
    insert into testa values('key00C', 70, 20);
    insert into testa values('key00D', 75, 90);
    insert into testa values('key00E', 60, 90);
    insert into testa values('key00F', 85, 75);

    postgres=# create table testb (key SERIAL primary key, subsystem char(16), time_count integer, val integer);
    insert into testb(subsystem, time, val) values('AOCS', 0, 23.7);
    insert into testb(subsystem, time, val) values('PDHS', 0, 28.5);
    
    insert into testb(subsystem, time, val) values('AOCS', 2, 22.1);
    insert into testb(subsystem, time, val) values('AOCS', 3, 21.5);
    insert into testb(subsystem, time, val) values('PDHS', 1, 28.0);
    insert into testb(subsystem, time, val) values('PDHS', 2, 27.8);
    insert into testb(subsystem, time, val) values('PDHS', 3, 27.4);

    # 테이블 지우기 
    postgres=# drop table testa;

    # 테이블 조회
    \dt

```


superset setting

```
    host = postgresql 주소
    port =      ''    포트
    database name = postgres (기본)
    username = 유저네임
    password = ''
```
