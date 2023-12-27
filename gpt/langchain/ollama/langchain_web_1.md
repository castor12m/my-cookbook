https://revf.tistory.com/280

LangChain 에 대해 들어보셨나요?
LangChain 은 LLM 에서 구동되는 APP을 개발하기 위한 프레임워크입니다.
LangChain 에서 제공되는 라이브러리들을 사용하여 보다 쉽게 LLM 기술들을 활용할 수 있습니다.
 
현재는 javascript 와 python 으로 구분해서 관리되고 있습니다. 적용하려는 언어에 맞춰 사용하면 됩니다.
 
LangChain은 단순히 API 엑세스 하는 기능도 있지만 그 외에도 다양한 컴포넌트들이 준비되어 있으며, 아래와 같이 크게 두 가지 원칙에 기반하여 작성되었다고 합니다.
 
 
- Be data-aware : 언어 모델을 다른 데이터 원본에 연결합니다.- Be agentic : 언어 모델이 해당 환경과 상호 작용할 수 있도록 허용합니다.
 
 
LangChain 사이트에서는 7개 카테고리의 컴포넌트들과 다양한 사용 사례들을 소개하고 있습니다.
 
 
목차
1. Schema
  1.1 채팅 메세지
  1.1 문서
2. Models
  2.1 언어 모델 (LLMs)  2.2 채팅 모델
  2.3 텍스트 임베딩 모델
3. Prompt
  3.1 Prompt
  3.2 Prompt Template
  3.3 예제 선택기 (Example Selector)
  3.4 출력 파서 (Output Parser)
4. Index
  4.1 문서 로더 (Document Loader)
  4.2 텍스트 분할기 (Text Splitters)
  4.3 백터 스토어 (Vector Stores)
  4.4 검색기 (Retrievers)
5. Memory
  5.1 채팅 메세지 History
6. Chain
  6.1 간단한 Sequential Chain
  6.2 요약 Chain
7. Agents
  7.1 Tools
 
 
 
1부. 컴포넌트
LangChain 에서는 LLM 작업에 필요한 기능을 추상화된 컴포넌트로 제공합니다.
Schema, Model, Prompt, Index, Memory, Chain, Agent 이렇게 7가지로 분류된 컴포넌트를 제공합니다.
 


 
이 글에서는 주요 컴포넌트들을 예제와 함께 살펴보겠습니다. 예제는 python 을 기준으로 합니다.
 
(준비) 환경설정
1. openai, langchain SDK 설치
$ pip install openai
$ pip install langchain
 
2. OpenAI API key
2-1) ChatOpenAI 생성 시
chat = ChatOpenAI(openai_api_key=openai_api_key)
 
2-2) 환경 변수 설정
export OPENAI_API_KEY="SK-..."
 
2-3) jupyter notebook 사용 시, 환경 변수 설정
import os
os.environ["OPENAI_API_KEY"] = "..."
 
 
1. Schema
1.1 채팅 메세지
LLM과 상호 작용하는 가장 기본이 되는 인터페이스입니다.
현재는 System, Human, AI 3종류의 사용자를 지원합니다.
 
- System : AI에게 해야 할 일을 알려주는 배경 컨텍스트- Human : 사용자 메세지- AI : AI가 응답한 내용을 보여주는 상세 메세지
 
예제1
from langchain.chat_models import ChatOpenAI
from langchain.schema import HumanMessage, SystemMessage, AIMessage

chat = ChatOpenAI(temperature=.7)
chat(
  [  
    SystemMessage(content="당신은 사용자가 짧은 문장으로 무엇을 먹을지 알아낼 수 있도록 도와주는 멋진 AI 봇입니다."),
    HumanMessage(content="토마토 좋아하는데, 뭘 먹어야 하나요??")
  ]
)
AIMessage(content='신선한 바질과 모짜렐라 치즈를 곁들인 토마토 샐러드를 만들어 보세요.', additional_kwargs={})
 
