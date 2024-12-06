
## 0. ref
- 참조
    - https://velog.io/@jk01019/c-clang-format-Like-yapf

## 1. code-formatter

- by GPT
```
코드 스타일을 점검하고 수정해주는 도구를 일반적으로 코드 포매터(Code Formatter)**라고 부릅니다. 
코드 포매터는 코드의 가독성을 높이고 일관된 스타일을 유지하도록 도와줍니다.
```


### 1.1 C++ code formatter

- by GPT
```
1. ClangFormat
    특징:
        LLVM 프로젝트의 일부로, C++뿐 아니라 C, JavaScript, Objective-C 등도 지원.
        .clang-format 설정 파일을 통해 세세한 스타일 규칙 정의 가능.
        주요 IDE(Visual Studio, VS Code, CLion 등)와 통합 가능.
        Git hooks를 통해 자동화 가능.
    장점:
        매우 빠르고 신뢰성 있음.
        유연한 설정 파일 지원.
        최신 C++ 표준(C++20, C++23 등)까지 지원.
    단점:
        초기 설정 파일 작성이 복잡할 수 있음.
        LLVM 스타일을 기반으로 하여, 팀의 특수한 스타일 요구를 맞추려면 설정을 많이 수정해야 할 수 있음.

2. AStyle (Artistic Style)
    특징:
        오픈 소스 포매터로 C, C++, C# 지원.
        다양한 스타일 옵션 제공(BSD, Google, GNU 등).
        명령줄 인터페이스 기반으로 동작.
    장점:
        가볍고 빠른 실행 속도.
        설정 파일 없이도 간단하게 사용 가능.
    단점:
        최신 C++ 표준(C++20 이후)에 대한 지원이 부족할 수 있음.
        설정 옵션이 ClangFormat만큼 세부적이지는 않음.

3. Uncrustify
    특징:
        다수의 프로그래밍 언어(C, C++, C#, Java 등)를 지원.
        매우 상세한 설정 가능(600개 이상의 옵션 제공).
        설정 파일을 통해 포매팅 스타일 완전 제어 가능.
    장점:
        복잡한 팀 요구사항도 충족 가능.
        다양한 언어 지원.
    단점:
        설정이 복잡하며 처음 사용하기 어려울 수 있음.
        ClangFormat에 비해 속도가 느릴 수 있음.

4. EditorConfig with plugins
    특징:
        IDE에 EditorConfig 플러그인을 추가하여 C++ 스타일 정의.
        간단한 .editorconfig 파일을 통해 공통 스타일 설정 가능.
    장점:
        IDE 독립적인 설정 파일 관리 가능.
        Git과 같은 버전 관리 시스템에서 설정 공유에 적합.
    단점:
        포매팅보다는 스타일 일관성을 유지하는 데 중점.
        세부적인 C++ 포매팅은 지원하지 않을 수 있음.

5. Prettier (for C++ 지원 플러그인 포함)
    특징:
        주로 웹 관련 언어를 포매팅하는 도구이나, 플러그인을 통해 C++ 지원 가능.
        고정된 포매팅 스타일 제공(설정이 제한적).
    장점:
        "설정이 아닌 규칙" 철학을 따르며 논쟁 줄임.
        다중 언어를 사용하는 프로젝트에 유용.
    단점:
        C++의 복잡한 스타일 요구사항에는 부족할 수 있음.
        설정 커스터마이징 제한적.


ClangFormat: 최신 C++ 표준을 사용하는 팀과 지속적인 통합이 필요한 프로젝트에 적합.
AStyle: 간단하고 빠르게 사용할 수 있는 기본적인 스타일링 도구가 필요한 경우.
Uncrustify: 매우 세부적인 스타일 컨트롤이 필요한 경우.
EditorConfig: 여러 IDE를 사용하는 개발자들과 협업할 때.
Prettier: 단순한 설정과 멀티언어 포매팅이 필요한 경우.

```

### 1.2 ClangFormat

- 참고
    - https://minemanemo.tistory.com/107
    - https://velog.io/@jk01019/c-clang-format-Like-yapf

#### 1.2.1 설치

```bash
    # Ubuntu (Debian 계열)
    sudo apt install clang-format

    # macOS
    brew install clang-format

    # Windows
    # Windows에서는 LLVM 공식 사이트에서 다운로드하거나, choco를 통해 설치할 수 있습니다.
    choco install llvm
```

#### 1.2.2 사용

