class Coin {

  PVector location;
  PVector dimension;

  int imageState;

  PImage coinImg[];
  
  boolean marioCollectsCoin;

  Coin() {
    location = new PVector(0, 0);
    coinImg = new PImage[4];  

    for (int i=0; i < coinImg.length; i++) {
      coinImg[i] = loadImage("Items/Coins/coin"+i+".png");
    }
  }

  void display() {
    if (imageState == 0) image(coinImg[0], location.x, location.y, dimension.x, dimension.y);
    else if (imageState == 1) image(coinImg[1], location.x, location.y, dimension.x, dimension.y);
    else if (imageState == 2) image(coinImg[2], location.x, location.y, dimension.x, dimension.y);
    else if (imageState == 3) image(coinImg[3], location.x, location.y, dimension.x, dimension.y);

    if (frameCount % 7 == 0) {
      imageState++;
      if (imageState == 4) {
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
      marioCollectsCoin = true;
    }
  }
}