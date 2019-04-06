import sys
from PyQt5.QtWidgets import QFrame,QPushButton,QLabel
from PyQt5.QtCore import QBasicTimer

class demo(QFrame):
    def __init__(self):
        super().__init__()
        self.button = QPushButton(self)
        self.button.setText('一个按钮')
        self.button.pressed.connect(self.onMouseDown)
        self.button.released.connect(self.onMouseUp)
        self.button.move(50,50)
        self.resetbtn = QPushButton(self)
        self.resetbtn.clicked.connect(self.resetCount)
        self.resetbtn.setText('重置')
        self.resetbtn.move(50,150)
        self.label = QLabel(self)
        self.label.move(150,50)
        self.count = 0
        self.speed = 0.1
        self.label.setText(str(self.count))
        self.timer = QBasicTimer()

    def updateLabel(self):
        self.label.setText(str(self.count))
        self.label.adjustSize()

    def onMouseDown(self):
        print('button is pressed')
        if not self.timer.isActive():
            self.timer.start(self.speed,self)

    def onMouseUp(self):
        self.timer.stop()

    def timerEvent(self,event): 
        self.count = self.count+1
        #print(self.count)
        self.updateLabel()
    
    def resetCount(self):
        self.count = 0
        self.updateLabel()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    d = demo()
    d.show()
    sys.exit(app.exec_())