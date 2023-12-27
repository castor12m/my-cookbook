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
from langchain import ConversationChain

chat_model = ChatOllama(
    model="llama2-uncensored", 
    temperature=0,
    callback_manager=CallbackManager([StreamingStdOutCallbackHandler()])
    )

conversation = ConversationChain(llm=chat_model, verbose=True)
conversation.predict(input="인공지능에서 Transformer가 뭐야?")

conversation.predict(input="RNN와 차이 설명해줘.")

print('\n')
