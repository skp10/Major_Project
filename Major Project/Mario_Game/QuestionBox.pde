class QuestionBox extends Box {

  // DECLARES QUESTIONBOXCOIN CLASS...
  QuestionBoxCoin theCoin;

  // IMAGE OF THE THE QUESTION BOX...
  PImage[] boxImage;

  PImage emptyBox;

  int imageState;
  boolean showedOnce;

  QuestionBox(float x, float y) {
    super();

    questionBoxCheck = true;

    originalLocation = new PVector(x, y);
    location = new PVector(x, y);
    vel = new PVector(0, 3);
    mass = 0.1;

    theCoin = new QuestionBoxCoin(originalLocation.x, originalLocation.y);

    boxImage = new PImage[4];
    for (int i=0; i < boxImage.length; i++) {                                        // Loads different box images...
      boxImage[i] = loadImage("Items/QuestionBox/questionBox"+i+".png");
    }
    emptyBox = loadImage("Items/QuestionBox/emptyBox.png");
  }

  void display() {
    // Displays box images...
    
    if (numOfHits > 0) {
      showQuestionBox();
    } else {
      if (!showedOnce) {
        showQuestionBox();
      }
      image(emptyBox, location.x, location.y);
    }
  }

  void showQuestionBox() {
    // Displays the QuestionBox animation as well as the coin coming out of it...
    
    if (theCoin.vel.y <= 0) {
      theCoin.display();
    } else {
      theCoin.location.y = originalLocation.y;
      if (numOfHits <= 0) {
        showedOnce = true;
      }
    }
    theCoin.move();
    theCoin.addforce(gravity);

    if (theCoin.location.y >= originalLocation.y) {              // Coin can't fall the ground... 
      theCoin.vel.y = 0;
      theCoin.ac.y = 0;
      theCoin.location.y = originalLocation.y;
    }

    if (botCollision) {
      theCoin.vel.y = -11;  
      botCollision = false;
    }

    imageMode(CORNER);
    if (imageState == 0) image(boxImage[0], location.x, location.y);
    else if (imageState == 1) image(boxImage[1], location.x, location.y);
    else if (imageState == 2) image(boxImage[2], location.x, location.y);
    else if (imageState == 3) image(boxImage[3], location.x, location.y);

    if (frameCount % 8 == 0) {                                              // is true every 8 frames...
      imageState ++;
      if (imageState == 4) imageState = 0;
    }
  }
  
  void collision(Mario theMario, ArrayList<Koopa> koopas, ArrayList<SoldierEnemy> soldiers, SoundTrack theSound) {
    // Checks for the collision with mario and interacts accordingly... 
    
    if (location.y >= originalLocation.y) {                    // Box can't fall the ground... 
      vel.y = 0;
      ac.y = 0;
      location.y = originalLocation.y;
    }
    if (!theMario.marioDies) {
      super.marioAllWayCollision(theMario, theSound);
    }
    super.soldierAllWayCollision(soldiers);
    super.koopaAllWayCollision(koopas);
  }
}

//----------------------------------------------- CLASS ONLY USED FOR THIS (QUESTION BOX CLASS) ---------------------------------------------------------------///////////

class QuestionBoxCoin extends Box {
  
  // COIN IMAGE...
  PImage coin;

  QuestionBoxCoin(float x, float y) {
    // Constructor that sets up data...
    
    location = new PVector(x, y);
    vel = new PVector(0, 0);
    mass = 0.1;

    coin = loadImage("Items/Coins/coin0.png");
  }

  void display() {
    // Displays the coin image...
    
    imageMode(CORNER);
    image(coin, location.x, location.y);
  }
}