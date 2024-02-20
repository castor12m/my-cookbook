# FSW FDIR Test w/ Jenkins

  

* * *

* * *

  

## 1\. 비바람이 닥치기 전에 우산을 만들자

  

시스템 범위 및 목적, 목표, 선택지 선택 이유, 테스트 해서 나은 것 비교

  

### 1.1. 범위 목적

  

자문 자답...

  

#### 1.1.a 테스트 관련

  

*   Docker Container 위에서 동작하는 Mini-SDS + FSW 조합으로 FDIR 테스트
*   해당 동작은 로컬 머신에서 동작 시키고 싶음,

\>> Mini-SDS Web 보안이 안되어 있기 때문에 로컬에서 동작시켜서 접근하기 용이하다고 판단

\>> 이후 물리 장치 연결해서 테스트하기도 편리

\>> 물리 장치가 필요한 경우만 로컬 머신에서 동작, 필요 없는것은 AWS instance 에서 테스트해도?

\>> 맞음.

  

#### 1.1.b CI 툴 관련

  

*   Jenkins 서비스는 AWS 에서 제공해서 외부에서도 테스트 실행을 할 수 있고, 테스트 상황을 확인 하기 용이하도록 하는게 향후를 위해 좋을듯?

\>> 보안은?

\>> Jenkins 에서 이미 계정으로 보안 되어 있음

\>> https 지원?

\>> 스터디 필요..

  

### 1.2. CI 종류

  

무료로 사용할 수 있는 것들 대표적인것들

  

*   Jenkins

: 무료!, 다양한 플러그인

: 주요 포인트, git 토큰을 입력 받아서...사용 가능?

  

*   GoCD

: GUI 지원이 잘되어있음, 있어보임..

: git 토큰 따로 입력 불가, git 주소에 같이 넣어줘야함

: 할당된 agent 의 디렉토리 하위에서만 가능한듯. 벗어나면 쉘로 접근 안됨

  

*   Travis CI

: 안써봄.

: Github와의 연동이 좋은듯?

  

*   Github Action

: Github Action 되는 곳에서 Docker 까지...너무 무거운데

: 단일 프로젝트 CI/CD 사용하기에는 좋은듯

: 동민씨 팀에서 사용 하는 방법

\>> Github Action 으로 AWS instance 로 테스트 트리거 시켜서,

AWS instance 에서 git 댕겨 받고 빌드해서 딜리버리 하는 구조인듯.

  

### 1.3. 테스트 스텝 구상

  

#### 1.3.a 준비 단계

  

1. Agent에 DAS 가 미리 실행.
2. Agent에 SIM이 모두 실행되어 있거나, Zmqproxy 서비스는 미리 실행.
3. Agent에 FSW 컨테이너만 실행.

  

#### 1.3.b 테스트 단계

  

1. 위성 모드 및 기타 설정 테스트 목적에 맞게 수정
2. STB 가 실행되어있지 않다면 실행, 실행 되어 있다면 재시작
3. STB 실행 구간까지 딜레이
4. FDIR 조건에 맞게 조건 설정
    1. FDIR 조건에 따라 테스트 스크립트와 FSW 실행 선후를 Test 테스크에서 설정
    2. 테스트 합/부합 여부
        1. FDIR 조건에 따른 이벤트 발생 ➝ 종료
        2. FDIR 조건에 따른 예상 시간 타임아웃 발생 ➝ 종료
5. FSW 실행 종료
6. STB 종료

  

### 1.4. 더 필요한 것들?

  

Jenkins 에서 테스트 합/부합 여부를 판단하는 방법 궁리 필요.

  

  

## 2\. 우산을 들자

  

Jenkins 로 진행!

  

### 2.1. 본격 테스트

  

#### 2.1.a 병렬 실행 관련

  

Pipeline Script 를 통해 병렬로 Job이 가능함.

  

트리거 Job 을 통해 할당된 Job들을 실행 시킬 예정

  

예시)

  

```python
pipeline {
    agent none
    stages
    {
        stage(‘runtest’)
        {
             parallel { 
                stage('fdir-test-obs1a/work-001') {
                    steps{ build 'fdir-test-obs1a/work-001' }
                }
                stage('fdir-test-obs1a/work-002') {
                    steps{ build 'fdir-test-obs1a/work-002' }
                }
                stage('fdir-test-obs1a/work-003') {
                    steps{ build 'fdir-test-obs1a/work-003' }
                }
            }
        }
    }
}
```

  

#### 2.1.b 도커 쉘 실행 방법 관련

  

1. 도커 쉘 명령으로 콘솔 접속해서 내리기 - 실패

```cs
...
+ docker exec -it fsw /bin/bash
the input device is not a TTY
Build step 'Execute shell' marked build as failure
Finished: FAILURE
...
# 이렇게 실행하면 안됨, jenkins 에이전트로 명령 내리는건 
```

  

1. 연속 명령 - 안됨

  

```cs
docker exec fsw ls -al;ls -al
# 이렇게 명령어 두개 연속하게 되면 당연하게도? 첫번째 ls -al은 컨테이너 에서 실행 되지만
# 두번째 ls -al 은 외부 호스트에서 실행되버림
```