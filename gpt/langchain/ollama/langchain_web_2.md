https://hipster4020.tistory.com/189

LangChain은 LLM에서 구동되는 APP을 개발하기 위한 프레임워크입니다.
LangChain에서 제공되는 라이브러리를 활용하여 쉽게 LLM 기술들을 활용할 수 있습니다.
현재는 Javascript, Python으로 구분해서 관리되고 있고 Python으로 설명드리겠습니다.
 
 
LangChain은 크게 두 가지 원칙에 기반하여 작성되었습니다.

Be data-aware : 언어 모델을 다른 데이터 원본에 연결합니다.
Be agentic : 언어 모델이 해당 환경과 상호 작용할 수 있도록 허용합니다.
예제를 통해 사용법에 대해 알아보겠습니다.
 
 

0. 패키지 설치
!pip install openai
!pip install langchain
llm 모델 openai, langchain 관련

!pip install google-search-results
!pip install wikipedia
!pip install faiss-cpu # 오픈소스 벡터DB (Facebook, MIT license)
!pip install sentence_transformers # HuggingFace Embedding 사용 위해서 필요
!pip install tiktoken # Summarization 할때 필요
구글 검색, 위키피디아, VectorStore, Huggingface Embedding 관련
 
 

1. 기본 프롬프트
기본적인 프롬프트를 사용하는 방식입니다.
 
text-davinci-003

from langchain.llms import OpenAI

llm = OpenAI(model_name='text-davinci-003', temperature=0.9)
llm('1980년대 메탈 음악 5곡 추천해줘.')
 
1. Poison - Every Rose Has Its Thorn
2. Europe - The Final Countdown
3. Bon Jovi - Wanted Dead or Alive
4. Guns N' Roses - Sweet Child O' Mine
5. Metallica - Nothing Else Matters
 
GPT4 LLM

from langchain.chat_models import ChatOpenAI
from langchain.schema import (
    AIMessage,
    HumanMessage,
    SystemMessage
)

chat = ChatOpenAI(model_name='gpt-4', temperature=0.9)
sys = SystemMessage(content="당신은 음악 추천을 해주는 전문 AI입니다.")
msg = HumanMessage(content='1980년대 메탈 음악 5곡 추천해줘.')

aimsg = chat([sys, msg])
aimsg.content
1980년대 메탈 음악의 명곡들을 추천해 드리겠습니다. 이 곡들은 당시와 지금도 많은 메탈 음악 팬들에게 사랑받고 있습니다.

1. Metallica - "Master of Puppets" (1986)
2. Iron Maiden - "The Trooper" (1983)
3. Guns N' Roses - "Welcome to the Jungle" (1987)
4. Black Sabbath - "Heaven and Hell" (1980)
5. Megadeth - "Peace Sells" (1986)

이 곡들은 1980년대 메탈 음악을 대표하며, 고유한 사운드와 파워풀한 기타 리프로 인해 세계적인 인기를 얻었습니다. 각 곡들의 라이브 영상이나 스튜디오 버전을 감상해 보시면 잊지 못할 메탈 음악의 경험을 누리실 수 있을 것입니다.
 
 

2. 프롬프트 템플릿
Prompt Templete & Chain
미리 어떤 템플릿을 만들어 프롬프트에 채우는 방식입니다.
아래 예제에서는 상품에 해당하는 변수를 'AI 여행 추천 서비스'로 변경하는 템플릿입니다.

from langchain.prompts import PromptTemplate

prompt = PromptTemplate(
    input_variables=["상품"],
    template="{상품} 만드는 회사 이름 추천해줘. 기억에 남는 한글 이름으로",
)

prompt.format(상품="AI 여행 추천 서비스") # 변수가 여러 개 일 때, 지정
AI 여행 추천 서비스 만드는 회사 이름 추천해 줘. 기억에 남는 한글 이름으로
 

from langchain.chains import LLMChain

chain = LLMChain(llm=chat, prompt=prompt)

chain.run(상품="AI 여행 추천 서비스")
여행지능
 
 
ChatPromptTemplete & Chain
위 프롬프트 템플릿과 동일하지만 더 많은 기능을 사용할 수 있습니다.
system prompt, user prompt를 구분해서 사용할 수 있으며, input에 대한 언어와 output에 대한 언어를 설정할 수 있습니다.
run 할 때는 input_language, output_language, text 3개의 값을 넘깁니다.

