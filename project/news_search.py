from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import requests
from flask import Flask, request, Response, json
from openai import OpenAI
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By


query = ''
url = 'https://search.naver.com/search.naver?ssc=tab.news.all&where=news&sm=tab_jum&query=한소희, 류준열 애칭은 ‘북극곰?’...열애설에 재조명받는 과거 영상'
driver = webdriver.Chrome()
driver.implicitly_wait(3)
driver.get(url)
time.sleep(1)

# 1.네이버 뉴스로 페이지 연다.
driver.find_element(By.XPATH, '//*[@id="sp_nws1"]/div/d'
                              'iv/div[1]/div[2]/a[2]').click()

driver.switch_to.window(driver.window_handles[-1])
soup = BeautifulSoup(driver.page_source, 'html.parser')
article_content = soup.select_one("#dic_area")
if(article_content== '' or article_content is None):
    article_content = soup.select_one("#articeBody")

content = article_content.text
print(content)