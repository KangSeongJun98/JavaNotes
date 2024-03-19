# pip install -U finance-datareader
# pip install matplotlib
# pip install pandas
import FinanceDataReader as fdr
from matplotlib import pyplot as plt

AAPL = fdr.DataReader('AAPL')
AAPL['Close'].plot()
plt.show()