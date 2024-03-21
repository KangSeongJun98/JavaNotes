import requests
from flask import Flask, request, Response, json
from openai import OpenAI
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
from flask_cors import CORS


app = Flask(__name__)
# 모든 오리진에서의 CORS 요청을 허용 합니다.
CORS(app)

@app.route('/get_data', methods=['GET'])
def get_data():
    print(request.args)
    print(request)
    print(type(request.args))
    query = request.args.get('query', None)

    client_id = ""
    client_secret = ""


    url = f'https://openapi.naver.com/v1/search/news?query={query}&display=100' # JSON 결과
    header = {"X-Naver-Client-Id": client_id
        , "X-Naver-Client-Secret": client_secret}
    res = requests.get(url, headers=header)
    json_data = res.json()
    items = json_data['items']
    print(type(items))
    print(items)

    for i, v in enumerate(items):
        title = v['title']
        title = BeautifulSoup(title, "lxml").text
        description = v['description']
        # html 태그 삭제시킴
        description = BeautifulSoup(description, "lxml").text
        link = v['link']
        print(f'제목:{title} 본문:{description} url{link}\n')

    # 수집 작업

    # 리턴 내용
    response = Response(response=json.dumps(items, ensure_ascii=False),
                        status=200,
                        mimetype='application/json; charset=utf-8')
    return response


@app.route('/', methods=['GET', 'POST'])
def index():
    client = OpenAI(api_key="")
    sys = """
        너는 뉴스 본문을 요약해 이를 다시 문장으로 만들고
        해당 본문과 관련있는 다른 핵심 키워드를 제안할 수 있어!
        형식은 본문요약을 하고 줄을 바꾼 뒤  ' 관련키워드: a' 라고 출력해줘 
       
    """
    print(request.form['title'])
    # 본문을 읽고 싶은 뉴스와 동일한 뉴스 검색
    # print(request.args)
    title = request.form['title']
    title = BeautifulSoup(title, "lxml").text
    url = f'https://search.naver.com/search.naver?ssc=tab.news.all&where=news&sm=tab_jum&query={title}'

    # 크롤링 옵션 생성
    options = webdriver.ChromeOptions()
    # 백그라운드 실행 옵션 추가
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)
    driver.implicitly_wait(3)
    driver.get(url)
    print("================================   1")
    # 네이버 뉴스 링크 클릭후 본문 크롤링
    driver.find_element(By.XPATH, '//*[@id="sp_nws1"]/div/div/div[1]/div[2]/a[2]').click()
    driver.switch_to.window(driver.window_handles[-1])
    print("================================   2")
    soup = BeautifulSoup(driver.page_source, 'html.parser')
    article_content = soup.select_one("#dic_area")
    if (article_content == '' or article_content is None):
        article_content = soup.select_one("#articeBody")
        if(article_content == '' or article_content is None):
            article_content = soup.select_one("#newsEndContents")
    content = article_content.text

    print(content)

    # gpt 요약
    resp = client.chat.completions.create(
        model='gpt-3.5-turbo'
        , messages=[{'role': 'system', 'content': f'{sys}'}
            , {'role': 'user', 'content': f'{content}'}]
        , temperature=0.7
    )
    print("요약내용:", resp.choices[0].message.content)
    return resp.choices[0].message.content


if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")