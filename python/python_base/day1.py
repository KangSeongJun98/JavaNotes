print("hello world")
# 문자열 '' or "" or """" """" or ''' '''

print('''

이딴 식 으로 된다는 의미

''')

# python 식별자: 변수, 함수, 클래스, 모듈...의 이름
# 규칙
# 1.알파벳, 숫자, 언더스코어(_)로 구성
# 2.숫자로 시작할 수 없음
# 3.대소문자 구별
# 4.예약어를 사용할 수 없음(ex, for, while, if ...)
# 5.보통 변수는 스네이크 표기법 사용(as_df)
a = 'hi'
my_var = 10 # 자료형에는 타입 안붙음 자동 인식
print (type(my_var))
print(my_var)
print(type(a))
# 문자열 곱하기(*) 가능
print('='*100)
print(a * 10)

#기본 문자열 함수
print(a.upper())
print("HELLO".lower())

c = "Life is to Short".replace("Short","long")
d = c.split() # split의 default는 공백을 구분으로 자른다
print(d)
msg = input("문자를 입력하세요:")
print(msg)

# 기본데이터 타입에 null 대신 none이 있음

# 연산자 중에 포함관계를 확인하는 in이 있음
# a in [문,자,열]

#자료구조형 []
# 1. 리스트
a = []
b = [1, 2, 3, ['life', True]]
print(b[1])
# 슬라이스 가능 [n:m]
print(b[0:3])
# 배열 합치는거 +로 가능
a = ['배열', '합치기']
print(b+a)


# 2.튜플 ()
# 수정 안됨 (데이터 변경 안돼야 할 때 씀)
a = (1, 2, 3, '튜', '플')

# 3.딕셔너리 {key:value}
score = {"철수":90, "민수":70}
print(score["철수"])

# 4.set {1,2,3}
# 중복 안되는 구조