from tkinter import *
from tkinter import messagebox

app = Tk()
lab = Label(app, text='이름')
lab.grid(row=0, column=0) #grid는 좌표
txt = Entry(app)
txt.grid(row=0, column =1)
def fn_click(): # 파이썬은 자바처럼 함수가 있으면 먼저 실행되거나 이런거 없음
                # 위에서 만들어줘야 함(클래스로 만들었다면 가능)
    name = txt.get()
    messagebox.showinfo("이름은:", name)
btn = Button(app, text='ok', command=fn_click)
btn.grid(row=1, column= 1)
app.mainloop()