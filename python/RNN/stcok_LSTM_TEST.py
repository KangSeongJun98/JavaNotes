from keras.models import load_model
import pandas as pd
import numpy as np
from sklearn.preprocessing import MinMaxScaler
# 모델 불러오기
model = load_model('./AAPL1.h5')
# 데이터 불러오기
df = pd.read_excel('./AAPL_20231219_20240305.xlsx'
                     ,engine='openpyxl')
scaler = MinMaxScaler(feature_range=(0,1))
df_data = scaler.fit_transform(df['Close'].values.reshape(-1,1))
df_data = df_data[-50:]
data_reshape = np.reshape(df_data, (1,df_data.shape[0],1))
pred = model.predict(data_reshape)
print(pred)
#예측 결과 스케일 역변환
pred_inverse = scaler.inverse_transform(pred)
print(pred_inverse)