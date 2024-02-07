#기본 형태
def fn_name(param):
    print("함수 실행")
    return param *2

print(fn_name('팽수'))

# 가변 길이 파라미터 (0~n개의 파라미터를 받을 수 있음)
def fn_total(*numbers):
    tot = 0
    for n in numbers:
        tot += n
    return tot

print(fn_total())
print(fn_total(1,10,10))

def fn_sum_nul(choice, *args):
    if choice == '+':
        result = 0
        for n in args:
            result += n
    elif choice == '*':
        result = 1
        for n in args:
            result *= n
    return result
print(fn_sum_nul('+',1,2,3,4))
print(fn_sum_nul('*',1,2,3,4))

# return이 0 ~ n개 가능
def fn_name(param):
    nms = param.split()
    return nms[0], nms[1]
first, last = fn_name("강 성준")
print(first, last)
# 여러개의 return 값을 하나의 변수에 저장하면 튜플 형태로 저장 됨
nm = fn_name("홍 길동")
print(nm)

#named 파라미터
def report(name, age, score = 0):
    print(name, age, score)
report(age = 14, name="jack", score=100)
report(age = 12, name="judy")

# lambda 함수(익명함수)
# 정의와 동시에 사용
func = (lambda x: x+1)(3)
print(func)

# 변수에 담아 사용
func2 = lambda x, y: x*y+1
print(func2(2,3))

# map 활용
arr = [1,2,3,4,5]
result = list(map(lambda x: x**2, arr))
print('result:',result)

