# pip install openai
from openai import OpenAI
import os
api_key ="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"
client = OpenAI(api_key=api_key)
# 기본적인 사용법
completion = client.chat.completions.create(
    # 3.5, 4, ...
    model='gpt-3.5-turbo'
    ,messages=[
        {'role': 'system', 'content':'너는 음식을 잘하는 AI 어시스턴트이다.'}
       ,{'role': 'user', 'content':'햄버거 만드는 법을 알려줘'}
    ]
    # 0.0~ 0.3 예측이 가능한 보수적 응답
    # 0.7~ 1.0 더 창의적이고 예측하기 어려운 응답
    ,temperature=1.0
    # 구두점, 띄워쓰기, 단어 등이 1개의 토큰
    ,max_tokens=50
)
msg = completion.choices[0].message
print(msg)