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


# 1) set env val.
# $ export OPENAI_API_KEY="..."

# 2) input key from file
f = open("../../../__secret_recipe/secret_key/openai_api_key.txt", 'r')
input_key = f.readline()
f.close()

llm = ChatOpenAI(openai_api_key=input_key)

#시스템 역할 지정하기
template = """
You are a helpful assistant to help teenagers learn {output_language}.
Answer the question in <{output_language}> within 1~2 sentences.
YOU MUST USE <{output_language}> TO ANSWER THE QUESTION.
Question:"""

system_message_prompt = SystemMessagePromptTemplate.from_template(template)
human_template = "{text}"
human_message_prompt = HumanMessagePromptTemplate.from_template(human_template)

llm = ChatPromptTemplate.from_messages([system_message_prompt, human_message_prompt])

result = llm.format_messages(output_language="English",
                            text="잠이 안 올 때는 어떻게 하면 좋을지 대답해줘")

print(result)