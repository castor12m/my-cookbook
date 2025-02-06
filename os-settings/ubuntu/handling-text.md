### 0. ref

- 링크
    - https://rangvest.tistory.com/entry/Linux-%ED%85%8D%EC%8A%A4%ED%8A%B8-%EC%B2%98%EB%A6%ACwget-cattac-moreless-headtail-trsed-sortuniq-%EB%A6%AC%EB%88%85%EC%8A%A4-%EC%83%9D%ED%83%9C%EA%B3%84-%EC%83%9D%EC%A1%B4-%EA%B0%80%EC%9D%B4%EB%93%9C-Part4


## wget (텍스트 파일 다운로드)

### 사용법
```bash
$ wget [URL]
```

### 예시
```bash
$ wget https://www.gutenberg.org/cache/epub/71885/pg71885.txt
```

---

## cat / tac

파일 내용을 출력하거나 결합하는 기능을 수행합니다.

### 사용법
```bash
$ cat [파일명][.확장자]
$ cat [파일명1][.확장자] [파일명2][.확장자] [파일명3][.확장자]  # 여러 파일 한 번에 출력
```

### 예시
```bash
$ cat example_text_file.txt
```

### 파일 결합
```bash
$ cat [파일명1][.확장자] [파일명2][.확장자] > [파일명3][.확장자]
```

> `>` 연산자를 사용하면 파일1과 파일2의 내용이 파일3에 저장됩니다.

### `tac` 사용법 (파일을 역순으로 출력)
```bash
$ tac [파일명1][.확장자]
```

### 예시
```bash
$ tac example_text_file.txt
```

---

## more / less (파일 내용을 페이지 단위로 출력)

### 사용법
```bash
$ more [파일명][확장자]
$ less [파일명][확장자]
```

### 예시
```bash
$ more example_text_file.txt
$ less example_text_file.txt
```

> `more`는 뒤로 이동 불가능하지만, `less`는 자유롭게 이동 가능
> `/[검색어]` 입력 시 키워드 검색 가능
> `h` 키를 누르면 도움말 확인 가능 (`q`로 종료)

---

## head / tail (파일 일부 내용 출력)

### 사용법
```bash
$ head [파일명][확장자]         # 기본 10줄 출력
$ head -n [숫자] [파일명][확장자]  # 처음부터 [숫자] 줄 출력
$ tail [파일명][확장자]         # 기본 10줄 출력
$ tail -n [숫자] [파일명][확장자]  # 마지막 [숫자] 줄 출력
```

### 예시
```bash
$ head -n 20 example_text_file.txt
$ tail -n 20 example_text_file.txt
```

---

## wc (텍스트 통계)

### 사용법
```bash
$ wc [파일명][확장자]
```

### 예시
```bash
$ wc example_text_file.txt
```

출력되는 값: `줄 수`, `단어 수`, `바이트 수`

---

## nl (행 번호 붙이기)

### 사용법
```bash
$ nl [파일명][확장자]
```

### 예시
```bash
$ nl example_text_file.txt
```

---

## grep (파일 내 문자열 검색)

### 사용법
```bash
$ grep "문자열" [파일명][확장자]
$ grep --color "문자열" [파일명][확장자]  # 검색 결과 하이라이트
```

### 예시
```bash
$ grep "Vim" feature.en.txt
$ grep --color "Vim" feature.en.txt
```

---

## tr (문자 변환)

### 사용법
```bash
$ tr "문자1" "문자2" < [파일명][확장자]
```

### 예시
```bash
$ tr "Vim" "Vi IMproved" < example_text_file.txt
```

> 변환된 결과는 파일에 저장되지 않고 출력만 됩니다.

---

## sed (문자열 변환)

### 사용법
```bash
$ sed 's/문자열1/문자열2/g' [파일명][확장자]
```

### 예시
```bash
$ sed 's/What is Vim/Vim is What/g' example_text_file.txt
```

> `g` 옵션은 전체 변환을 의미합니다.

---

## 파이프 (명령어 결과를 다음 명령어로 전달)

### 사용법
```bash
$ 명령어1 | 명령어2
```

### 예시
```bash
$ sed 's/Vim/Vim IMproved/g' example_text_file.txt | head -n 20 | grep --color "Vi IMproved"
```

---

## sort (정렬)

### 사용법
```bash
$ sort [파일명][확장자]
$ sort -k [숫자] [파일명][확장자]  # 특정 필드를 기준으로 정렬
$ sort -t"구분자" -k [숫자] [파일명][확장자]  # 구분자 지정
```

### 예시
```bash
$ tail -n 10 gang.txt | sort
$ sort -k 2 gang.txt
$ sort -t"," -k 2 gang.txt
```

---

## uniq (중복 행 제거)

### 사용법
```bash
$ uniq [파일명][확장자]
$ uniq -c [파일명][확장자]  # 중복 횟수 출력
```

### 예시
```bash
$ uniq gang.txt
$ sort gang.txt | uniq -c
```

---

## awk (패턴 매칭 및 텍스트 처리)

### 사용법
```bash
$ awk '{ print $1 }' [파일명]   # 첫 번째 필드 출력
$ awk -F "," '{ print $2 }' [파일명]   # 콤마 기준 두 번째 필드 출력
```

### 예시 (파일 내용)
```
John, 25, USA
Jane, 30, UK
Mike, 22, Canada
```

```bash
$ awk -F "," '{ print $1 }' example.txt
```

### 결과
```
John
Jane
Mike
```

> `awk`는 특정 패턴을 찾고 필드를 조작하는 데 유용합니다.


