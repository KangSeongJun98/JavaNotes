from flask import Flask, request, render_template
from openai import OpenAI
client = OpenAI(api_key="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")
sys="""
    너는 대화 주제에 토픽을 찾아서 해당 토픽과
    관련있는 다른 핵심 키워드를 제안할 수 있어.!
"""
app = Flask(__name__)
@app.route('/', methods=['GET', 'POST'])
def index():
    keywords = ""
    if request.method == 'POST':
        message = request.form['message']
        resp = client.chat.completions.create(
            model='gpt-3.5-turbo'
            , messages=[{'role':'system', 'content':f'{sys}'}
                        ,{'role':'user', 'content':f'{message}'}]
        )
        print(resp.choices[0].message.content)
        keywords = resp.choices[0].message.content.strip()
    return render_template('index.html', keywords = keywords)
if __name__ == '__main__':
    app.run(debug=True)