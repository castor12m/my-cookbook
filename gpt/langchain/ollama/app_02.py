from langchain.callbacks.manager import CallbackManager
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler
from langchain.chat_models import ChatOllama
from langchain.schema import HumanMessage, SystemMessage, AIMessage

from langchain.prompts import PromptTemplate

prompt = PromptTemplate(
    input_variables=["상품"],
    template="{상품} 만드는 회사 이름 추천해줘. 기억에 남는 한글 이름으로",
)

prompt.format(상품="AI 여행 추천 서비스") # 변수가 여러 개 일 때, 지정

from langchain.chains import LLMChain

chat_model = ChatOllama(
    model="llama2-uncensored", 
    temperature=.7,
    callback_manager=CallbackManager([StreamingStdOutCallbackHandler()])
    )

chain = LLMChain(llm=chat_model, prompt=prompt)

chain.run(상품="AI 여행 추천 서비스")

print('\n')
