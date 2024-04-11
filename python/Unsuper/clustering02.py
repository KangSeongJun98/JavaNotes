import pandas as pd
import matplotlib.pyplot as plt
from  sklearn.cluster import KMeans
df = pd.read_csv('./Mall_Customers.csv')
print(df.info())
print(df.describe())
# 좋은 군집 찾기 (kmeans는 군집 수를 몇 개로 할 지가 중요함)
# 군집내 거리가 가깝고 군집간에 거리는 먼 군집이 좋은 군집이다.
# 그룹에 포함된 데이터들의 퍼짐정도를 inetria 라고 함
df['Gender'] = df['Gender'].map({"Female":1, "Male":0})
data = df[['Gender', 'Age', 'Annual Income', 'Spending Score']]
cnt = list(range(1,11))
inertia = []
for i in cnt:
    model = KMeans(n_clusters=i, algorithm='lloyd')
    model.fit(data)
    inertia.append(model.inertia_)
plt.plot(cnt, inertia, '-0')
plt.xlabel('cluster(k)')
plt.ylabel('inertia')
plt.show()