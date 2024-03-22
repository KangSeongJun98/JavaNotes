#pip install Flask
from flask import Flask, render_template, request
# request객체는 get, post 방식 쓰는중 뭐쓰는지 값 받을려고 사용
import requests
import json
import os
from werkzeug.utils import secure_filename

app = Flask(__name__)
@app.route("/")
def index():
    return "hello, Ncik"

@app.route("/hello")
# 맵핑 http://192.168.0.31:5555/hello 가 url임
def hello():
    return render_template("hello.html",
                           content="전달 내용", name="Nick")
                            # render_template는 페이지 열기,
                            # 매개변수 = 오픈할 페이지, 파라미터 주기

@app.route("/main", methods=['get', 'post'])
def main():
    # 방식이 get인지 post인지는 <form action ="POST">
    #                                    or
    #                            ajax({type:"POST"}) 등으로 구분 함
    if request.method == 'POST':
        data = json.loads(request.get_data()) #이렇게 하면 그냥 값을 받을 수 있고
        # json_data = request.get_json() 이걸로 하면 제이쿼리에서 요청할 때 
        #  ,contentType :'application/json'를 추가해야 함
        print(data)
        res = requests.get("https://api.upbit.com/v1/ticker?markets="
                           + data['market'])
        return res.content
    else:
        res = requests.get("https://api.upbit.com/v1/market/all")
        coin_list = json.loads(res.content)
        return render_template("main.html", coins=coin_list)

@app.route("/file_upload", methods=['GET','POST'])
def file_upload():
    if request.method == "POST":
        imgPath = './img/'
        if not os.path.exists(imgPath):
            os.mkdir(imgPath)
        f = request.files['file']
        filename = secure_filename(f.filename)
        save_path = os.path.join(imgPath, filename)
        f.save(save_path)
    else:
        return render_template("file_upload.html")

@app.route("/naver",methods=['GET', 'POST'])
def naver():
    if request.method == "POST":
        data = request.get_json()
        print(data['query'])
        result = get_naver(data['query'])
        return result
    else:
        return render_template("naver_search.html")

def get_naver(q):
    client_id = "1EuTthLmeK11SN55TWmF"
    client_secret = "2WZ10hhpov"
    url = f"https://openapi.naver.com/v1/search/blog?query={q}&display=100"  # JSON 결과
    header = {"X-Naver-Client-Id": client_id
        , "X-Naver-Client-Secret": client_secret}
    res = requests.get(url, headers=header)
    return res.json()


if __name__ == '__main__':
    app.run(debug = True, port = 5555, host="192.168.0.31")
    #port와 host는 생략 가능 없으면 디폴트 포트번호 나옴