# python Data Types
# list(배열), dict{key:value}, tuple("수정","불가"), set{"중","복","X"}
# 동적배열로 타입이 자유로움

arr = [1, 2, "nick", [3,4]]
print(arr[1]) # index로 접근
arr.append(5) # 값 추가
print(arr)
arr[1] = 20   # 값 변경
print(arr * 5) # 배열 곱하기

# 딕셔너리 dict key:value
my_dict = {} #비어있는 딕셔너리
print(type(my_dict))
my_dict2 = {"ncik":20, "judy":10,
            "alice":[1,2]}
print(my_dict2["alice"])
my_dict2["jack"] = 20  #생성과 동시에 값 넣기
print(my_dict2)


# Tuple 순서가 있지만 변경이 불가능
my_tuple = (1,2,3)
print(my_tuple[1])
# my_tuple[1] = 4  오류남


# set 순서 없고 중복 허용 안함
# 다른 자료의 비어있는 선언과 다르게 set 키워드가 필요
# 딕셔너리와 동일한 중괄호이다 보니 구분짓기 위해 이렇게 됨
my_set = set()
my_set2 = {1,1,1,2,2,3}
print(my_set2)
my_set2.add(2)
print(my_set2)

# 타입변환
a = '10'
print(type(a))
a = int(a)
print(type(a))
msg = int(input("숫자를 입력하세여: "))
if msg > 5:
    print("5보다 크다")
elif msg == 5:
    print("5구나")
elif msg == 6:
    #아무 처리 없을 때 패스
    pass
else:
    print("입력이 5보다 작다?")

# 반복문 for
# 1.기본 for문 (배열의 요소값만 필요할 때)
for v in arr:
    print(v)

# 2. 인덱스와 요소값이 필요할 때
for i, v in enumerate(arr):
    print(i, v)
    
# 3. 단순반복
for i in range(3):  #0,1,2
    print(i)