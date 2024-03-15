import sqlite3
# sqlite3 = 경량 db
# 파일이 db임, 경량 db이기 때문에 여러 유저가 사용은 불가능

# 파일로 연결 만약 없으면 생성까지 해줌
# db라는 확장자 명은 본인이 임시로 정한 것
conn = sqlite3.connect('mydb.db')
# 일회용으로 해당 파이썬 실행 중에만 적용될꺼면 ':memory' 라고 작성
sql = """
    CREATE TABLE stock (
         code VARCHAR2(10) PRIMARY KEY,
         market VARCHAR2 (100),
         name VARCHAR2 (10), 
         marcap NUMBER, 
         stocks NUMBER
        )
"""
cur = conn.cursor()
cur.execute(sql)
conn.close()