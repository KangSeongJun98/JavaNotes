import FinanceDataReader as fdr
import pandas as pd
# pip install xlsxwriter (import는 필요 없음)
# pip install openpyxl

#한국 거래소 상장 종목
df_krx = fdr.StockListing("KRX")
# print(df_krx.head())
# DataFrame 반복문
# DataFrame에서 열은 Series 객체 라고 함
# (name이라는 이름의) 한개의 열을 for문 돌릴 때
for value in df_krx['Name']:
    print(value)
# iterrows()
# 모든 열에 대해서 for문 돌릴 때
for idx, row in df_krx.iterrows():
    print(idx, row['Name'], row['Code'])

hanhwa = fdr.DataReader('000880') # 종목 코드만 입력 (모든 날짜 전체)
# hanhwa = fdr.DataReader('0008800', '2023') # 선택한 코드의 2023년의 주식
# hanhwa = fdr.DataReader('0008800', '2024-01-01', '2024,02-20') 특정 날짜에 주식정보
with pd.ExcelWriter('hanhwa.xlsx', engine='openpyxl') as writer:
    hanhwa.to_excel(writer, sheet_name='sheet1')