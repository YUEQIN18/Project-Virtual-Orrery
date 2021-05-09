class Button {
  float leftPos;
  float topPos;
  float btnWidth;
  float btnHeight;
  boolean on = false;
  char name = ' ';
  
  Button(float leftPos, float topPos, float btnWidth, float btnHeight, char name){
    this.leftPos = leftPos;
    this.topPos = topPos;
    this.btnWidth = btnWidth;
    this.btnHeight = btnHeight;
    this.name = name;
  }
  
  boolean isClicked(){
    return (mouseX > leftPos && mouseY > topPos && mouseX < leftPos + btnWidth &&
    mouseY < topPos + btnHeight);
  }
  
  void toggleOnOff(){
    this.on = !this.on;
  }
}
