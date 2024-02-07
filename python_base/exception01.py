# try .. except

def calc(values):
    sum = 0
    try:
        sum = values[0] + values[1] + values[2]
    except IndexError as err:
        print("index error")
    except Exception as e:
        print(str(e))
    else:
        print("에러 없음") #에러가 없을 때만 실행 됨
    finally:
        print(sum) #에러가 있던 없던 실행됨

calc([1,2])
calc([True, True, True])

try:
    print("^^"%4)
except Exception as e:
    print(str(e))
