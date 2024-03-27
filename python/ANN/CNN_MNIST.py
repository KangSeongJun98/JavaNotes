from keras.datasets import mnist
import numpy as np
from keras.models import Sequential
from keras.layers import Dense, Flatten, Conv2D, MaxPooling2D

model = Sequential()

model.add(Conv2D(32, kernel_size=(3,3)
                 ,input_shape=(28,28,1), activation='relu'))
model.add(Conv2D(64, (3,3), activation='relu'))
model.add(MaxPooling2D(pool_size=2))

# 신경만 구조로 바꿔주는 작업 Flatten
model.add(Flatten())
model.add(Dense(128, activation="relu"))
model.add(Dense(10, activation='softmax'))
model.summary()
model.compile(loss="categorical_crossentropy"
              , optimizer="adam", metrics=['acc'])

# 데이터
(x_train, y_train), (x_test,y_test) = mnist.load_data()
x_train_reshape = (
    x_train.reshape(x_train.shape[0],28,28,1).astype('float32')/255)
x_test_reshape = (
    x_test.reshape(x_test.shape[0],28,28,1).astype('float32')/255)
from keras.utils import to_categorical
y_train_cate = to_categorical(y_train)
y_test_cate = to_categorical(y_test)

# 모델 저장 및 학습중단 설정
from keras.callbacks import ModelCheckpoint, EarlyStopping
path = './model/'
file_name = path+ "{epoch:02d}-{val_loss:.4f}.h5"
checkpoint = ModelCheckpoint(filepath=file_name, monitor="val_loss"
                             ,verbose=1, save_best_only=True)
early_stopping = EarlyStopping(monitor='val_loss', patience=10)
history = model.fit(x_train_reshape, y_train_cate
                    ,validation_data=(x_test_reshape, y_test_cate)
                    ,epochs=30, batch_size=100, verbose=1
                    ,callbacks=[early_stopping,checkpoint])

import matplotlib.pyplot as plt
v_loss = history.history['val_loss']
loss = history.history['loss']
# 결과 그래프 출력
cnt = np.arange(len(v_loss))
plt.plot(cnt, v_loss, marker='.', c='red', label='test_loss')
plt.plot(cnt, loss, marker='.', c='blue', label='loss')
plt.xlabel('epoch')
plt.ylabel('loss')
plt.show()