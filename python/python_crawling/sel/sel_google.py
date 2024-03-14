from selenium import webdriver
from selenium.webdriver.common.by import By
import time

query = '고래상어'
url = f'https://www.google.com/search?q={query}'
driver = webdriver.Chrome()
driver.implicitly_wait(3)
driver.get(url)
time.sleep(1)
# 1.이미지 텝 클릭
try:
    driver.find_element(By.XPATH, '//*[@id="bqHHPb"]/div/div/div/div[1]/a[1]').click()
except Exception as e:
    driver.find_element(By.XPATH, '//*[@id="hdtb-msb"]/div[1]/div/div[2]/a').click()

body = driver.find_element(By.TAG_NAME, 'body')
# 2.페이지 가장 하단 높이 가져오기
# execute_script : 스크립트 호출
scroll_h = driver.execute_script('return document.body.scrollHeight')
print(scroll_h)
while True:
# 3.가장 하단으로 이동
    driver.execute_script('window.scrollTo(0, document.body.scrollHeight)')
    time.sleep(1)
    new_h = driver.execute_script('return document.body.scrollHeight')
    if scroll_h == new_h: #다 내려간 상황
# 4.더보기 버튼이 있다면 클릭(반복)
        btn = driver.find_element(By.CLASS_NAME, 'LZ4I')
        if btn:
            try:
                btn.click()
            except Exception as e:
                print(str(e))
            finally:
                break
    scroll_h = new_h
# 없다면 img tag 가져오기
img = body.find_elements(By.TAG_NAME, 'img')
print(len(img))
img_set = set()
for i in img:
    if i.get_attribute('src') != None:
        img_set.add(i.get_attribute('src'))
print(img_set)
driver.close()
# img tag 저장

import urllib.request
import os
root = './'
img_dir = os.path.join(root, query)
# 이미지 저장할 폴더 생성
if not os.path.exists(img_dir):
    os.mkdir(img_dir)
for i, v in enumerate(img_set):
    file_path = os.path.join(img_dir, str(i)+'.png')
    urllib.request.urlretrieve(v, file_path)
    
# 너무 작은 이미지는 삭제
for filename in os.listdir(img_dir):
    file_path = os.path.join(img_dir, filename)
    if os.path.isfile(file_path):
        #file size
        file_size = os.path.getsize(file_path)
        print(file_size)
        if file_size<1000:
            print('지워버리기~')
            os.remove(file_path)