https://littlefoxdiary.tistory.com/114



LangChain 모듈
LangChain은 이름 그대로 여러 구성 요소를 결합하여 애플리케이션을 만들 수 있는 체인을 제공한다.

아래와 같이 최소한의 모듈부터 시작해서 복잡한 모듈까지, 확장 가능한 인터페이스 및 외부 소스와의 통합을 제공한다.

 

● Model I/O - 언어모델과 인터페이스

● Data connection - 애플리케이션 특화된 데이터와 인터페이스

● Chains - 호출(Call) 시퀀스를 구성함

● Agents - 체인이 high-lebel의 지침에 따라 사용할 도구를 선택하도록 함

● Memory - 체인의 실행 사이에 애플리케이션의 상태를 유지함

● Callbacks - 체인의 중간 단계를 기록하거나 스트리밍함

 

 

 

LangChain 설치 및 환경 설정하기
pip 설치를 통해 파이썬에서 LangChain을 활용할 수 있다. 쏘이지˚◡˚

 

pip install langchain
 

LangChain에서 OpenAI API 연결하기
OpenAI API key를 발급받은 후, a) 환경변수를 export하거나

 

export OPENAI_API_KEY="..."
 

b) OpenAI 객체를 호출할 때 openai api key를 전달하는 방식으로 Langchain에서 OpenAI 언어모델을 사용할 수 있다.

 

from langchain.llms import OpenAI

llm = OpenAI(openai_api_key="...")
LLM Chain 컴포넌트 이해하기
LangChain 어플리케이션에서 가장 핵심이 되는 블록은 LLMChain이다. 

 

체인에서는 아래의 3가지를 조합한다:

1) LLM - 언어모델은 핵심적인 추론 엔진으로, 성공적으로 LangChain을 활용하기 위해서는 각각 다른 언어모델의 유형과 사용방법을 이해하는 것이 중요하다. 

2) Prompt Templates - 프롬프트 템플릿에서는 언어모델에 전달하는 지시사항(instruction)을 관리한다. 이는 언어모델의 출력 결과와 직결되기 때문에, 프롬프트를 작성하는 방법과 전략이 매우 중요하다.

3) Output Parsers - 출력 파서는 LLM이 리턴하는 결과를 사용 가능한 형식으로 전환하여 아웃풋  다운스트림에서 사용할 수 있도록 한다.

 

❶ LLM 호출하기
언어모델에는 두 가지 종류가 있는데, LangChain에서는 이를 아래와 같이 구분한다:

   a) LLMs: string(문자열)을 인풋으로 받아 string을 아웃풋으로 리턴하는 언어모델 (TextDavinci와 같은 일반적은 언어모델)

   b) ChatModels: 메시지( ChatMessage 객체)의 리스트를 인풋으로 받아 메시지를 리턴하는 언어모델 (ChatGPT 등)

 

여기서 ChatModel에서 사용하는 ChatMessage는 두 개의 컴포넌트로 이루어져 있다:

content : 메시지의 내용
role : 해당 메시지의 발신원이 되는 개체의 역할을 정의
HumanMessage : 사람 혹은 사용자의 메시지
AIMessage : AI 혹은 assistant의 메시지
SystemMessage : 시스템의 메시지
FunctionMessage : 함수 호출에 따른 메시지
위의 객체에 딱 맞는 역할이 없다면, 직접 클래스를 상속하여 role을 정의할 수 있다.
 

LangChain은 두 가지 방법으로 LLM과 ChatModel이라는 표준 인터페이스를 활용하도록 한다:

predict : string을 인풋으로 받아 string을 아웃풋으로 리턴
predict_messages : 메시지의 리스트를 인풋으로 받아 메시지를 리턴