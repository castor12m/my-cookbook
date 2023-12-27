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

chat_model = ChatOllama(
    model="llama2-uncensored", 
    temperature=0,
    callback_manager=CallbackManager([StreamingStdOutCallbackHandler()])
    )

template="You must talk to {output_language}."
system_message_prompt = SystemMessagePromptTemplate.from_template(template)
human_template="{text}"
human_message_prompt = HumanMessagePromptTemplate.from_template(human_template)

chat_prompt = ChatPromptTemplate.from_messages([system_message_prompt, human_message_prompt])

chatchain = LLMChain(llm=chat_model, prompt=chat_prompt)
chatchain.run(input_language="English", output_language="Korean", text="I love programming.")

print('\n')