from langchain.chat_models import ChatOpenAI
from langchain.prompts.chat import (
    ChatPromptTemplate,
    SystemMessagePromptTemplate,
    HumanMessagePromptTemplate,
)

chat = ChatOpenAI(temperature=0) # 번역을 항상 같게 하기 위해서 설정

template="You are a helpful assisstant that tranlates {input_language} to {output_language}."
system_message_prompt = SystemMessagePromptTemplate.from_template(template)
human_template="{text}"
human_message_prompt = HumanMessagePromptTemplate.from_template(human_template)

chat_prompt = ChatPromptTemplate.from_messages([system_message_prompt, human_message_prompt])


chatchain = LLMChain(llm=chat, prompt=chat_prompt)
chatchain.run(input_language="English", output_language="Korean", text="I love programming.")
저는 프로그래밍을 좋아합니다.
 
 

3. Agents and Tools
Tool로 구글, 위키피디아 검색, 디비 조회, Python 실행/계산 등의 작업을 할 수 있습니다.

Agents에서는 LLM을 이용하여 어떤 툴을 어떤 순서로 실행할지 결정하는 역할을 합니다.

 

from langchain.agents import load_tools
from langchain.agents import initialize_agent
from langchain.agents import AgentType

# tools = load_tools(["serpapi", "llm-math"], llm=chat) # serpapi 사용하면 구글 검색
tools = load_tools(["wikipedia", "llm-math"], llm=chat)

agent = initialize_agent(tools, llm=chat, agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION, verbose=True) # verbose : 중간 과정 출력

agent.run("페이스북 창업자는 누구인지? 그의 현재(2023년) 나이를 제곱하면?")
Mark Zuckerberg is the founder of Facebook and his age squared in 2023 is 1521.

