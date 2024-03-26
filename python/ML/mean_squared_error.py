# 대표적인 손실함수 (연속된 값에 대해서)
import numpy as np
import matplotlib.pyplot as plt
# 가상의 기울기:a / y절편:b

ab = [3, 76]
# 공부한 시간 x, 성적 y
# X:독립변수, Y:종속변수
x = [2, 4, 6, 8]
y = [81, 93, 91, 97]
# 그래프
plt.figure(figsize=(8,5))
# 산점도 (두 변수간의 관계를 점으로 시각화)
# 데이터의 분포, 경향성, 이상치등을 파악할 수 있으며
# 변수간의 상관관계를 추정하는데 유용함
plt.scatter(x, y)
plt.show()

# MSE 함수
def mse(y, y_hat):
    # y_hat은 y의 예측 값 의미함
    return ((y-y_hat)**2).mean()

# 예측함수 ax+b
def predict(x):
    return ab[0] * x + ab[1]

# 총 오차를 구하는 함수
def mes_val(y, result):
    return mse(np.array(y), np.array(result))

arr = []
for i in range(len(x)):
    arr.append(predict(x[i]))
    print(f"공부시간 ={x[i]}, 실제점수 ={y[i]}, 예측점수 ={predict(x[i])}")

#최종 MSE
print("총 오차:", str(mes_val(arr,y)))