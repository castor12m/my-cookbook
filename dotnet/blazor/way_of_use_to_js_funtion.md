### 0. 참조
- https://code-maze.com/how-to-call-javascript-code-from-net-blazor-webassembly/


### 1. __코드에서 명시적으로 불러와서 사용하는 방법__

#### 1.1 .razor 파일에 스크립트 태그로 사용할 js 파일 명시

- [wwwwroot]-"{js_file_name}.js" 위치에 있다는 가정하에
- 해당 js 파일을 불러올 razor 파일 혹은 app.razor body에 스크립트 태그 로드할것 해놔야함.
```razor
    <script src="{js_file_name}.js"></script> 
```

#### 1.2 JS 파일에서 사용할 함수 앞에 export 키워드 적용
- "{js_file_name}.js 에서 사용할 함수 앞에 export 키워드가 붙여 있어야 불러 올 수 있음.
```javascript
    export function showAlert() { ... }
```

#### 1.3 JS Import 및 함수 사용
- 아래와 같은 형태로 사용
```cs
    // 사용 맴버 선언 부
    [Inject]
    public IJSRuntime jsRuntime { get; set; }
    private IJSObjectReference _jsModule;

    // js 파일 불러오는 부분
    _jsModule = await jsRuntime.InvokeAsync<IJSObjectReference>("import", "./{js_file_name}.js");

    // 불러온 js 파일의 함수 호출 부분
    await _jsModule.InvokeVoidAsync("{js_funtion_name}"); 
```


### 2. __암묵적으로 사용하는 방법__

#### 2.1 (주의) 사용할 JS 파일에 어떠한 함수라도 export 키워드가 붙어 있으면 에러남..
- 아래와 같이 바로 함수명으로 호출하여 사용
```cs
    jsRuntime.InvokeVoidAsync("{js_funtion_name}");
```
