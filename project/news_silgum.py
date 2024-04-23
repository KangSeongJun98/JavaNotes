import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from bs4 import BeautifulSoup
import cx_Oracle
from apscheduler.schedulers.blocking import BlockingScheduler
import pytz
import datetime

seoul = pytz.timezone("Asia/Seoul")

sql = '''
        INSERT INTO real_time_search (search_rank, search_content)
        VALUES(:0, :1)
'''
#정해진 시간마다
#조회 종목의 현재가를 수집하여 stock_price테이블에 저장

#실검 을 hot_topic에 저장

def search_news():
    option = webdriver.ChromeOptions()
    option.add_argument('--headless')
    hot_topics = []
    url = 'https://signal.bz/'
    driver = webdriver.Chrome(options=option)
    driver.get(url)
    time.sleep(1)
    soup = BeautifulSoup(driver.page_source, 'html.parser')
    container = soup.select_one('.container')
    rank_layers = container.select('.rank-layer')
    for rank_layer in rank_layers:
        num = rank_layer.select_one('.rank-num').text
        text = rank_layer.select_one('.rank-text').text
        hot_topics.append([num, text])
    print(hot_topics)

    driver.quit()
    
    print("데이터 추가")
    print(datetime.datetime.now())
    conn = cx_Oracle.connect("seongjun", "seongjun", "127.0.0.1:1521/xe")
    cur = conn.cursor()
    try:
        for topic in hot_topics:
            rank = topic[0]
            content = topic[1]
            print(rank, content)
            cur.execute(sql, [rank, content])
    except Exception as e:
        print(e)
        print("오류 발생")
        conn.rollback()
    else:
        # 오류 없이 정상적으로 실행되면 커밋 되게
        conn.commit()
    finally:
        conn.close()

if __name__ == '__main__':
    search_news()
    sched = BlockingScheduler()
    sched.add_job(search_news, 'interval', hours = 1, timezone = seoul)
    print("스케줄러 작동!!")
    sched.start()