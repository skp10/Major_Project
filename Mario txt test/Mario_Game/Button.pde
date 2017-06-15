class Button {

  PVector location;
  PVector dimension;

  PImage textImg;

  Button(PVector location, String txtLoc) {
    this.location = location;

    textImg = loadImage(txtLoc);
  }


  void display() {
    imageMode(CENTER);
    if (isHovering()) {
      image(textImg, location.x-3, location.y-3);  
    }else {
      image(textImg, location.x, location.y);
    }
  }


  boolean isHovering() {
    return ((mouseX >= location.x-textImg.width/2 && mouseX <= location.x+textImg.width/2) && 
      (mouseY >= location.y-textImg.height/2 && mouseY <= location.y+textImg.height/2));
  }

  boolean buttonPressed() {
    return isHovering();
  }
}