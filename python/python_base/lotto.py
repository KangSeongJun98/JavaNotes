# import 라이브러리 불러오는 방법
import random

test = random.randint(1,45) # 1부터 45의 랜덤 정수
print(test)

# 사용자에게 로또 생성 수량을 입력받아 입력받은 수량만큼 출력
arr = [1,2]
print(len(arr)) # 배열의 사이즈


msg = int(input('로또를 몇 장 만들까요?'))

for v in range(msg):
    lotto = set()
    while True:
        lotto.add(random.randint(1,45))
        if len(lotto) == 6:
            break
    print(sorted(lotto))