agent.tools
[WikipediaQueryRun(name='Wikipedia', description='A wrapper around Wikipedia. Useful for when you need to answer general questions about people, places, companies, facts, historical events, or other subjects. Input should be a search query.', args_schema=None, return_direct=False, verbose=False, callbacks=None, callback_manager=None, api_wrapper=WikipediaAPIWrapper(wiki_client=<module 'wikipedia' from '/usr/local/lib/python3.10/dist-packages/wikipedia/__init__.py'>, top_k_results=3, lang='en', load_all_available_meta=False)), ...

print(agent.tools[0].description)
print(agent.tools[1].description)
A wrapper around Wikipedia. Useful for when you need to answer general questions about people, places, companies, facts, historical events, or other subjects. Input should be a search query. Useful for when you need to answer questions about math.
위와 같이 Description에 있는 순서로 정해서 실행.
 
 

4. Memory
ChatAPI는 stateless이기 때문에 그전에 대한 기억을 하기 위한 메모리 저장 기능입니다.
ConversationChain을 사용하여 predict를 지속적으로 실행해도 Conversation BufferMemory를 통해 이전 대화에 대한 기억을 지니고 있습니다.

from langchain import ConversationChain

conversation = ConversationChain(llm=chat, verbose=True)
conversation.predict(input="인공지능에서 Transformer가 뭐야?")
Transformer는 자연어 처리 분야에서 매우 유용한 딥러닝 모델 중 하나입니다. 이 모델은 기계 번역, 질의응답, 요약 등 다양한 자연어 처리 작업에서 사용됩니다. Transformer는 기존의 RNN, LSTM 등의 모델보다 더욱 빠르고 정확한 결과를 제공합니다. 이 모델은 구글에서 개발되었으며, 현재까지도 많은 연구자들이 이를 활용하여 다양한 자연어 처리 연구를 수행하고 있습니다.

conversation.predict(input="RNN와 차이 설명해줘.")
RNN은 순환 신경망으로, 이전의 입력값을 현재의 입력값과 함께 처리하는 방식입니다. 이에 반해 Transformer는 self-attention 메커니즘을 사용하여 입력 시퀀스의 모든 위치를 동시에 처리합니다. 이를 통해 RNN보다 더욱 빠르고 정확한 결과를 제공할 수 있습니다. 또한 Transformer는 입력 시퀀스의 길이에 상관없이 일정한 시간 복잡도를 유지할 수 있어, 긴 시퀀스를 처리하는 데에도 유용합니다.
 

conversation.memory
ConversationBufferMemory(chat_memory=ChatMessageHistory(messages=[HumanMessage(content='인공지능에서 Transformer가 뭐야?', additional_kwargs={}, example=False), AIMessage(content='Transformer는 자연어 처리 분야에서 매우 유용한 딥러닝 모델 중 하나입니다. 이 모델은 기계 번역, 질의응답, 요약 등 다양한 자연어 처리 작업에서 사용됩니다. Transformer는 기존의 RNN, LSTM 등의 모델보다 더욱 빠르고 정확한 결과를 제공합니다. 이 모델은 구글에서 개발되었으며, 현재까지도 많은 연구자들이 이를 활용하여 다양한 자연어 처리 연구를 수행하고 있습니다.', additional_kwargs={}, example=False), HumanMessage(content='RNN와 차이 설명해줘.', additional_kwargs={}, example=False), AIMessage(content='RNN은 순환 신경망으로, 이전의 입력값을 현재의 입력값과 함께 처리하는 방식입니다. 이에 반해 Transformer는 self-attention 메커니즘을 사용하여 입력 시퀀스의 모든 위치를 동시에 처리합니다. 이를 통해 RNN보다 더욱 빠르고 정확한 결과를 제공할 수 있습니다. 또한 Transformer는 입력 시퀀스의 길이에 상관없이 일정한 시간 복잡도를 유지할 수 있어, 긴 시퀀스를 처리하는 데에도 유용합니다.', additional_kwargs={}, example=False)]), output_key=None, input_key=None, return_messages=False, human_prefix='Human', ai_prefix='AI', memory_key='history')
memory에서 주고받은 메모리를 확인하고 상황에 따라 아래 기능을 사용할 수 있습니다.

ConversationBufferMemory : 대화 기록(기본)
ConversationBufferWindowMemory : 마지막 n개의 대화만 기억
Entity Memory : 개체에 대한 정보를 저장
Conversation Knowledge Graph Memory: 개체의 triple 저장: (sam, 좋아하는 색, 파랑)
ConversationSummaryMemory : 대화의 요약본을 저장
ConversationSummaryBufferMemory : 대화 요약본 + 마지막 n토큰 기억
ConversationTokenBufferMemory : 마지막 n토큰 기억
VectorStore-Backed Memory : 벡터 DB에 정보 저장
 
 

5. Document Loaders
특정 문서나 웹페이지, 이메일, 파워포인트, 워드, 유튜브, 트위터 등에서 텍스트 정보를 긁어오는 로드하는 역할입니다.
GPT4의 최대 입력 토큰은 32,768개로 약 64,000 단어 분량의 값을 입력할 수 있습니다.
뒤에서 살펴볼 Summarization, Embedding and VectorStore에서 사용할 수 있도록 로드한다고 볼 수 있습니다.

Web Page
PDF
Email
Twitter
DataFrame(pandas)
YouTube
Notion
Google Drive
Powerpoint, Word
...
from langchain.document_loaders import WebBaseLoader

loader = WebBaseLoader(web_path="https://ko.wikipedia.org/wiki/NewJeans")
documents = loader.load()

from langchain.text_splitter import CharacterTextSplitter

text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
docs = text_splitter.split_documents(documents)
len(docs)
13

docs[:3]
[Document(page_content='토론\n\n\n\n\n\n\n\n한국어\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n읽기\n\n편집\n\n역사 보기\n\n\n\n\n\n\n\n\n\n도구\n\n\n\n\n\n도구\n사이드바로 이동\n숨기기\n\n\n\n\t\t동작\n\t\n\n읽기편집역사 보기\n\n\n\n\n\t\t일반\n\t\n\n여기를 가리키는 문서가리키는 글의 최근 바뀜파일 올리기특수 문서 목록고유 링크문서 정보이 문서 인용하기위키데이터 항목\n\n\n\n\n\t\t인쇄/내보내기\n\t\n\n책 만들기PDF로 다운로드인쇄용 판\n\n\n\n\n\t\t다른 프로젝트\n\t\n\n위키미디어 공용\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n위키백과, 우리 모두의 백과사전.\n\n\n\n\n EP에 대해서는 New Jeans (EP) 문서를 참고하십시오.\n\n\nNewJeans뉴진스\n\n\n\n\n\n\n\n\n기본 정보\n\n\n결성 지역\n\n대한민국 서울특별시\n\n\n장르\n\nK-pop댄스 팝\n\n\n활동 시기\n\n2022년 7월 22일 ~\n\n\n레이블\n\n하이브\n\n\n소속사\n\n어도어\n\n\n웹사이트\n\n공식 홈페이지\n\n\n구성원\n\n\n민지하니다니엘해린혜인\n\n\nNewJeans(뉴진스)는 2022년 7월 22일에 데뷔한 대한민국의 5인조 걸 그룹으로, 소속사는 하이브 산하의 레이블인 어도어이다. SM 엔터테인먼트 디렉터 출신으로 하이브에 영입된 민희진이 프로듀서로 나서서 발굴한 걸그룹이다. 2022년 8월 18일 《엠카운트다운》에서 데뷔 3주만에 첫 1위를 차지했다.\n\n\n활동[편집]\n이 문단은 영어 위키백과의 NewJeans 문서를 번역하여 문서의 내용을 확장할 필요가 있습니다.중요한 번역 안내를 보려면 [펼치기]를 클릭하십시오.\n신뢰성 있고 확인할 수 있는 출처가 제시되도록 번역하여 주십시오.\n번역을 완료한 후에는 {{번역된 문서}} 틀을 토론창에 표기하여 저작자를 표시하여 주십시오.\n문맥상 이해를 돕기 위해 관련 문서를 같이 번역해주시는 것이 좋습니다.\n번역을 확장할 필요가 있는 내용이 포함된 다른 문서를 보고 싶으시다면 분류:번역 확장 필요 문서를 참고해주세요.\n데뷔 전[편집]\n민지와 하니는 방탄소년단의 Permission to Dance 뮤직비디오에 출연하였다.', metadata={'source': 'https://ko.wikipedia.org/wiki/NewJeans', 'title': 'NewJeans - 위키백과, 우리 모두의 백과사전', 'language': 'ko'}), Document(page_content="2022년[편집]\n7월 22일 Attention 뮤직비디오를 공개함으로 데뷔를 했다. 23일 Hype Boy 뮤직비디오를 통해 맴버 5명의 이름을 공개, 8월 1일 음원 공개를 했으며, 8일에 정식 앨범《Newjeans 1st EP 'New Jeans'》를 발매했다.\n\n구성원[편집]\n\n\n이름\n\n소개\n\n\n민지\n\n\n본명: 김민지(金玟池)\n생년월일: 2004년 5월 7일(2004-05-07)(19세)\n학력\xa0: 한림예술고등학교 (졸업)\n출생지: 대한민국 강원도 춘천시\n활동기간\xa0: 2022년 7월 22일 ~\n\n\n하니\n\n\n본명: 하니 팜(Hanni Pham), 팜 응옥 헌(范玉欣/Phạm Ngọc Hân)\n생년월일: 2004년 10월 6일(2004-10-06)(18세)\n출생지: 오스트레일리아 빅토리아주 멜버른\n활동기간\xa0: 2022년 7월 22일 ~\n\n\n다니엘\n\n\n본명: 다니엘 마쉬(Danielle Marsh), 모지혜(牟智慧)\n생년월일: 2005년 4월 11일(2005-04-11)(18세)\n출생지: 오스트레일리아 뉴사우스웨일스주 뉴캐슬\n활동기간\xa0: 2022년 7월 22일 ~\n\n\n해린\n\n\n본명: 강해린(姜諧潾)\n생년월일: 2006년 5월 15일(2006-05-15)(16세)\n출생지: 대한민국 서울특별시\n학력: 중학교 졸업학력 검정고시 (합격)\n활동기간: 2022년 7월 22일 ~\n\n\n혜인\n\n\n본명: 이혜인(李惠仁)\n생년월일: 2008년 4월 21일(2008-04-21)(15세)\n출생지: 대한민국 인천광역시 미추홀구\n학력: 한국국제크리스천스쿨 (중퇴)\n활동기간: 2022년 7월 22일 ~", metadata={'source': 'https://ko.wikipedia.org/wiki/NewJeans', 'title': 'NewJeans - 위키백과, 우리 모두의 백과사전', 'language': 'ko'})]
docs[1].page_content 안에 내용을 요약하여 사용.
 

Summarization
Load 된 Document를 이용하여 LLM으로 요약을 합니다.
 
chain_type

"stuff": LLM 한 번에 다 보냄. 길면 오류.
"map_reduce": 나눠서 요약, 전체 요약본 다시 요약
"refine": (요약 + 다음 문서) => 요약
"map_rerank": 점수 매겨서 중요한 것으로 요약
from langchain.chains.summarize import load_summarize_chain

chain = load_summarize_chain(chat, chain_type="map_reduce", verbose=True)
chain.run(docs[1:3])
 
NewJeans is a five-member girl group from South Korea that debuted in July 2022 under the label of HIVE's subsidiary, Adore. They were produced by Min Hee-jin and achieved their first win on M Countdown just three weeks after their debut. Two members, Minji and Hani, appeared in BTS's "Permission to Dance" music video before their debut. The group consists of Minji, Hani, Daniel, Haerin, and Hyein, and they have all been active in the group since their debut.
document 인덱스 1~3 분량의 요약된 내용을 다시 요약합니다.
요약은 영어로 추출되고 공식문서를 봐도 따로 output에 대한 언어 설정은 없는 듯합니다.
 
 

Embedding and VectorStore
Embedding은 문서를 LLM에 입력하면 나오는 특징 벡터, Neural Network의 특정 메모리를 읽어서 만듭니다.
보통 512개 이상의 float로 만들어집니다.
의미상 비슷한 input이 들어갔을 때, 나오는 특징 벡터가 유사한 특징을 갖고, 거리상 가깝게 됩니다.(예: 나이, 연세 등)
기본적으로 사용되는 OpenAI API는 비용이 발생하므로 로컬에서 HuggingfaceEmbeddings를 이용하면 GPU 가속도 지원합니다.
 
Vector Database는 Embedding 벡터와 텍스트를 저장하는 DB입니다.
특징 벡터와 텍스트를 저장하고 파일에 저장.

Pinecone 서비스 (유료, 무료 제한적)
FAISS (페이스북, 오픈소스, 로컬)
Embeddings -> 텍스트를 저장
Embeddings로 검색할 수 있으며, 거리상 가장 가까운 항목을 가져올 수 있음. (거리를 구하는 방법은 여러 가지)
유사한 의미를 갖는 텍스트에 대한 Embedding 벡터는 거리상 가깝다.
 
1. 이전 Document Loader WebBaseLoader에 저장된 위키피디아 뉴진스 정보에 대한 특징 벡터를 추출합니다.

from langchain.embeddings import HuggingFaceEmbeddings
from langchain.embeddings import OpenAIEmbeddings

# embeddings = OpenAIEmbeddings()
embeddings = HuggingFaceEmbeddings()

from langchain.indexes import VectorstoreIndexCreator
from langchain.vectorstores import FAISS

index = VectorstoreIndexCreator(
    vectorstore_cls=FAISS,
    embedding=embeddings,
    ).from_loaders([loader])

# 파일로 저장
index.vectorstore.save_local("faiss-nj")
2. FAISS 벡터 DB VectorStore에 파일로 저장합니다.


3. 벡터 DB에서 질의문을 index query문으로 특정 벡터를 뽑고 그중 제일 가까운 문서를 뽑아냅니다.
그 후 검색된 문서와 질의문을 함께 GPT4로 입력하는 방식입니다.(GPT4 입력 : 질의문과 유사한 문서 + 질의문)

index.query("뉴진스의 데뷔곡은?", llm=chat, verbose=True)
뉴진스의 데뷔곡은 "Attention"입니다.

index.query("뉴진스의 데뷔 멤버는?", llm=chat, verbose=True)
뉴진스(NewJeans)는 2022년 7월 22일에 데뷔한 대한민국의 5인조 걸 그룹입니다. 멤버는 민지, 하니, 다니엘, 해린, 혜인으로 구성되어 있습니다.

index.query("멤버의 나이는?", llm=chat, verbose=True)
위키백과에서는 멤버들의 나이에 대한 정보를 제공하지 않고 있습니다. 따라서, 현재로서는 멤버들의 나이에 대해 알 수 없습니다.

index.query("멤버의 나이는? (오늘은 2023년 4월 18일)", llm=chat, verbose=True)
민지는 2004년 5월 7일생으로 19살, 하니는 2004년 10월 6일생으로 18살, 다니엘은 2005년 4월 11일생으로 18살, 해린은 2006년 5월 15일생으로 16살, 혜인은 2008년 4월 21일생으로 15살입니다.
 
 
 

👉🏻 활용 방안 예시
LangChain에서 가장 강력한 툴은 Document Loaders를 통한 Summarization과 Embedding, VertorStore가 아닐까 합니다.
GPT4가 학습되지 않은 정보가 담긴 문서(예: MBTI 정보 등)를 FAISS VectorStore에 저장하고 GPT4에 요약 및 키워드 추출 질의 작업하는 방식으로 활용할 수 있지 않을까 싶습니다.