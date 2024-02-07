# 시작 경로, 찾을 파일명을 입력받아
# 찾으면 input으로 맞는지 (y/n)을 입력받아 
# 전체경로를 출력하는 함수
import os

def fn_search():
    # root, nm = input("찾을 시작경로, 파일명을 입력하세요").split()
    root, nm = "c:/dev", "file01"
    # root = 'C:\\'
    # for dirpath, dirname, filename in os.walk(root):
    #     print(dirpath, dirname, filename)
    for dirpath, dirname, filename in os.walk(root):
        for file in filename:
            print(dirpath, file)
            if nm in file:
                check = input("찾는 파일이 맞습니까? y/n")
                print(check)
                if check =='y':
                    print(dirpath, file)
                    print("파일을 찾았습니다")
                    return
fn_search()
