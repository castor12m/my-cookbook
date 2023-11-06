## 1. install on mac

ref : https://0xd00d00.github.io/2021/08/05/plant_uml.html

#### 1. 1 자바 설치

ref : https://llighter.github.io/install-java-on-mac/

```bash
    brew update
    brew tap adoptopenjdk/openjdk   # tap (Taps : Third-Party Repositories)
    brew search jdk
    >>>
    ==> Casks
    adoptopenjdk                                             adoptopenjdk/openjdk/adoptopenjdk14-openj9-jre
    adoptopenjdk/openjdk/adoptopenjdk-jre                    adoptopenjdk/openjdk/adoptopenjdk14-openj9-jre-large
    adoptopenjdk/openjdk/adoptopenjdk-openj9                 adoptopenjdk/openjdk/adoptopenjdk14-openj9-large
    adoptopenjdk/openjdk/adoptopenjdk-openj9-jre             adoptopenjdk/openjdk/adoptopenjdk15

    (원하는 버전 설치)
    brew install --cask adoptopenjdk11

    java --version
    >>>
    openjdk 14.0.2 2020-07-14
    OpenJDK Runtime Environment AdoptOpenJDK (build 14.0.2+12)
    OpenJDK 64-Bit Server VM AdoptOpenJDK (build 14.0.2+12, mixed mode, sharing)
```

#### 1. 2 graphicviz 설치

```bash
    brew install graphviz
```

#### 1. 3 plantuml 설치

```bash
    brew install plantuml
```

#### 1. 4 vscode 플러그인 설치

vscode 플러그인에서 PlantUML 찾아서 설치

#### 1. 5 vscode 플러그인 설정

vscode 플러그인에서 PlantUML 찾아서 설치

vscode 설정에서 '@ext:jebbs.plantuml'을 입력하여 검색

표시되는 탭의 항목에서 'PlantUML: Jar' 에 설치한 plantUML jar 위치 입력.

```
    brew로 설치했다면 'brew info plantuml'을 통해서 해당 패키지 위치를 알 수 있음.

    해당 폴더에서 jar 위치를 찾아서 vscode 항목에 입력

    /opt/homebrew/Cellar/plantuml/1.2023.12/libexec/plantuml.jar
```

