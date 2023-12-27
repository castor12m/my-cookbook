from langchain.callbacks.manager import CallbackManager
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler
from langchain.chat_models import ChatOllama
from langchain.schema import HumanMessage, SystemMessage, AIMessage


chat_model = ChatOllama(
    model="llama2-uncensored", 
    temperature=.7,
    callback_manager=CallbackManager([StreamingStdOutCallbackHandler()])
    )

# chat(
#   [  
#     SystemMessage(content="당신은 사용자가 짧은 문장으로 무엇을 먹을지 알아낼 수 있도록 도와주는 멋진 AI 봇입니다."),
#     HumanMessage(content="토마토 좋아하는데, 뭘 먹어야 하나요??")
#   ]
# )

messages = [
        SystemMessage(content="인공위성 전문가, 시스템 엔지니어, 짧고 간결한 대답, 핵심, 애매모호한 질문에는 사용자에게 좋은 질문을 유도"),
        HumanMessage(content="초소형인공위성을 제작하려고합니다. 1U의 크기가 30 cm x 30 cm x 30 cm 라고 할때, 제작하려는 크기는 20U 입니다. 탑재체는 SAR 입니다. 설계 컨셉을 말해주세요")
    ]

chat_model(messages)

#AIMessage(content='신선한 바질과 모짜렐라 치즈를 곁들인 토마토 샐러드를 만들어 보세요.', additional_kwargs={})
print('\n')
