# pip install tensorflow==2.13
# pip install keras
from keras.datasets import mnist
from keras.utils import  to_categorical
from keras.models import Sequential
from keras.layers import Dense
import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf

# 매 번 실행할 때마다 랜덤값이 고정될 수 있도록
np.random.seed(1)
tf.random.set_seed(1)
(x_train, y_train), (x_test, y_test) = mnist.load_data()
print(f"학습 데이터:{x_train.shape}")
print(f"테스트 데이터:{x_test.shape}")

#데이터 준비(최대가 255여서 나누기로 미리 정규화까지 한 것)
# 28 x 28 byte 짜리 데이터를 일렬로 쭉 피는 작업
x_train_reshape = x_train.reshape(x_train.shape[0], 784).astype("float32")/255
x_test_reshape = x_test.reshape(x_test.shape[0], 784).astype("float32")/255
y_train_cate = to_categorical(y_train, 10)
y_test_cate = to_categorical(y_test,10)

# model
model = Sequential()
model.add(Dense(512, input_dim=784, activation='relu'))
# softmax 는 다중 클래스 분류에 사용되는 활성화 함수
# 벡터의 원소를 0 ~ 1 사이 값으로 변환 => 변환된 값들의 합이 1이 되도록
# 벡터를 확률 분포로 변환하는 역할을 함
model.add(Dense(10, activation='softmax'))
model.summary()
model.compile(loss ='categorical_crossentropy'
              , optimizer='adam', metrics=['acc'])

history = model.fit(x_train_reshape
                    , y_train_cate
                    , epochs=100
                    , batch_size=200
                    , validation_data=(x_test_reshape, y_test_cate))

v_loss = history.history['val_loss']
loss = history.history['loss']
print(f"학습 acc:{model.evaluate(x_train_reshape, y_train_cate)}")
print(f"테스트 acc:{model.evaluate(x_test_reshape, y_test_cate)}")
model.save("./model/ANN.h5")

# 결과 그래프 출력
cnt = np.arange(len(v_loss))
plt.plot(cnt, v_loss, marker='.', c='red', label='test_loss')
plt.plot(cnt, loss, marker='.', c='blue', label='loss')
plt.xlabel('epoch')
plt.ylabel('loss')
plt.show()