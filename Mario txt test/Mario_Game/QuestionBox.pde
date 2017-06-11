class QuestionBox extends Box {


  PImage[] boxImage;

  int imageState;

  QuestionBox(float x, float y) {
    super();
    originalLocation = new PVector(x, y);
    location = new PVector(x, y);
    
    vel = new PVector(0, 3);
    ac = new PVector(0, 0);
    mass = 0.1;

    boxImage = new PImage[4];
    for (int i=0; i < boxImage.length; i++) {
      boxImage[i] = loadImage("Items/QuestionBox/questionBox"+i+".png");
    }
  }

  void display() {    
    if (imageState == 0) image(boxImage[0], location.x, location.y);
    else if (imageState == 1) image(boxImage[1], location.x, location.y);
    else if (imageState == 2) image(boxImage[2], location.x, location.y);
    else if (imageState == 3) image(boxImage[3], location.x, location.y);

    if (frameCount % 8 == 0) {
      imageState ++;
      if (imageState == 4) imageState = 0;
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
}