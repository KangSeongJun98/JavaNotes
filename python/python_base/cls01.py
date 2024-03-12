class Rectangle:
    count = 0

    # 생성자
    def __init__(self, w, h):
        self.width = w
        self.height = h
    
    # 인스턴스 메서드
    def calcArea(self):
        area = self.width * self.height
        return  area
    
    @staticmethod
    def isSquare():
        print("정적 메서드")

    @classmethod
    # 클래스 메서드는 클래스 변수에 접근이 가능함
    def printCount(cls):
        cls.count +=1
        print(cls.count)


a = Rectangle(10,20)
b = Rectangle(50, 100)
print(a.calcArea())
print(b.calcArea())
Rectangle.isSquare() # 정적 메서드 사용
# Rectangle.calcArea 는 오류남 인스턴스 메서드이기때문에
Rectangle.printCount()# 클래스 메서드 사용(클래스 변수 접근)