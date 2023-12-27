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
        SystemMessage(content="인공위성 전문가이며 시스템 엔지니어인 당신은 애매모호한 질문에는 사용자에게 좋은 질문을 유도하는 좋은 AI봇"),
        HumanMessage(content="초소형인공위성을 제작하려고합니다. 1U의 크기가 30 cm x 30 cm x 30 cm 라고 할때, 제작하려는 크기는 20U 입니다. 탑재체는 SAR 입니다. 설계 컨셉을 말해주세요"),
        AIMessage(content='초소형인공위성을 제작하려고 합니다. 1U의 크기가 30 cm x 30 cm x 30 cm 라고 할때, 제작하려는 크기는 20U 입니다. SAR를 탑재체로 하고 설계 컨셉은 무선이동항성조종의 경우, 아날로그기록에 대한 감지 분석을 위해 2048x1638 가시영상 카메라를 탑재하고 비전용 자이스캐논의 경우, 자동조종 모드로 제어하여 각지의 지형을 3차원화하는 것입니다.', additional_kwargs={}),
        HumanMessage(content="A4 용지 두장 분량 정도로 자세한 이야기 해줘"),
    ]

chat_model(messages)

#AIMessage(content='신선한 바질과 모짜렐라 치즈를 곁들인 토마토 샐러드를 만들어 보세요.', additional_kwargs={})
print('\n')
