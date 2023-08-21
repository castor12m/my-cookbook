https://stackoverflow.com/questions/33711818/embed-sqlite-database-to-docker-container

``` bash
    $ docker build -t naraspace/sqlite:0.1 .

    $ docker run -it -d -v ./sqlite_db:/sqlite_db --name sqlite_test naraspace/sqlite:0.1

    $ docker exec -it sqlite_test /bin/bash
```


```sql
(https://bskyvision.com/entry/sqlite3-%EA%B8%B0%EB%B3%B8-%EB%AA%85%EB%A0%B9%EC%96%B4-%EB%B0%8F-create-read-update-delete-%ED%95%98%EB%8A%94-%EB%B2%95-%EC%A0%95%EB%A6%AC)

    # 데이터베이스 확인
    .database

    # 테이블 확인
    .tables

    # 테이블 생성
    CREATE TABLE student (name TEXT NOT NULL, math INT, english INT);

    # 테이블 구조 확인
    .schema student

    insert into student (name, math, english) VALUES ('james', 91, 90);
    insert into student (name, math, english) VALUES ('jammy', 80, 100);
    insert into student (name, math, english) VALUES ('garfield', 70, 80);
    insert into student (name, math, english) VALUES ('kyu', 81, 80);
    insert into student (name, math, english) VALUES ('apples', 69, 81);
    insert into student (name, math, english) VALUES ('nvidia', 60, 61);
    insert into student (name, math, english) VALUES ('atnt', 59, 95);
    insert into student (name, math, english) VALUES ('tesla', 58, 95);
    insert into student (name, math, english) VALUES ('meta', 80, 88);

    # 데이터 read
    SELECT * FROM student;

    # 데이터 갱신
    UPDATE student SET english = 90 WHERE rowid = 3;
    UPDATE student SET english = 60 WHERE name = '심교훈';

    # 데이터 삭제
    DELETE FROM student WHERE name = '문태호';

    # 테이블 삭제
    DROP TABLE student;
```