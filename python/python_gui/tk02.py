from tkinter import *
from tkinter import messagebox
from python_base.lotto_lib import fn_lotto

app = Tk()
lab = Label(app, text='로또 수량')
lab.grid(row=0, column=0) #grid는 좌표
txt = Entry(app)
txt.grid(row=0, column =1)
def fn_click(): # 파이썬은 자바처럼 함수가 있으면 먼저 실행되거나 이런거 없음
                # 위에서 만들어줘야 함(클래스로 만들었다면 가능)
    cnt = int(txt.get())
    arr = fn_lotto(cnt)
    messagebox.showinfo("이름은:", arr)
btn = Button(app, text='ok', command=fn_click)
btn.grid(row=1, column= 1)
app.mainloop()