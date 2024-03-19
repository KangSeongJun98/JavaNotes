import requests
import json
from flask import Flask, render_template, request
# request객체는 get, post 방식 쓰는중 뭐쓰는지 값 받을려고 사용
import requests


client_id = "1EuTthLmeK11SN55TWmF"
client_secret = "2WZ10hhpov"
query = "둔산동맛집"
start = 1

url = f"https://openapi.naver.com/v1/search/blog?query={query}&start={start}&display=100" # JSON 결과
header = {"X-Naver-Client-Id":client_id
         ,"X-Naver-Client-Secret":client_secret}
res = requests.get(url, headers=header)

print(res)
json_data = res.json()
print(json_data)
items = json_data['items']
for i, v in enumerate(items):
    print(v)