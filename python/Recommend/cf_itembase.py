import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

# 협업 필터링 - 아이템 기반
# 모든 아이템의 동일 차원의 매트릭스 생성
# 아이템간 유사도 비교를 통해 가장 가까운 아이템 추천

df_ratings = pd.read_csv("ratings.csv")
df_movies = pd.read_csv("movies.csv")
print(df_ratings.info())
print(df_movies.info())
# axis=1 은 해당열을 다 날린다는 의미
# inplace = true 면 자체적으로 날림 (다른 변수에 담을 꺼면 true 안써도 됨)
df_ratings.drop('timestamp', axis=1, inplace=True)
print(df_ratings.head())
user_itme_rating = pd.merge(df_ratings, df_movies, on="movieId")
print(user_itme_rating.head())
movie_matrix = user_itme_rating.pivot_table("rating", index="title", columns="userId")
# NaN 값 0으로
movie_matrix.fillna(0, inplace=True)
print(movie_matrix.head())
# 유사도 비교
item_cf = cosine_similarity(movie_matrix)
print(item_cf)
result = pd.DataFrame(data=item_cf, index=movie_matrix.index
                      ,columns=movie_matrix.index)
def get_item_based(title):
    # 내림차순 정렬 후 상위 영화만 리턴
    return result[title].sort_values(ascending=False)[:10]

while True:
    text = input("좋아하는 영화 이름을 정확하게 입력하세요")
    print(get_item_based(text))