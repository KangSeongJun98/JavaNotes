sql = {'select_data': '''
                        SELECT *
                        FROM stock
                        WHERE USE_YN = 'Y'
                        '''
       ,'insert_data': '''
                        INSERT INTO stock_price(code, seq, price)
                        VALUES (:1, stock_seq.NEXTVAL, :2)
                        '''
        }
#정해진 시간마다
#조회 종목의 현재가를 수집하여 stock_price테이블에 저장

import cx_Oracle
import naver_price
from apscheduler.schedulers.blocking import BlockingScheduler
import pytz
import datetime
import mylogger as logger
log = logger.make_logger("stock.log", "get_stock.py")
seoul = pytz.timezone("Asia/Seoul")


def fn_current_price():
    log.info("fn_cuurent_price start!!")
    print("수집 시작")
    print(datetime.datetime.now())
    conn = cx_Oracle.connect("study", "oracle", "127.0.0.1:1521/xe")
    cur = conn.cursor()
    cur.execute(sql['select_data'])
    rows = cur.fetchall()
    try:
        for row in rows:
            code = row[0]
            nm = row[1]
            price = naver_price.get_price(code)
            print(code, nm, price)
            cur.execute(sql['insert_data'], [code, price])
    except Exception as e:
        log.exception(str(e))
        conn.rollback()
    else:
        # 오류 없이 정상적으로 실행되면 커밋 되게
        conn.commit()
    finally:
        conn.close()

if __name__ == '__main__':
    log.info("start stock scheduler")
    sched = BlockingScheduler()
    sched.add_job(fn_current_price, 'interval', minutes = 2, timezone = seoul)
    print("스케줄러 작동!!")
    sched.start()