예제2) AI 의 응답을 추가한 채팅 기록을 전달하여 컨텍스트를 유지할 수 있습니다.
chat(
  [ 
    SystemMessage(content="당신은 사용자가 짧은 문장으로 어디로 여행할지 알아낼 수 있도록 도와주는 멋진 AI 봇입니다."),
    HumanMessage(content="해변이 좋은데 어디로 가면 좋을까요?"), 
    AIMessage(content="프랑스 니스에 가야 해요"), 
    HumanMessage(content="그곳에 가면 또 뭘 하면 좋을까요?")
  ]
)

AIMessage(content='니스에 머무는 동안 매력적인 구시가지를 둘러보고, 유명한 프롬나
드 데 앵글레를 방문하고, 맛있는 프랑스 요리를 맛볼 수도 있습니다.', 
additional_kwargs={})
 
예제3) 응답을 스트리밍 하는 방법 (jupyter notebook)
from langchain.callbacks.base import CallbackManager
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler

chat = ChatOpenAI(streaming=True, callback_manager=CallbackManager([StreamingStdOutCallbackHandler()]), verbose=True, temperature=0)
resp = chat([HumanMessage(content="Write me a song about sparkling water.")])
 
 
1.2 문서
텍스트와 메타데이터를 담고있는 객체입니다.
from langchain.schema import Document

Document(page_content="이것은 내 문서입니다. 다른 곳에서 수집한 텍스트로 가득 차 있습니다.",
metadata={
    'my_document_id' : 234234,
    'my_document_source' : "The LangChain Papers",
    'my_document_create_time' : 1680013019
})

Document(
  page_content="이 문서는 제 문서입니다. 다른 곳에서 수집한 텍스트로 가득합니다.", 
  lookup_str='',
  metadata={
    'my_document_id': 234234, 
    'my_document_source': 'The LangChain Papers', 
    'my_document_create_time': 1680013019
  }, 
  lookup_index=0
)
 
예제1) PyPDFLoader - PDF to Document
from langchain.document_loaders import PyPDFLoader

loader = PyPDFLoader("example_data/layout-parser-paper.pdf")
pages = loader.load_and_split()
 
 
2. Models
2.1 언어 모델 (LLMs)
텍스트 문자열을 입력하고, 텍스트 문자열을 출력하는 모델입니다.
LangChain 은 LLM 공급자가 아니며, 인터페이스만 제공합니다.
 
예제1) OpenAI
from langchain.llms import OpenAI
from langchain import PromptTemplate, LLMChain

template = """Question: {question}
Answer: Let's think step by step."""

prompt = PromptTemplate(template=template, input_variables=["question"])

llm = OpenAI()

llm_chain = LLMChain(prompt=prompt, llm=llm)

question = "저스틴 비버가 태어난 해에 슈퍼볼에서 우승한 NFL 팀?"

llm_chain.run(question)

'저스틴 비버는 1994년에 태어났으므로 그 해에 슈퍼볼에서 우승한 NFL 팀은 댈러스 카우보이즈입니다.'
 
 
 
2.2 채팅 모델
채팅 모델은 언어 모델의 변형으로, 내부적으로는 언어 모델을 사용하지만 노출되는 인터페이스는 약간 다릅니다. 현재 보다 나은 추상화를 위해서 지속적으로 개선이 이뤄지고 있습니다.
 
예제1) Simple Chat
from langchain.chat_models import ChatOpenAI
from langchain.schema import HumanMessage, SystemMessage, AIMessage

chat = ChatOpenAI()
chat(
  [
    SystemMessage(content="사용자가 무슨 말을 하든 농담만 하는 도움이 되지 않는 AI 봇입니다."),
    HumanMessage(content="뉴욕에 가고 싶은데 어떻게 해야 하나요?")
  ]
)

AIMessage(content="걸을 수도 있지만 시간이 많지 않다면 추천하지 않습니다. 팔을 세게 펄럭이며 날아갈 수 있는지 확인해보는 건 어떨까요?", additional_kwargs={})
 
 
예제2) 템플릿 이용
template="당신은 {input_language}를 {output_language}로 번역하는 유용한 도우미입니다."
system_message_prompt = SystemMessagePromptTemplate.from_template(template)
human_template="{text}"
human_message_prompt = HumanMessagePromptTemplate.from_template(human_template)

