from bs4 import BeautifulSoup
import requests
from selenium import webdriver
import chromedriver_autoinstaller
import time

driver = webdriver.Chrome()
url = 'https://www.melon.com/chart/index.htm'
driver.get(url)
time.sleep(2)
soup = BeautifulSoup(driver.page_source, 'html.parser')
tbody = soup.find('tbody')
trs = tbody.find_all('tr')
for tr in trs:
    tds = tr.find_all('td')
    rank = tds[1].select_one("span.rank").text #span테그 안에 클래스명이 rank인 애
    a_tag = tds[5].find_all('a')
    title = a_tag[0].text
    singer = a_tag[1].text
    print(rank, title, singer)