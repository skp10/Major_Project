class Muncher {

  PVector location;
  PVector dimension;

  int imageState;

  PImage muncherImg[];

  Muncher() {
    location = new PVector(0, 0);

    muncherImg = new PImage[2];  

    for (int i=0; i < muncherImg.length; i++) {
      muncherImg[i] = loadImage("Enemies/Muncher/munch"+i+".png");
    }
  }

  void display() {
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
    PVector charLocation = new PVector(theMario.location.x, theMario.location.y);
    PVector objLocation = new PVector(location.x+dimension.x/2, location.y+dimension.y/2);

    float distX = dist (charLocation.x, charLocation.y, objLocation.x, charLocation.y);
    float distY = dist (charLocation.x, charLocation.y, charLocation.x, objLocation.y);

    if ((abs(distX) < theMario.dimension.x/2+dimension.x/2) && (abs(distY) < theMario.dimension.y/2+dimension.y/2)) {
      println(true);
    }
  }
}