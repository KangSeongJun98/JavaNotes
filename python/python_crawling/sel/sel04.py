import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
from tkinter import *
url ='https://www.hanatour.com/package/international'

search_word = ''


# 크롬 드라이버를 백그라운드에서 실행시키는 법
option = webdriver.ChromeOptions()
option.add_argument('--headless')
def fn_search():
    global search_word
    #백그라운드 실행 옵션 추가
    driver = webdriver.Chrome(options=option)
    driver.get(url)
    time.sleep(1)
    search_word = entry.get() #입력 값
    input_search = driver.find_element(By.ID, 'input_keyword').send_keys(search_word)
    driver.find_element(By.CSS_SELECTOR, 'button.btn_search').click()
    time.sleep(1)
    driver.find_element(By.XPATH, '//*[@id="contents"]/div[3]/div[2]/div[1]/a').click()
    time.sleep(1)
    soup = BeautifulSoup(driver.page_source, 'html.parser')
    arr = soup.select('.prod_list li')
    for li in arr:
        title = li.select_one('.txt_info .tit').text
        print(title)
        txt.insert(END, title+'\n')
    driver.quit()

app = Tk()
app.title("tour search")
entry = Entry(app, width=100)
entry.pack()
btn = Button(app, text='search', command=fn_search)
btn.pack()
txt = Text(app, width=100, height=50)
txt.pack()
app.mainloop()