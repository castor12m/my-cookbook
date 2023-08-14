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




### 다른 컨테이너에서 call 하는법

```c
    #ifdef FUNCTION_DATA_ENABLE
        { char __str_buf[1024] = ""; memset(&__str_buf[0], 0, sizeof(__str_buf)); sprintf(__str_buf, "curl -X 'GET' 'http://webapi:5900/result/' -H 'accept: application/json' -H 'Content-Type: application/json' -d '{ \"log\": \"%s\", \"code\": \"%s\", \"id\": \"0x%08X\", \"label\": \"%s\"}'",
                "Detect FDIR", "NO1-F-SBAND-04", (0x3FFFFFFF & EVENT_COMMAND_ERROR), ""); system(__str_buf); }
        { OS_printf("TestLog: DISP, Title=%s, Code=%s, ID=0x%08X\n", "Detect FDIR", "NO1-F-SBAND-04", (0x3FFFFFFF & EVENT_COMMAND_ERROR)); }
    #endif   
```