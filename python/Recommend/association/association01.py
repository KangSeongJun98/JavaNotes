# pip install mlxtend
import pandas as pd
from mlxtend.frequent_patterns import apriori, association_rules
data = {
    "ID":range(1,11)
   ,"Milk"  :[1,0,0,1,1,0,0,1,1,0]
   ,"Bread" :[1,1,0,0,1,1,0,1,1,1]
   ,"Butter":[0,1,0,1,0,1,0,0,1,0]
   ,"Beer"  :[0,0,1,0,1,0,1,0,1,1]
   ,"Eggs"  :[0,0,1,0,1,1,1,0,1,1]
}
df = pd.DataFrame(data).set_index("ID")
# apriori 알고리즘 (빈발 항목 찾기)
# min_support 최소 지지도
frequent = apriori(df, min_support=0.2, use_colnames=True)
print(frequent)
# 연관 규칙생성
rules = association_rules(frequent, metric="confidence", min_threshold=0.6)
print(rules)
# 지지도: 전체 거리 중 항목 A와 B가 함께 나타나는 거래 비율(중요도)
# 신뢰도: A항목을 포함하는 거래중 항목 B도 함께 포함하는 거래 비율(규칙의 신뢰성)
# 향상도: A가 주어졌을 때 B의 조건부 확률을 B의 학률로 나눈 값
#         향상도가 1보다 크면 A와 B가 서로 연관성이 있다고 볼 수 있음
# 신뢰도가 높은 경우 : Beer를 구매하는 거래에서 Eggs도 함께 구매되는 비율
# 지지도가 높은 경우:  Beer와 Milk가 함께 구매되는 경우
# 향상도가 높은 경우: Beer 와 Eggs 향상도가 1보다 훨신 높을 경우 양의 상관관계