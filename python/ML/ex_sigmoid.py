import numpy as np
import matplotlib.pyplot as plt
import pylab as pl


def sigmoid(x):
    return 1/(1 + np.exp(-x))

# -10 ~ 10 사이 값 400개
x_val = np.linspace(-10,10,400)
y_val = sigmoid(x_val)
plt.figure(figsize=(8,6))
pl.plot(x_val, y_val, label = 'sigmoid function')
plt.xlabel('x')
plt.ylabel('y')
plt.show()