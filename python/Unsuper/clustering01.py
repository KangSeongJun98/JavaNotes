from sklearn import datasets
import pandas as pd
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt

iris = datasets.load_iris()
label = pd.DataFrame(iris.target)
label.columns = ['labels']
data = pd.DataFrame(iris.data)
data.columns = ['Sepal length', 'Sepal width',
                'Petal length', 'Petal width']

# 데이터 프레임 결합
df = pd.concat([data,label], axis=1)
x_data = data[['Sepal length', 'Sepal width']]

# n_clusters = 군집을 3개로 만든다
model = KMeans(n_clusters=3, algorithm='lloyd')
model.fit(x_data)
pred = pd.DataFrame(model.predict(x_data))
pred.columns = ['pred']
all_data = pd.concat([df, pred], axis=1)
print(all_data.head())
plt.scatter(all_data['Sepal length'], all_data['Sepal width']
            ,c=all_data['pred'], alpha = 0.5)
# 군집중심점
center = pd.DataFrame(model.cluster_centers_
                      ,columns=['Sepal length', 'Sepal width'])
center_x = center['Sepal length']
center_y = center['Sepal width']
plt.scatter(center_x, center_y, s=50, marker='D', c='r')
plt.show()