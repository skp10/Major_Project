class QuestionBox extends Box {

  QuestionBoxCoin theCoin;

  PImage[] boxImage;
  PImage emptyBox;

  int imageState;
  boolean showedOnce;

  QuestionBox(float x, float y) {
    super();
    questionBoxCheck = true;
    originalLocation = new PVector(x, y);
    location = new PVector(x, y);

    theCoin = new QuestionBoxCoin(x, y);

    vel = new PVector(0, 3);
    mass = 0.1;

    boxImage = new PImage[4];
    for (int i=0; i < boxImage.length; i++) {
      boxImage[i] = loadImage("Items/QuestionBox/questionBox"+i+".png");
    }
    emptyBox = loadImage("Items/QuestionBox/emptyBox.png");
  }

  void display() {    
    if (numOfHits > 0) {
      showQuestionBox();
    } else {
      if (!showedOnce) {
        showQuestionBox();
      }
      image(emptyBox, location.x, location.y);
    }
  }

  void collision(Mario theMario, ArrayList<Koopa> koopas) {
    if (location.y >= originalLocation.y) {
      vel.y = 0;
      ac.y = 0;
      location.y = originalLocation.y;
    }
    super.marioAllWayCollision(theMario);
    super.koopaAllWayCollision(koopas);
  }

  void showQuestionBox() {
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

    if (theCoin.location.y >= originalLocation.y) {
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

    if (frameCount % 8 == 0) {
      imageState ++;
      if (imageState == 4) imageState = 0;
    }
  }
}


class QuestionBoxCoin extends Box {

  PImage coin;

  QuestionBoxCoin(float x, float y) {
    location = new PVector(x, y);
    vel = new PVector(0, 0);
    mass = 0.1;

    coin = loadImage("Items/Coins/coin0.png");
  }

  void display() {
    imageMode(CORNER);
    image(coin, location.x, location.y);
  }
}