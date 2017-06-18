class Muncher {
  
  // PROPERTIES OF MUNCHER...
  PVector location;
  PVector dimension;
  
  // IMG OF MUNCHER...
  PImage muncherImg[];
  
  int imageState;  

  Muncher() {
    // Constructor that sets up data...
    
    location = new PVector(0, 0);

    muncherImg = new PImage[2];  
    for (int i=0; i < muncherImg.length; i++) {                      // loads the muncher images...
      muncherImg[i] = loadImage("Enemies/Muncher/munch"+i+".png");
    }
  }

  void display() {
    // Displays the muncher animation...
    
    if (imageState == 0) image(muncherImg[0], location.x, location.y, dimension.x, dimension.y);
    else if (imageState == 1) image(muncherImg[1], location.x, location.y, dimension.x, dimension.y);

    if (frameCount % 11 == 0) {
      imageState++;
      if (imageState == 2) {
        imageState = 0;
      }
    }
  }

  void marioCollision(Mario theMario) {
    // Ceck if mario is creating collision with it (muncher)...
    
    PVector charLocation = new PVector(theMario.location.x, theMario.location.y);
    PVector objLocation = new PVector(location.x+dimension.x/2, location.y+dimension.y/2);

    float distX = dist (charLocation.x, charLocation.y, objLocation.x, charLocation.y);
    float distY = dist (charLocation.x, charLocation.y, charLocation.x, objLocation.y);
    
    // IF CREATING COLLISION WITH THE MARIO...
    if ((abs(distX) < theMario.dimension.x/2+dimension.x/2) && (abs(distY) < theMario.dimension.y/2+dimension.y/2)) {
      theMario.marioDies = true;
    }
  }
}