chat_prompt = ChatPromptTemplate.from_messages([system_message_prompt, human_message_prompt])

# 형식이 지정된 메시지에서 채팅 완료 가져오기
chat(
  chat_prompt.format_prompt(
    input_language="English", 
    output_language="French", 
    text="I love programming."
  ).to_messages()
)

AIMessage(content="J'adore la programmation.", additional_kwargs={})
 
 
 
2.3 텍스트 임베딩 모델
텍스트를 벡터 (텍스트의 의미 를 담고 있는 일련의 숫자) 로 변경합니다. 주로 두 텍스트를 함께 비교할 때 사용합니다.
 
예제)
from langchain.embeddings import OpenAIEmbeddings

embeddings = OpenAIEmbeddings()
text = "안녕하세요! 해변에 갈 시간입니다"
text_embedding = embeddings.embed_query(text)

print (f"임베딩 길이 : {len(text_embedding)}")
print (f"샘플은 다움과 같습니다 : {text_embedding[:5]}...")

임베딩 길이 : 1536
샘플은 다움과 같습니다: [-0.00020583387231454253, -0.003205398330464959, -
0.0008301587076857686, -0.01946892775595188, -0.015162716619670391]...
 
예제2) 아래와 같이 다른 모델을 지정할 수 있습니다.
from langchain.embeddings.openai import OpenAIEmbeddings

embeddings = OpenAIEmbeddings(model_name="ada")
text = "This is a test document."
query_result = embeddings.embed_query(text)
doc_result = embeddings.embed_documents([text])
 
 
 
3. Prompt
모델을 프로그래밍 하는 새로운 방법은 프롬프트를 사용하는 것입니다. 다른 데이터 유형 (이미지, 오디오) 등을 고려하여 추상화 작업이 진행되고 있으며, 현재는 텍스트를 처리합니다.
 
3.1 Prompt
 
prompt = """
Today is Monday, tomorrow is Wednesday.
What is wrong with that statement?
"""

llm(prompt)
'\nThe statement is incorrect; tomorrow is Tuesday, not Wednesday.'
 
 
3.2 Prompt Template
사용자로부터 일련의 매개변수를 가져와 프롬프트를 생성할 수 있는 텍스트 문자열이 포함되어 있습니다.
 
예제)
from langchain import PromptTemplate

template = """
신생 회사의 네이밍 컨설턴트 역할을 해 주셨으면 합니다.
다음은 좋은 회사 이름의 몇 가지 예입니다:
- 검색 엔진, Google 
- 소셜 미디어, Facebook 
- 동영상 공유, YouTube

이름은 짧고 눈에 잘 띄며 기억하기 쉬워야 합니다.
{product}을 만드는 회사의 좋은 이름은 무엇인가요?
"""

prompt = PromptTemplate(
    input_variables=["product"],
    template=template,
)
 
 
예제2) PromptTemplate 클래스 이용
from langchain import PromptTemplate

# 입력 변수가 없는 프롬프트 예제
no_input_prompt = PromptTemplate(input_variables=[], template="Tell me a joke.")
no_input_prompt.format()
# -> "Tell me a joke."

# 하나의 입력 변수가 있는 예제 프롬프트
one_input_prompt = PromptTemplate(input_variables=["adjective"], template="Tell me a {adjective} joke.")
one_input_prompt.format(adjective="funny")
# -> "Tell me a funny joke."

# 여러 입력 변수가 있는 프롬프트 예제
multiple_input_prompt = PromptTemplate(
    input_variables=["adjective", "content"], 
    template="Tell me a {adjective} joke about {content}."
)
multiple_input_prompt.format(adjective="funny", content="chickens")
# -> "Tell me a funny joke about chickens."
 
 
3.3 예제 선택기 (Example Selector)
프롬프트에서 상황에 맞는 정보를 동적으로 배치할 수 있는 예제 중에서 쉽게 선택할 수 있는 방법을 제공합니다.
 
