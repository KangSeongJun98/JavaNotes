from tkinter import *
from python_base.lotto_lib import fn_lotto

app = Tk()
entry = Entry(app)
entry.grid(row=0, column=0)
txt = Text(app)
txt.grid(row=1, column=0, columnspan=2)

def fn_click():
    cnt = int(entry.get())
    arr = fn_lotto(cnt)
    print(arr)
    for i in arr:
        txt.insert(END, i)

btn = Button(app, text='생성', command=fn_click)
btn.grid(row=0, column=1)
app.mainloop()
# 수량을 입력받아 text 위젯에 입력받은 수량만큼 로또번호 출력
# 1. button event
# 2. entry value
# 3. lotto 생성
# 4. 생성 수량만큼 Text insert

