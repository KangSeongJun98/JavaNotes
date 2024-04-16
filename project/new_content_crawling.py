# 네이버 검색 API 예제 - 블로그 검색
import os
import sys
import urllib.request
import requests
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
import time

client_id = "1EuTthLmeK11SN55TWmF"
client_secret = "2WZ10hhpov"
query = input("검색할 단어를 입력해주세요")
sel_val = input("1:최신순 | 2.정확도순")
if sel_val == '1':
    sel_val = 'date'
elif sel_val == '2':
    sel_val = 'sim'

url = f'https://openapi.naver.com/v1/search/news?query={query}&sort={sel_val}&display=100' # JSON 결과
header = {"X-Naver-Client-Id":client_id
         ,"X-Naver-Client-Secret":client_secret}
res = requests.get(url, headers=header)
json_data = res.json()
items = json_data['items']

for i, v in enumerate(items):
    title = v['title']
    title = BeautifulSoup(title, "lxml").text
    description = v['description']
    # html 태그 삭제시킴
    description = BeautifulSoup(description, "lxml").text
    link = v['link']
    print(f'제목:{title} 본문:{description} url{link}\n')


# # 본문을 읽고 싶은 뉴스와 동일한 뉴스 검색
# title = '스페이스X'
# url = f'https://search.naver.com/search.naver?ssc=tab.news.all&where=news&sm=tab_jum&query={title}'
# driver = webdriver.Chrome()
# driver.implicitly_wait(3)
# driver.get(url)
#
# # 네이버 뉴스 링크 클릭후 본문 크롤링
# driver.find_element(By.XPATH, '//*[@id="sp_nws1"]/div/div/div[1]/div[2]/a[2]').click()
# driver.switch_to.window(driver.window_handles[-1])
# soup = BeautifulSoup(driver.page_source, 'html.parser')
# article_content = soup.select_one("#dic_area")
# content = article_content.text
# print(content)