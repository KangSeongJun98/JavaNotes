import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from keras.models import Sequential
from keras.layers import LSTM, Dense
from sklearn.preprocessing import MinMaxScaler

# 데이터 셋 만들기 x:1~50일, y:51일
df = pd.read_excel('./AAPL_20100101_20240304.xlsx', engine='openpyxl')

# 0~1 사이의 값으로 스케일링
scaler = MinMaxScaler(feature_range=(0,1))
df['Close'] = scaler.fit_transform(np.array(df['Close'].values.reshape(-1,1)))

data_cnt = len(df['Close'].values)
seq_len = 50
seq_all = seq_len+1
result = []
for idx in range(data_cnt - seq_all):
    result.append(df['Close'][idx:idx + seq_all])
# print(result)
result = np.array(result)
# 10% 테스트로 사용
row_cnt = int(round(result.shape[0]*0.9))
train_data = result[:row_cnt, :]

x_train = train_data[:, :-1]
x_train_reshape = np.reshape(x_train
                             ,(x_train.shape[0]
                             ,x_train.shape[1],1))
y_train = train_data[:, -1]
print(x_train_reshape)

test_data = result[row_cnt:, :-1]
x_test_reshape = np.reshape(test_data,
                            (test_data.shape[0]
                            ,test_data.shape[1],1))
y_test = result[row_cnt:, -1]

# RNN모델 생성
model = Sequential()
# 입력 50 입력 시퀀스의 모든 타임스텝을 반환하도록 설정
model.add(LSTM(50, return_sequences=True, input_shape=(50, 1)))
# 마지막 타입스텝의 출력만 반환하도록
model.add(LSTM(64, return_sequences=False))
# 50개로 1개의 값을 예측 (수치 예측 linear)
model.add(Dense(1, activation='linear'))
model.summary()
model.compile(loss="mse", optimizer='adam')
model.fit(x_train_reshape, y_train
          , validation_data=(x_test_reshape,y_test)
          , batch_size=50
          , epochs=20)
model.save("AAPL1.h5")
pred = model.predict(x_test_reshape)
fig = plt.figure(facecolor='white', figsize=(20,10))
ax = fig.add_subplot(111)
ax.plot(y_test, label="True")
ax.plot(pred, label='pred')
ax.legend()
plt.show()