# 다중선형회귀
from sklearn.linear_model import LinearRegression
import pandas as pd
from sklearn.model_selection import train_test_split

df = pd.read_csv("./datasets/streeteasy/manhattan.csv")
print(df.describe())
print(df.columns)
print(df.info())
x = df[['bedrooms', 'bathrooms', 'size_sqft',
       'min_to_subway', 'floor', 'building_age_yrs', 'no_fee', 'has_roofdeck',
       'has_washer_dryer', 'has_doorman', 'has_elevator', 'has_dishwasher',
       'has_patio', 'has_gym']]
y = df[['rent']]

# 학습데이터:테스트 데이터 = 8:2
# random_state = 1 실행시 항상 동일한 인덱스의 대상건을 선택해 분리해줌 (숫자는 아무 정수나 가능)
X_train, X_test, y_train, y_test = train_test_split(x,y,train_size=0.8)
print(X_train.shape)
print(X_test.shape)
model = LinearRegression()
model.fit(X_train, y_train)
print("기울기:", model.coef_)
print("y절편:", model.intercept_)

print("학습 데이터 정확도:" ,model.score(X_train, y_train))
print("테스트 데이터 정확도:" ,model.score(X_test, y_test))
y_hat = model.predict(X_test)
import matplotlib.pyplot as plt
plt.scatter(y_test, y_hat, alpha = 0.4)
plt.xlabel('actual rent')
plt.ylabel('predict rent')
plt.show()

test_row = X_test.iloc[[1]]
actual = y_test.iloc[[1]]
print("테스트 1행:", test_row)
print("실제 값:",actual['rent'].values)
pre = model.predict(test_row)
print("예측값:",pre[0])