```bash
    clang-format -i -style=Google your_code.cpp
    # clang-format: 코드 스타일을 자동으로 정리해주는 도구입니다.
    # -i: 파일을 직접 수정(in-place) 합니다. 즉, 코드를 정리한 뒤 파일에 저장합니다.
    # -style=Google: Google 코드 스타일을 사용하여 형식을 맞춥니다. Google 스타일은 명확한 가독성을 유지하는데 집중하는 방식으로, C++에서 널리 사용됩니다.
    # your_code.cpp: 스타일을 맞추려는 C++ 파일 이름입니다.

    # 여러 파일 적용
    # 여러 파일에 동일한 명령어를 적용하고 싶다면, 와일드카드를 사용할 수 있습니다. 예를 들어, 현재 디렉터리의 모든 .cpp와 .h 파일에 Google 스타일을 적용하려면:
    clang-format -i -style=Google *.cpp *.h

    # clang-format 설정 파일을 통한 스타일 적용
    # 프로젝트 전체에 동일한 스타일을 유지하고 싶다면, 
    # .clang-format이라는 설정 파일을 프로젝트 디렉터리에 만들어 사용할 수 있습니다.
    #  이 파일에 스타일을 정의해 두면, 여러 명령을 반복하지 않아도 동일한 스타일로 코드를 형식화할 수 있습니다.
    clang-format -style=Google -dump-config > .clang-format

    # 설정 파일을 사용한 코드 정리
    # .clang-format 설정 파일을 기반으로 C++ 코드를 정리하려면 다음 명령어를 사용합니다:
    clang-format -i your_code.cpp

    # 기타 스타일
    # clang-format은 Google 스타일 외에도 여러 스타일을 지원합니다. 예를 들어:
    # LLVM: -style=LLVM
    # Microsoft: -style=Microsoft
    # Chromium: -style=Chromium
    # Mozilla: -style=Mozilla
    # WebKit: -style=WebKit

    # 복합 사용 1 (xargs 사용)
    # 방법 1: find와 clang-format 사용하기 (Linux/MacOS)
    find /path/to/your/directory -name "*.cpp" -o -name "*.h" | xargs clang-format -i -style=Google
    # find /path/to/your/directory: /path/to/your/directory 경로에서 파일을 찾는 명령어입니다. 하위 디렉토리까지 재귀적으로 탐색합니다.
    # -name "*.cpp" -o -name "*.h": 확장자가 .cpp이거나 .h인 파일을 찾습니다.
    #   -o: 논리 OR 연산자로, .cpp 또는 .h 파일을 모두 찾습니다.
    # | xargs clang-format -i -style=Google: 찾은 파일 목록을 xargs를 사용해 clang-format에 전달합니다.
    #   -i: 파일을 직접 수정(in-place) 합니다.
    #   -style=Google: Google 스타일로 형식을 맞춥니다.
    ex)
    find . -name "*.cpp" -o -name "*.h" | xargs clang-format -i -style=Google

    # 복합 사용 2 (exec 사용)
    find /path/to/your/directory -name "*.cpp" -o -name "*.h" -exec clang-format -i -style=Google {} +
    # -exec: 각 파일에 대해 특정 명령을 실행합니다.
    # clang-format -i -style=Google {}: {}는 find로 찾은 파일의 경로를 나타내며, 각 파일에 대해 clang-format을 실행합니다.
    # +: 한 번에 여러 파일에 대해 명령을 실행하도록 합니다.

    # Windows 환경에서의 재귀적 적용 방법
    # PowerShell에서는 다음과 같이 재귀적으로 파일을 찾고 clang-format을 적용할 수 있습니다:
    Get-ChildItem -Recurse -Include *.cpp, *.h | ForEach-Object { clang-format -i -style=Google $_.FullName }
    # Get-ChildItem -Recurse: 현재 디렉토리와 모든 하위 디렉토리에서 파일을 검색합니다.
    # -Include *.cpp, *.h: .cpp와 .h 파일을 검색합니다.
    # ForEach-Object { clang-format -i -style=Google $_.FullName }: 각 파일에 대해 clang-format을 실행합니다.

```

#### 1.2.3 Clang-Format in VSCode

- 참고
    - https://medium.com/@wedevelop21/how-to-integrate-clang-format-with-visual-studio-code-5ae64a36f54e
    - https://skillupwards.com/blog/formatting-c-cplusplus-code-using-clangformat-and-vscode

- VSCode Plugin 에서 다음 설치

