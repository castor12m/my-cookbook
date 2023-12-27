from langchain.callbacks.manager import CallbackManager
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler
from langchain.chat_models import ChatOllama
from langchain.schema import HumanMessage, SystemMessage, AIMessage

from langchain.prompts import PromptTemplate
from langchain.chains import LLMChain
from langchain.prompts.chat import (
    ChatPromptTemplate,
    SystemMessagePromptTemplate,
    HumanMessagePromptTemplate,
)

from langchain.agents import load_tools
from langchain.agents import initialize_agent
from langchain.agents import AgentType

chat_model = ChatOllama(
    model="llama2-uncensored", 
    temperature=0,
    callback_manager=CallbackManager([StreamingStdOutCallbackHandler()])
    )

tools = load_tools(["serpapi", "llm-math"], llm=chat_model) # serpapi 사용하면 구글 검색
#tools = load_tools(["wikipedia", "llm-math"], llm=chat_model)

agent = initialize_agent(tools, llm=chat_model, agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION, verbose=True) # verbose : 중간 과정 출력

agent.run("페이스북 창업자는 누구인지? 그의 현재(2023년) 나이를 제곱하면?")

print(agent.tools[0].description)
print(agent.tools[1].description)

print('\n')
