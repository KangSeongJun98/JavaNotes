# 사용자 로또 번호에 포함시키고 싶은 번호가 있다면 
# 1 ~ 5개 까지만 입력을 받아서 사용자번호가 포함된 로또번호를 생성해주세요
import random
nums = input("희망하는 숫자가 있다면 띄어쓰기로 입력해주세요").split()
set_nums = set(nums)

while True:
    set_nums.add(random.randint(1,45))
    if len(set_nums) == 6:
        print(set_nums)
        break
