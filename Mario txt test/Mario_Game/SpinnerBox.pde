class SpinnerBox extends Box {

  PImage boxImage[];

  int imgState;

  SpinnerBox(float x, float y) {
    super();

    originalLocation = new PVector(x, y);
    location = new PVector(x, y);

    vel = new PVector(0, 3);
    ac = new PVector(0, 0);
    mass = 0.1;
    
    spinnerBoxCheck = true;

    boxImage = new PImage[4];

    for (int i=0; i < boxImage.length; i++) {
      boxImage[i] = loadImage("Items/SpinnerBox/spinnerBox"+i+".png");
    }
  }

  void display() {
    if (imgState == 0) image(boxImage[0], location.x, location.y);
    else if (imgState == 1) image(boxImage[1], location.x, location.y);
    else if (imgState == 2) image(boxImage[2], location.x, location.y);
    else if (imgState == 3) image(boxImage[3], location.x, location.y);

    if (stateChangerEnabled) {
      if (frameCount %7 == 0) {
        imgState ++;  
        if (imgState == 4) imgState = 0;
      }
    } else {
      if (imgState !=0) {
        if (frameCount %7 == 0) {
          imgState ++;
          if (imgState == 4) imgState = 0;
        }
      } else {
        imgState = 0;
        collisionEnabled = true;
      }
    }
  }

  void checkMillis() {
    int time = 7000;        // time is 1.0 sec...

    if (millis() > timePassed + time) {
      stateChangerEnabled = false;
    }
  }

  void collision(Mario theMario, ArrayList<Koopa> koopas) {
    if (location.y >= originalLocation.y) {
      vel.y = 0;
      ac.y = 0;
      location.y = originalLocation.y;
    }
    if (collisionEnabled) {
      super.marioAllWayCollision(theMario);
    }
    super.koopaAllWayCollision(koopas);
  }
}