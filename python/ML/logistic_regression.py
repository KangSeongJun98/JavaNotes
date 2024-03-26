# 이항분류 회귀분석을 이용한 이항분류
import numpy as np
import matplotlib.pyplot as plt

def sigmoid(x):
    return 1/(1 + np.exp(-x))

# x:공부한 시간/ y: 합격1, 불합격0
x = [2,4,6,8,10,12,14]
y = [0,0,0,1,1,1,1]
x_data = np.array(x)
y_data = np.array(y)
a = 0       # 기울기
b = 0       # y절편
lr = 0.05   # 학습률
epochs = 2001 # 몇 번 학습할 지
plt.scatter(x_data, y_data)
for i in range(epochs):
    for j in range(len(x_data)):
        a_diff = x_data[j] * (sigmoid(a * x_data[j] + b) - y_data[j]) # a에 대해서 미분
        b_diff = sigmoid(a * x_data[j] +b ) - y_data[j]               # b에 대해서 미분
        a = a - lr * a_diff
        b = b - lr * b_diff
    if i%100 == 0:
        print(f"epochs={i:.1f}, a={a:.4f}, b={b:.4f} ")

x_range = (np.arange(0,15,0.1))
plt.plot(np.arange(0,15,0.1)
         , np.array([sigmoid(a * x + b)for x in x_range]))
plt.show()