예제)
from langchain.prompts.example_selector import
SemanticSimilarityExampleSelector
from langchain.vectorstores import FAISS
from langchain.embeddings import OpenAIEmbeddings
from langchain.prompts import FewShotPromptTemplate, PromptTemplate
from langchain.llms import OpenAI

llm = OpenAI(model_name="text-davinci-003")
example_prompt = PromptTemplate(
  input_variables=["input", "output"],
  template="Example Input: {input}\nExample Output: {output}",
)

# 명사가 발견되는 위치의 예
examples = [
  {"input": "pirate", "output": "ship"},
  {"input": "pilot", "output": "plane"},
  {"input": "driver", "output": "car"},
  {"input": "tree", "output": "ground"},
  {"input": "bird", "output": "nest"},
]

# SemanticSimilarityExampleSelector는 의미론적 의미에 따라 입력과 유사한 예제를 선택합니다.
example_selector = SemanticSimilarityExampleSelector.from_examples(
  examples,
  OpenAIEmbeddings(openai_api_key=openai_api_key),  # 의미적 유사성을 측정하는 데 사용되는 임베딩을 생성하는 데 사용되는 임베딩 클래스입니다.
  FAISS,  # 임베딩을 저장하고 유사성 검색을 수행하는 데 사용되는 VectorStore 클래스입니다.
  k=2 # 생성할 예제 개수입니다.
)

similar_prompt = FewShotPromptTemplate(
  example_selector=example_selector,  # 예제 선택에 도움이 되는 개체
  example_prompt=example_prompt,  # 프롬프트
  prefix="Give the location an item is usually found in",  # 프롬프트의 상단과 하단에 추가되는 사용자 지정 사항
  suffix="Input: {noun}\nOutput:",
  input_variables=["noun"],  # 프롬프트가 수신할 입력 항목
)

# 명사를 선택
my_noun = "student"

print(similar_prompt.format(noun=my_noun))

항목이 일반적으로 발견되는 위치를 지정합니다.
Example Input: driver
Example Output: car

Example Input: pilot
Example Output: plane

Input: student
Output:

llm(similar_prompt.format(noun=my_noun))
' classroom'

 
 
 
3.4 출력 파서 (Output Parser)
일반적으로 LLM은 텍스트를 출력합니다. 하지만 보다 구조화된 정보를 얻고 싶을 수 있습니다.
이런 경우 출력 파서를 이용하여 LLM 응답을 구조화할 수 있습니다.
출력 파서는 두 가지 컨셉을 갖고 있습니다.
 
- Format instructions : 원하는 결과의 포멧을 지정하여 LLM에 알려줍니다.- Parser : 원하는 텍스트 출력 구조 (보통 json) 을 추출하도록 합니다.
 
예제1) CommaSeparatedListOutputParser
from langchain.output_parsers import CommaSeparatedListOutputParser
from langchain.prompts import PromptTemplate, ChatPromptTemplate, HumanMessagePromptTemplate
from langchain.llms import OpenAI
from langchain.chat_models import ChatOpenAI

output_parser = CommaSeparatedListOutputParser()

format_instructions = output_parser.get_format_instructions()
prompt = PromptTemplate(
    template="List five {subject}.\n{format_instructions}",
    input_variables=["subject"],
    partial_variables={"format_instructions": format_instructions}
)

model = OpenAI(temperature=0)

_input = prompt.format(subject="ice cream flavors")
output = model(_input)

output_parser.parse(output)

['Vanilla',
 'Chocolate',
 'Strawberry',
 'Mint Chocolate Chip',
 'Cookies and Cream']
 
 
예제2) 사용자 입력 텍스트 교정
from langchain.output_parsers import StructuredOutputParser, ResponseSchema
from langchain.prompts import ChatPromptTemplate, HumanMessagePromptTemplate
from langchain.llms import OpenAI

llm = OpenAI(model_name="text-davinci-003")

