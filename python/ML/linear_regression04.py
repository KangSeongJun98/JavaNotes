import numpy as np
import matplotlib.pyplot as plt
# 다중 선형 회귀
# 독립변수가 1개 이상
# x1:공부시간 / x2:과외시간 / y:성적

x1 = [2,4,6,8]
x2 = [0,4,2,3]
y = [81,93,91,97]
ax = plt.axes(projection='3d')
ax.set_xlabel('study')
ax.set_ylabel('private')
ax.set_zlabel('score')
ax.dist = 11
ax.scatter(x1, x2, y)
plt.show()

x1_data = np.array(x1)
x2_data = np.array(x2)
y_data = np.array(y)
a1 = 0 # 기울기
a2 = 0
b = 0 # y절편 초기 값
lr = 0.05 # 학습률 (학습률과 이폭크는 연구자가 정함 하이퍼파라미터)
epochs = 2001 # 학습데이터에 대해서 몇 번 학습할 건지

for i in range(epochs):
    y_hat = a1 * x1_data + a2 * x2_data + b
    error = y_data - y_hat # 실제예값과 예측 값 차이
    a1_diff = -(1/len(x1_data)) * sum(x1_data * error)  # 오차 함수를 a1로 미분
    a2_diff = -(1/len(x2_data)) * sum(x2_data * error)  # 오차 함수를 a2로 미분
    b_diff = -(1/len(x1_data)) * sum(y_data - y_hat)    # 오차 함수를 b로 미분
    a1 = a1 - lr * a1_diff  # 학습률을 곱하며 a1를 업데이트
    a2 = a2 - lr * a2_diff  # 학습률을 곱하며 a2를 업데이트
    b = b - lr * b_diff     # 학습률을 곱하며 b를 업데이트
    if i % 100 ==0:
        print("epochs =%.f 기울기 a1=%04f, a2=%.04f y절편=%04f"%(i, a1, a2, b))
y_pred = a1 * x1_data + a2 * x2_data + b
print(y_pred)