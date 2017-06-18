class Button {
  
  // PROPERTIES OF BUTTON...
  PVector location;
  PVector dimension;
  
  // IMAGE OF THE BUTTON...
  PImage textImg;

  Button(PVector location, String txtLoc) {
    // Constructor that sets up the data... 
    
    this.location = location;

    textImg = loadImage(txtLoc);
  }


  void display() {
    // Displays the button
    
    imageMode(CENTER);
    if (isHovering()) {
      image(textImg, location.x-3, location.y-3);  
    }else {
      image(textImg, location.x, location.y);
    }
  }


  boolean isHovering() {
    // Checks if the button is hovering and hence creating collision with the mouse...
    
    return ((mouseX >= location.x-textImg.width/2 && mouseX <= location.x+textImg.width/2) && 
      (mouseY >= location.y-textImg.height/2 && mouseY <= location.y+textImg.height/2));
  }

  boolean buttonPressed() {
    // if the mouse is hovering the return true...
    
    return isHovering();
  }
}