from langchain.callbacks.manager import CallbackManager
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler
from langchain.chat_models import ChatOllama
from langchain.schema import HumanMessage, SystemMessage, AIMessage
from langchain.llms import OpenAI
from langchain.chat_models import ChatOpenAI

# 1) set env val.
# $ export OPENAI_API_KEY="..."

# 2) input key from file
f = open("../../__secret_recipe/secret_key/openai_api_key.txt", 'r')
input_key = f.readline()
f.close()

llm = ChatOpenAI(openai_api_key=input_key)

text = "잠이 안 올 때는 어떻게 하면 좋을지 대답해줘"
messages = [HumanMessage(content=text)]
llm.predict_messages(messages, temperature = 0.1)
