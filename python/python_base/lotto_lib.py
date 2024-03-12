import random
# 기본함수 def

def fn_lotto(user_num):
    arr = []
    for v in range(user_num):
        lotto = set()
        while True:
            lotto.add(random.randint(1,45))
            if len(lotto) == 6:
                break
        arr.append(lotto)
    return arr
if __name__ == '__main__':
    print(fn_lotto(5))
else:
    print("외부에서 사용")
    
