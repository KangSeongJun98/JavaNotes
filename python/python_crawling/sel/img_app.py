import time
import tkinter as tk
from tkinter import  scrolledtext
from  tkinter import  filedialog
import os
from selenium import webdriver
from selenium.webdriver.common.by import By

def fn_search(query):
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
        if scroll_h == new_h:  # 다 내려간 상황
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
        file_path = os.path.join(img_dir, str(i) + '.png')
        urllib.request.urlretrieve(v, file_path)

    # 너무 작은 이미지는 삭제
    for filename in os.listdir(img_dir):
        file_path = os.path.join(img_dir, filename)
        if os.path.isfile(file_path):
            # file size
            file_size = os.path.getsize(file_path)
            print(file_size)
            if file_size < 1000:
                print('지워버리기~')
                os.remove(file_path)
def search_data():
    #입력 검색어
    search_query = entry.get()

    #내용 출력
    txt.configure(state='normal') #입력 가능한 상태
    txt.delete(1.0, tk.END) #기본 내용 지우기
    txt.insert(tk.INSERT, search_query+ "이미지\n")
    txt.insert(tk.INSERT, "수집을 시작합니다.\n")
    #이미지 저장 함수
    fn_search(search_query)
    #저장되는 파일 경로 출력
    txt.insert(tk.INSERT, "수집종료\n")
    txt.configure(state='disable') #편집 불가능한 상태
app = tk.Tk()
app.title('이미지 수집기')
# 창 크기 변경 X
app.resizable(False, False)
# 검색어 입력
lab = entry = tk.Label(app, text='검색어')
lab.pack()
entry = tk.Entry(app)
entry.pack()
btn = tk.Button(app, text='수집', command=search_data)
btn.pack()
# 스크롤 가능한 텍스트 영역
txt = scrolledtext.ScrolledText(app, width=40, height=20
                                    ,state='disabled')
txt.pack()
app.mainloop()