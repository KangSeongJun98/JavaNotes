from flask import Flask, request, Response, json
from flask_cors import CORS
from openai import OpenAI
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By


app = Flask(__name__)
# 모든 오리진에서의 CORS 요청을 허용 합니다.
CORS(app)

@app.route('/get_detail', methods=['GET'])
def get_data():
    print(request.args)
    print(request)
    print(type(request.args))
    title = request.args.get('title', None)
    print("빈값 체크:",title)

    client = OpenAI(api_key="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")
    sys = """
        너는 뉴스 본문을 요약해 이를 다시 문장으로 만들고
        해당 본문과 관련있는 다른 핵심 키워드를 제안할 수 있어!
    """
    url = f'https://search.naver.com/search.naver?ssc=tab.news.all&where=news&sm=tab_jum&query={title}'

    # 크롤링 옵션 생성
    options = webdriver.ChromeOptions()
    # 백그라운드 실행 옵션 추가
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)
    driver.implicitly_wait(3)
    driver.get(url)

    # 네이버 뉴스 링크 클릭후 본문 크롤링
    driver.find_element(By.XPATH, '//*[@id="sp_nws1"]/div/div/div[1]/div[2]/a[2]').click()
    driver.switch_to.window(driver.window_handles[-1])
    soup = BeautifulSoup(driver.page_source, 'html.parser')
    article_content = soup.select_one("#dic_area")
    content = article_content.text
    print(content)

    # gpt 요약
    resp = client.chat.completions.create(
        model='gpt-3.5-turbo'
        , messages=[{'role': 'system', 'content': f'{sys}'}
            , {'role': 'user', 'content': f'{content}'}]
        , temperature=0.7
    )
    text = resp.choices[0].message.content
    print("요약내용:", text)

    return text

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")