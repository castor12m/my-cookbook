from langchain.callbacks.manager import CallbackManager
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler
from langchain.chat_models import ChatOllama
from langchain.schema import HumanMessage, SystemMessage, AIMessage
from langchain.llms import OpenAI
from langchain.chat_models import ChatOpenAI
from langchain.prompts import PromptTemplate

# 1) set env val.
# $ export OPENAI_API_KEY="..."

# 2) input key from file
f = open("../../../__secret_recipe/secret_key/openai_api_key.txt", 'r')
input_key = f.readline()
f.close()

llm = ChatOpenAI(openai_api_key=input_key)

my_template = """아래의 질문에 대해 한 줄로 간결하고 친절하게 답변하세요.
질문: {question}"""

prompt = PromptTemplate.from_template(my_template)

prompt.format(question="잠이 안 올 때는 어떻게 하면 좋을지 대답해줘")

result = llm.predict(prompt.format(question="잠이 안 올 때는 어떻게 하면 좋을지 대답해줘"))

print(result)