```
    플러그인 명칭 : Clang-Format
    작성자 이름 : Xaver Hellauer
```

- settings.json 에 다음 추가.
```json
{
    (...)

    "editor.formatOnSave": true,
    "clang-format.executable": "${workspaceRoot}/.clang-format"
}
```

- ${workspaceRoot}/.clang-format 위치
    - 쉘로 접속한 디렉토리 위치에 위치


- .clang-format 은 다음 'clang-format -style=Google -dump-config > ../.clang-format' 를 이용
    - 추가 수정한 부분.
    - struct 와 같은 형식 선언시 변수 시작 열 맞춤.
    ```
        AlignConsecutiveAssignments:
            Enabled: true
            AcrossEmptyLines: true
            AcrossComments: false
    ```

.clang-format
```
---
Language:        Cpp
# BasedOnStyle:  Google
AccessModifierOffset: -1
AlignAfterOpenBracket: Align
AlignArrayOfStructures: None
AlignConsecutiveMacros: None
# AlignConsecutiveAssignments: None
AlignConsecutiveAssignments:
  Enabled: true
  AcrossEmptyLines: true
  AcrossComments: false
AlignConsecutiveBitFields: None
AlignConsecutiveDeclarations: None
AlignEscapedNewlines: Left
AlignOperands:   Align
AlignTrailingComments: true
AllowAllArgumentsOnNextLine: true
AllowAllParametersOfDeclarationOnNextLine: true
AllowShortEnumsOnASingleLine: true
AllowShortBlocksOnASingleLine: Never
AllowShortCaseLabelsOnASingleLine: false
AllowShortFunctionsOnASingleLine: All
AllowShortLambdasOnASingleLine: All
AllowShortIfStatementsOnASingleLine: WithoutElse
AllowShortLoopsOnASingleLine: true
AlwaysBreakAfterDefinitionReturnType: None
AlwaysBreakAfterReturnType: None
AlwaysBreakBeforeMultilineStrings: true
AlwaysBreakTemplateDeclarations: Yes
AttributeMacros:
  - __capability
BinPackArguments: true
BinPackParameters: true
BraceWrapping:
  AfterCaseLabel:  false
  AfterClass:      false
  AfterControlStatement: Never
  AfterEnum:       false
  AfterFunction:   false
  AfterNamespace:  false
  AfterObjCDeclaration: false
  AfterStruct:     false
  AfterUnion:      false
  AfterExternBlock: false
  BeforeCatch:     false
  BeforeElse:      false
  BeforeLambdaBody: false
  BeforeWhile:     false
  IndentBraces:    false
  SplitEmptyFunction: true
  SplitEmptyRecord: true
  SplitEmptyNamespace: true
BreakBeforeBinaryOperators: None
BreakBeforeConceptDeclarations: true
BreakBeforeBraces: Attach
BreakBeforeInheritanceComma: false
BreakInheritanceList: BeforeColon
BreakBeforeTernaryOperators: true
BreakConstructorInitializersBeforeComma: false
BreakConstructorInitializers: BeforeColon
BreakAfterJavaFieldAnnotations: false
BreakStringLiterals: true
ColumnLimit:     80
CommentPragmas:  '^ IWYU pragma:'
QualifierAlignment: Leave
CompactNamespaces: false
ConstructorInitializerIndentWidth: 4
ContinuationIndentWidth: 4
Cpp11BracedListStyle: true
DeriveLineEnding: true
DerivePointerAlignment: true
DisableFormat:   false
EmptyLineAfterAccessModifier: Never
EmptyLineBeforeAccessModifier: LogicalBlock
ExperimentalAutoDetectBinPacking: false
PackConstructorInitializers: NextLine
BasedOnStyle:    ''
ConstructorInitializerAllOnOneLineOrOnePerLine: false
AllowAllConstructorInitializersOnNextLine: true
FixNamespaceComments: true
ForEachMacros:
  - foreach
  - Q_FOREACH
  - BOOST_FOREACH
IfMacros:
  - KJ_IF_MAYBE
IncludeBlocks:   Regroup
IncludeCategories:
  - Regex:           '^<ext/.*\.h>'
    Priority:        2
    SortPriority:    0
    CaseSensitive:   false
  - Regex:           '^<.*\.h>'
    Priority:        1
    SortPriority:    0
    CaseSensitive:   false
  - Regex:           '^<.*'
    Priority:        2
    SortPriority:    0
    CaseSensitive:   false
  - Regex:           '.*'
    Priority:        3
    SortPriority:    0
    CaseSensitive:   false
IncludeIsMainRegex: '([-_](test|unittest))?$'
IncludeIsMainSourceRegex: ''
IndentAccessModifiers: false
IndentCaseLabels: true
IndentCaseBlocks: false
IndentGotoLabels: true
IndentPPDirectives: None
IndentExternBlock: AfterExternBlock
IndentRequires:  false
IndentWidth:     2
IndentWrappedFunctionNames: false
InsertTrailingCommas: None
JavaScriptQuotes: Leave
JavaScriptWrapImports: true
KeepEmptyLinesAtTheStartOfBlocks: false
LambdaBodyIndentation: Signature
MacroBlockBegin: ''
MacroBlockEnd:   ''
MaxEmptyLinesToKeep: 1
NamespaceIndentation: None
ObjCBinPackProtocolList: Never
ObjCBlockIndentWidth: 2
ObjCBreakBeforeNestedBlockParam: true
ObjCSpaceAfterProperty: false
ObjCSpaceBeforeProtocolList: true
PenaltyBreakAssignment: 2
PenaltyBreakBeforeFirstCallParameter: 1
PenaltyBreakComment: 300
PenaltyBreakFirstLessLess: 120
PenaltyBreakOpenParenthesis: 0
PenaltyBreakString: 1000
PenaltyBreakTemplateDeclaration: 10
PenaltyExcessCharacter: 1000000
PenaltyReturnTypeOnItsOwnLine: 200
PenaltyIndentedWhitespace: 0
PointerAlignment: Left
PPIndentWidth:   -1
RawStringFormats:
  - Language:        Cpp
    Delimiters:
      - cc
      - CC
      - cpp
      - Cpp
      - CPP
      - 'c++'
      - 'C++'
    CanonicalDelimiter: ''
    BasedOnStyle:    google
  - Language:        TextProto
    Delimiters:
      - pb
      - PB
      - proto
      - PROTO
    EnclosingFunctions:
      - EqualsProto
      - EquivToProto
      - PARSE_PARTIAL_TEXT_PROTO
      - PARSE_TEST_PROTO
      - PARSE_TEXT_PROTO
      - ParseTextOrDie
      - ParseTextProtoOrDie
      - ParseTestProto
      - ParsePartialTestProto
    CanonicalDelimiter: pb
    BasedOnStyle:    google
ReferenceAlignment: Pointer
ReflowComments:  true
RemoveBracesLLVM: false
SeparateDefinitionBlocks: Leave
ShortNamespaceLines: 1
SortIncludes:    CaseSensitive
SortJavaStaticImport: Before
SortUsingDeclarations: true
SpaceAfterCStyleCast: false
SpaceAfterLogicalNot: false
SpaceAfterTemplateKeyword: true
SpaceBeforeAssignmentOperators: true
SpaceBeforeCaseColon: false
SpaceBeforeCpp11BracedList: false
SpaceBeforeCtorInitializerColon: true
SpaceBeforeInheritanceColon: true
SpaceBeforeParens: ControlStatements
SpaceBeforeParensOptions:
  AfterControlStatements: true
  AfterForeachMacros: true
  AfterFunctionDefinitionName: false
  AfterFunctionDeclarationName: false
  AfterIfMacros:   true
  AfterOverloadedOperator: false
  BeforeNonEmptyParentheses: false
SpaceAroundPointerQualifiers: Default
SpaceBeforeRangeBasedForLoopColon: true
SpaceInEmptyBlock: false
SpaceInEmptyParentheses: false
SpacesBeforeTrailingComments: 2
SpacesInAngles:  Never
SpacesInConditionalStatement: false
SpacesInContainerLiterals: true
SpacesInCStyleCastParentheses: false
SpacesInLineCommentPrefix:
  Minimum:         1
  Maximum:         -1
SpacesInParentheses: false
SpacesInSquareBrackets: false
SpaceBeforeSquareBrackets: false
BitFieldColonSpacing: Both
Standard:        Auto
StatementAttributeLikeMacros:
  - Q_EMIT
StatementMacros:
  - Q_UNUSED
  - QT_REQUIRE_VERSION
TabWidth:        8
UseCRLF:         false
UseTab:          Never
WhitespaceSensitiveMacros:
  - STRINGIZE
  - PP_STRINGIZE
  - BOOST_PP_STRINGIZE
  - NS_SWIFT_NAME
  - CF_SWIFT_NAME
...


```