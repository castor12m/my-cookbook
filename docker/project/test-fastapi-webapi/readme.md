https://github.com/tiangolo/fastapi

https://wikidocs.net/175214

https://lsjsj92.tistory.com/648


fastapi container 에서 다음 실행

```
    # main.py 가 있는 위치
    (/src)
    $ uvicorn main:app --reload


    # https://velog.io/@primadonna/Fast-API-%EC%82%AC%EC%9A%A9%ED%95%B4%EB%B3%B4%EA%B8%B0-1
    $ uvicorn main:app --reload --port=5900
```


uvicorn main:app --reload --host='0.0.0.0' --port=5900