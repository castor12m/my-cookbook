from langchain.callbacks.manager import CallbackManager
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler
from langchain.chat_models import ChatOllama
from langchain.schema import HumanMessage, SystemMessage, AIMessage
from langchain.llms import OpenAI
from langchain.chat_models import ChatOpenAI
from langchain.prompts import PromptTemplate
from langchain.prompts.chat import (
    ChatPromptTemplate,
    SystemMessagePromptTemplate,
    HumanMessagePromptTemplate,
)
from langchain.schema import BaseOutputParser


# 1) set env val.
# $ export OPENAI_API_KEY="..."

# 2) input key from file
f = open("../../../__secret_recipe/secret_key/openai_api_key.txt", 'r')
input_key = f.readline()
f.close()

class CommaSeparatedListOutputParser(BaseOutputParser):
    """LLM 아웃풋에 있는 ','를 분리해서 리턴하는 파서."""


    def parse(self, text: str):
        return text.strip().split(", ")

temp = CommaSeparatedListOutputParser().parse("아기, 여우")

print(temp)