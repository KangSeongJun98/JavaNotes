import FinanceDataReader as fdr
import matplotlib.pyplot as plt
import pandas as pd
import pandas as pdd
stock = fdr.DataReader('AAPL')
stock['Close'].plot()
plt.show()

def fn_get_stock(p_code, p_start, p_end):
    df = fdr.DataReader(p_code, p_start, p_end)
    df_stock = df.reset_index()
    seq = df_stock['Date'].dt.strftime('%Y-%m-%d')
    x_data = df_stock[['Close']].astype(str)
    x_data['Data'] = seq
    fime_nm = '{0}_{1}_{2}.xlsx'.format(p_code
                                        ,p_start.replace('-','')
                                        ,p_end.replace('-',''))
    writer = pd.ExcelWriter(fime_nm, engine='openpyxl')
    x_data.to_excel(writer, 'Sheet1')
    writer._save()
fn_get_stock('AAPL', '2023-12-19', '2024-03-05')