# 응답을 어떻게 구성하고 싶은지 입력합니다. 이것은 기본적으로 멋진 프롬프트 템플릿입니다.
response_schemas = [
  ResponseSchema(name="bad_string", description="This a poorly formatted user input string"),
  ResponseSchema(name="good_string", description="This is your response, a reformatted response")
]

# 출력 구문 분석 방법
output_parser = StructuredOutputParser.from_response_schemas(response_schemas)

# 서식을 지정하려면 생성한 프롬프트 템플릿을 참조하세요.
format_instructions = output_parser.get_format_instructions()
print (format_instructions)

출력은 다음 스키마 형식의 마크다운 코드 스니펫이어야 합니다.:
'''json
{
"bad_string": string // This a poorly formatted user input
string
"good_string": string // This is your response, a reformatted
response
}
'''
template = """
You will be given a poorly formatted string from a user.
Reformat it and make sure all the words are spelled correctly
{format_instructions}
% USER INPUT:
{user_input}
YOUR RESPONSE:
"""
prompt = PromptTemplate(
  input_variables=["user_input"], partial_variables={"format_instructions": format_instructions},
  template=template
)

promptValue = prompt.format(user_input="welcom to califonya!")
print(promptValue)

사용자로부터 잘못된 형식의 문자열을 받게 됩니다..
형식을 다시 지정하고 모든 단어의 철자가 올바른지 확인합니다. 출력은 다음 스키마 형식의 마크다운 코드 스니펫이어야 합니다.:

{
"bad_string": string // This a poorly formatted user input
string
"good_string": string // This is your response, a reformatted
response
}

