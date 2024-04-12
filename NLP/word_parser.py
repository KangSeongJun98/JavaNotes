# pip install konlpy
# konlpy 한국어 파서
from konlpy.tag import Okt
okt = Okt()
test = '안녕하세요 저는 팽수 입니다. 만나서 반갑습니다~'
parser_data = okt.pos(test)

import os
nouns = []
path = "./it/"
for file in os.listdir(path):
    with open(path + file, 'r', encoding='utf-8') as f:
        text = f.read()
    nouns += okt.nouns(text)
words = [n for n in nouns if len(n) > 1] # 한글자인 단어는 제외
print(nouns)

# pip install wordcloud
from collections import Counter
from wordcloud import WordCloud
cnt_word = Counter(words)
print(cnt_word)
wc = WordCloud(font_path='NanumGothicBold.ttf', width=400, height=400
               ,scale=2.0, max_font_size=250, background_color='white')
gen = wc.generate_from_frequencies(cnt_word)
import matplotlib.pyplot as plt
plt.figure()
plt.imshow(gen)
wc.to_file("news.png")
plt.show()