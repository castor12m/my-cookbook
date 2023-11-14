### insert 문에 여러가지 데이터 vs 여러개의 insert

ref : https://123okk2.tistory.com/472

```sql
    (case A) 개별적 방식
    INSERT INTO user VALUES ('a', 29, NOW()),  ('b', 30, NOW()),  ('c', 24, NOW()), ....
    --  1쿼리 0.063 초

    (case B) Batch
    INSERT INTO user VALUES ('a', 29, NOW())
    INSERT INTO user VALUES ('b', 30, NOW())
    INSERT INTO user VALUES ('c', 24, NOW())
    ...
    -- 1000쿼리 4.574 초

```

블로그에 기재된 속도 차이 결과 (chatgpt 참조해서 적엇다고함)

- 개별적으로 insert 하면 그만큼 네트워크를 통해 데이터가 전송되므로 네트워크 지연이 발생
- batch insert 시 하나의 트랜잭션 내에서 여러 행을 insert 할 수 있어 트랜잭션 오버해드가 감소
- sql insert 문장은 데이터 베이스에서 파싱 및 컴파일이 필요한데, batch 방식이 한번만 파싱/컴파일 하면 되므로 오버헤드 감소
- 개별 삽입은 데이터 수만큼 디스크 I/O가 동작하는데 반해 batch 삽입은 한번의 디스크 I/O만 발생되므로 효율성 증대

> 결론
여러 데이터를 넣어야 한다면, batch 방식으로 한번에 여러 행을 넣어버리는 것이 효율적

> 그러나 예상 되는 문제점
- DB I/O를 위해 데이터가 메모리에 적재되므로?, 데이터 양이 과도하게 많을 경우 메모리 부족 문제가 발생 가능
- 데이터 중 하나의 데이터에만 오류가 존재해도 전체 배치가 실패할 수 있음