% USER INPUT:
welcom to califonya!
YOUR RESPONSE:
llm_output = llm(promptValue)
llm_output
'`json\n{\n\t"bad_string": "welcom to califonya!",\n\t"good_string":
"Welcome to California!"\n}\n`' 

output_parser.parse(llm_output)
{
'bad_string': 'welcom to califonya!', 
'good_string': 'Welcome to California!'
}
 
 
 
4. Index
Index는 LLM 이 다른 소스에서 문서를 쉽게 가져올 수 있도록 하는 방법입니다. 문서 작업을 위한 유틸리티 함수, 다양한 유형의 Index, 그리고 이러한 Index 를 체이닝하여 사용합니다.
 
이제 외부 리소스 가져오는 것을 LangChain을 이용하여 아주 간단히 해결해보세요.
 
4.1 문서 로더 (Document Loader)
CSV, HTML, 메일, Image, PDF, PPT, Site, Youtube 등 다양한 소스에서 Document 를 작성할 수 있는 Loader 가 제공되고 있습니다. 전체 목록은 아래 링크에서 참고해주세요.
 
Document Loader 전체 목록
 
예제1) 댓글 가져오기
from langchain.document_loaders import HNLoader

loader = HNLoader("https://news.ycombinator.com/item?id=34422627")
data = loader.load()

print (f"Found {len(data)} comments")
print (f"Here's a sample:\n\n{''.join([x.page_content[:150] for x in data[:2]])}")
 
 
예제2) 사이트 로더
from langchain.document_loaders import UnstructuredURLLoader

urls = [
    "https://www.understandingwar.org/backgrounder/russian-offensive-campaign-assessment-february-8-2023",
    "https://www.understandingwar.org/backgrounder/russian-offensive-campaign-assessment-february-9-2023"
]
loader = UnstructuredURLLoader(urls=urls)
data = loader.load()
 
 
예제3) 유튜브 자막 불러오기
from langchain.document_loaders import YoutubeLoader

!pip install youtube-transcript-api
loader = YoutubeLoader.from_youtube_url("유튜브URL", add_video_info=True)
loader.load()
 
 
4.2 텍스트 분할기 (Text Splitters)
책과 같이 문서가 너무 길어서 LLM 에 한번에 입력이 어려운 경우, 문서를 잘게 쪼개야 합니다. 이 경우 텍스트 분할기를 이용하여 도움을 받을 수 있습니다.
 
예제1) OpenAI의 오픈소스인 tiktoken 을 사용하여 사용된 토큰을 추정한 분할
with open('../../../state_of_the_union.txt') as f:
    state_of_the_union = f.read()

from langchain.text_splitter import CharacterTextSplitter

text_splitter = CharacterTextSplitter.from_tiktoken_encoder(chunk_size=100, chunk_overlap=0)
texts = text_splitter.split_text(state_of_the_union)

print(texts[0])
 
 
예제2) 마크다운 텍스트 분할기
from langchain.text_splitter import MarkdownTextSplitter

markdown_text = """
🦜️🔗 LangChain

⚡ Building applications with LLMs through composability ⚡

Quick Install

Hopefully this code block isn't split
pip install langchain

As an open source project in a rapidly developing field, we are extremely open to contributions.
"""
markdown_splitter = MarkdownTextSplitter(chunk_size=100, chunk_overlap=0)

docs = markdown_splitter.create_documents([markdown_text])
 
 
4.3 벡터 스토어 (Vector Stores)
벡터 (Vector)를 저장하는 데이터베이스와 관련된 기능입니다. 벡터 저장소 작업의 핵심 부분은 일반적으로 임베딩을 통해 생성되는 벡터를 만드는 것입니다.
 
예제) Vector 저장
from langchain.document_loaders import TextLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.vectorstores import FAISS
from langchain.embeddings import OpenAIEmbeddings

loader = TextLoader('data/PaulGrahamEssays/worked.txt')
documents = loader.load()

# 스플리터 준비하기
text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=50)

# 문서를 텍스트로 분할
texts = text_splitter.split_documents(documents)

# 임베딩 엔진 준비하기
embeddings = OpenAIEmbeddings()

print (f"You have {len(texts)} documents")
You have 78 documents

embedding_list = embeddings.embed_documents([text.page_content for text in texts])

print (f"You have {len(embedding_list)} embeddings")
print (f"Here's a sample of one: {embedding_list[0][:3]}...")
 
 
4.4 검색기 (Retrievers)
리트리버 인터페이스는 문서를 쉽게 결합할 수 있는 일반 인터페이스입니다.
현재 ChatGPT Plugin Retriever 와 VectorStore Retriever 가 있습니다.
 
예제) VectorStore Retriever
from langchain.document_loaders import TextLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.vectorstores import FAISS
from langchain.embeddings import OpenAIEmbeddings

loader = TextLoader('data/PaulGrahamEssays/worked.txt')
documents = loader.load()

#스플리터 준비하기
text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000,chunk_overlap=50)

# 문서를 텍스트로 분할
texts = text_splitter.split_documents(documents)

# 임베딩 엔진 준비하기
embeddings = OpenAIEmbeddings(openai_api_key=openai_api_key)

# 텍스트 삽입
db = FAISS.from_documents(texts, embeddings)

# 리트리버를 초기화하세요. 문서 1건만 반환 요청하기
retriever = db.as_retriever()

retriever

VectorStoreRetriever(vectorstore=<langchain.vectorstores.faiss.FAISS
object at 0x7fb81007a9d0>, search_type='similarity', search_kwargs={})
docs = retriever.get_relevant_documents("what types of things did the
author want to build?")

print("\n\n".join([x.page_content[:200] for x in docs[:2]]))
 
 
 
5. Memory
기본적으로 체인과 에이전트는 상태를 저장하지 않습니다. 즉, 쿼리가 수행되면 독립적으로 처리합니다.
Memory 컴포넌트는 LLM 이 정보를 기억할 수 있도록 지원합니다. 간단하게는 과거 채팅 히스토리를 기억할 수 도 있고, 더 복잡한 정보를 검색 할 수도 있습니다.
 
Memory 컴포넌트 목록
 
5.1 채팅 메세지 History
ChatMessageHisotry 클래스는 Human, AI 메세지를 저장한 다음 모두 가져올 수 있습니다.
 
예제)
from langchain.memory import ChatMessageHistory
from langchain.chat_models import ChatOpenAI

chat = ChatOpenAI()

history = ChatMessageHistory()

history.add_ai_message("hi!")
history.add_user_message("what is the capital of france?")

history.messages
 
 
 
6. Chain
다양한 LLM 호출하는데 사용되는 컴포넌트입니다.
 
6.1 간단한 Sequential Chains
LLMChain 을 이용하여 LLM 출력을 다른 LMM의 입력으로 사용할 수 있도록 합니다.
 
예제) SimpleSequentialChain
from langchain.llms import OpenAI
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate
from langchain.chains import SimpleSequentialChain

llm = OpenAI(temperature=1)
template = """
당신의 임무는 사용자가 제안하는 지역의 클래식 요리를 만드는 것입니다.
% USER LOCATION
{user_location}
YOUR RESPONSE:
"""

prompt_template = PromptTemplate(input_variables=["user_location"], template=template)

# 내 '위치' 체인을 보관합니다.
location_chain = LLMChain(llm=llm, prompt=prompt_template)
template = """
식사가 주어졌을 때, 집에서 해당 요리를 만드는 방법에 대한 짧고 간단한 레시피를 알려주세요.
% MEAL
{user_meal}
YOUR RESPONSE:
"""

prompt_template = PromptTemplate(input_variables=["user_meal"], template=template)

# 내 '식사' 체인 보관
meal_chain = LLMChain(llm=llm, prompt=prompt_template)

overall_chain = SimpleSequentialChain(chains=[location_chain, meal_chain], verbose=True)

review = overall_chain.run("로마")
 
 
6.2. 요약 체인
한번에 처리가 어려운 문서를 나눠서 요약할 수 있습니다.
 
예제) map\_reduce Chain
from langchain.chains.summarize import load_summarize_chain
from langchain.document_loaders import TextLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter

loader = TextLoader('data/PaulGrahamEssays/disc.txt')
documents = loader.load()

# 스플리터 준비하기
text_splitter = RecursiveCharacterTextSplitter(chunk_size=700, chunk_overlap=50)

# 문서를 텍스트로 분할
texts = text_splitter.split_documents(documents)

map-reduce 를 통해 긴 전체 문서를 요약합니다.
chain = load_summarize_chain(llm, chain_type="map_reduce", verbose=True)
chain.run(texts)
 
 
 
7. Agents
사용자 입력에 따라 Agent는 여러 도구 중 호출할 수 있는 경우 도구를 결정할 수 있습니다.
Agnet는 LLM 을 사용하여 수행핼 작업과 순서를 결정합니다. 이 과정에서 도구를 사용하여 출력을 관찰하거나 사용자에게 반환할 수 있습니다.
 
7.1 Tools
구글 검색, 데이터베이스 조회, Python REPL 등을 이용하여 현재 문자열을 입력받아 결과값을 출력합니다. OpenAI Plugins 과 유사한 영역입니다.
 
예제) 구글 검색
# 구글 API 환경설정
import os
os.environ["GOOGLE_CSE_ID"] = ""
os.environ["GOOGLE_API_KEY"] = ""


from langchain.utilities import GoogleSearchAPIWrapper

search = GoogleSearchAPIWrapper()
search.run("Obama's first name?")
 
 
여기까지 LangChain 에 대해서 가볍게? 살펴보았습니다.
여기에는 미처 정리하지 못했지만 유용한 것들이 있을 수 있습니다.
저도 LangChain 을 계속 써보면서 기여할 부분이 있는지 살펴보고자 합니다.
그리고 만약 유용하게 사용중인 컴포넌트가 있다면 사용 예제와 함께 공유해주시는 것도 좋겠네요. ^^
 
 
참고문서

 

🦜️🔗 LangChain | 🦜️🔗 LangChain
LangChain is a framework for developing applications powered by language models.
docs.langchain.com


 

 

GitHub - gkamradt/langchain-tutorials: Overview and tutorial of the LangChain Library
Overview and tutorial of the LangChain Library. Contribute to gkamradt/langchain-tutorials development by creating an account on GitHub.
github.com


 
출처: https://revf.tistory.com/280 [RevFactory 프로젝트 - 세상을 더 이롭게 바꾸는 작업:티스토리]