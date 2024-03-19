from DBManager import DBManager
import pandas as pd
import requests
import json

db = DBManager()
conn = db.get_connection()
sql = ''' 
          SELECT *
          FROM stock
          WHERE use_yn = 'Y'
     '''
merge_sql = ''' 
MERGE 
INTO stock_bbs a
USING dual
ON (a.CODE = :1 AND DISCUSSION_ID = :2) 
WHEN MATCHED THEN
    UPDATE 
    SET a.READ_COUNT = :3, 
        a.GOOD_COUNT = :4, 
        a.BAD_COUNT = :5, 
        a.COMMENT_COUNT = :6

WHEN NOT MATCHED THEN
    INSERT     (
               CODE 
              ,DISCUSSION_ID 
              ,READ_COUNT 
              ,GOOD_COUNT 
              ,BAD_COUNT 
              ,COMMENT_COUNT 
              ,TITLE
              ,CONTENTS 
              ,CREATE_DT )
    VALUES(:7,:8,:9,:10,:11,:12,:13,:14, TO_DATE(:15, 'YYYY-MM-DD HH24:MI:SS'))
'''
df = pd.read_sql(con=conn, sql=sql)
# print(df.head())

for idx, row in df.iterrows():
    code = row['CODE']
    name = row['NAME']
    print(code, name)
    url = f"https://m.stock.naver.com/api/discuss/localStock/{code}?rsno=0&size=100"
    res = requests.get(url)
    json_data = json.loads(res.text)
    for v in json_data:
        print(v)
        code = v['itemCode']
        discussionId = v['discussionId']
        title = v['title']
        contents = v['contents']
        readCount = v['readCount']
        goodCount = v['goodCount']
        badCount = v['badCount']
        commentCount = v['commentCount']
        date = v['date'][:19]
        try:
            db.insert(merge_sql, [code, discussionId, readCount,goodCount, badCount,
                                  commentCount, code, discussionId,  readCount, goodCount,
                                  badCount, commentCount, title, contents, date])
        except Exception as e:
            print(str(e))