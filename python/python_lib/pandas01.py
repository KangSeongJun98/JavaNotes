import pandas as pd
# 판다스는 보통 별칭으로 pd를 씀
# 데이터 프레임을 자료구조로 사용 (행, 열)
dic = {"name": ["nick", "judy", "alex"]
       ,"age":[10, 15, 20]}
# python의 딕셔너리를 쉽게 데이터프레임으로 만들 수 있음
df = pd.DataFrame(dic)
# 데이터정보 출력
print(df.head())
# 기존 열을 활용하여 새로운 열을 쉽게 만들 수 있음
# 없는 열이름에 값을 넣어 주면 생김
df['age_plus'] =  df['age']+1
df['age_squared'] = df['age']*df['age']
print(df.head())
# 다양한 내장 함수가 있음
# 행과 열에 함수 적용이 가능
print("나이 총합:", df['age'].sum())
print("중앙 값:",df['age'].quantile(0.5))
print("기초 통계")
print(df.describe())
print("기본 정보")
print(df.info())
# join 가능
df2 = pd.DataFrame({ "name":['nick', 'judy', 'alex']
                    ,'heigth': [180, 165, 175]
                    ,'gender': ['M','F','M']})
joined = df.set_index('name').join(df2.set_index('name'))
print(joined.head())
#group by 가능
g_df = joined.groupby('gender').mean()
print(g_df)