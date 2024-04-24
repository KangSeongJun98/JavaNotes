import cx_Oracle

class DBManager:
    def __init__(self):
        self.conn = None
        self.get_connection()

    def get_connection(self):
        self.conn = cx_Oracle.connect("study", "oracle", "127.0.0.1:1521/xe")
        print("접속됨")
        return self.conn

    def __del__(self):
        #사용이 끝나면 호출됨(소멸자)
        try:
            print('소멸자')
            if self.conn:
                self.conn.close()
                print("접속을 종료함")
        except Exception as e:
            print("__del__", str(e))

    def insert(self, query, param):
        cur = self.conn.cursor()
        cur.execute(query, param)
        self.conn.commit()
        cur.close()

if __name__ == '__main__':
    db = DBManager()