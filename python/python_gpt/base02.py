# pip install openai
from openai import OpenAI
import os
api_key ="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"
client = OpenAI(api_key=api_key)
system="""
너는 음식점 AI비서야
아래는 음식종류, 아래 종류의 메뉴 말고는 다른 메뉴는 없어
-삼겹살
-대패 삼겹살
-물냉
삼겹살은 1인분에 5000원
"""
message =[{"role":"system"
           ,"content": system}]
def ask(text):
    user_input = {"role":"user", "content": text}
    message.append(user_input)
    resp = client.chat.completions.create(
        model='gpt-3.5-turbo'
        ,messages=message
    )
    bot_text = resp.choices[0].message
    # 여태까지 한 대화를 이어나가기 위해서 assistant추가
    bot_resp = {"role":"assistant", "content":bot_text}
    message.append(bot_resp)
    return bot_text

while True:
    user_input = input("주문해주세요:")
    bot_resp = ask(user_input)
    print(f"bot:{bot_resp}")