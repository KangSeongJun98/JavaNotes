import requests
from bs4 import BeautifulSoup
import sqlite3

def get_price(code):
    url=f"https://finance.naver.com/item/main.naver?code={code}"
    res = requests.get(url)
    soup = BeautifulSoup(res.content, 'html.parser')
    today = soup.find('div', {'class':'today'})
    price = today.find('em').find('span', {'class':'blind'}).text
    price = price.replace(',', '')
    return price

if __name__ == '__main__':
    conn = sqlite3.connect('mydb.db')
    cur = conn.cursor()
    insert_sql = """
        SELECT code, name FROM stock
    """
    cur.execute(insert_sql)
    rows = cur.fetchall()
    conn.close()
    for row in rows:
        print(get_price(row[0]), row[1])


