class SoldierEnemy extends Characters {

  PVector dimension;

  PImage shellImg[];
  int shellImgState;

  PImage rightWalkImg[], LeftWalkImg[];

  int walkingImgSize;
  int leftWalkingState, rightWalkingState;

  int hitCounter;
  boolean deathEnabled;
  boolean movingRight;

  boolean hitOnce;

  boolean displaySoldier;

  SoldierEnemy(PVector location, PVector vel, PVector ac, float mass) {
    super(location, vel, mass);    
    isEnemy = true;

    dimension = new PVector(33, 33);

    walkingImgSize = 2;
    rightWalkImg = new PImage[walkingImgSize];
    LeftWalkImg = new PImage[walkingImgSize];

    for (int i=0; i< walkingImgSize; i++) {
      rightWalkImg[i] = loadImage("Enemies/Soldier/soldierRight"+i+".png");
      LeftWalkImg[i] = loadImage("Enemies/Soldier/soldierLeft"+i+".png");
    }
    shellImg = new PImage[3];
    for (int i=0; i<shellImg.length; i++) {
      shellImg[i] = loadImage("Enemies/Soldier/shell"+i+".png");
    }
  }

  void display(Mario theMario) {
    imageMode(CENTER);

    if (!deathEnabled) {
      soldierMoving();
    } else {
      soldierDies(theMario);
    }
  }

  void walkingLeft() {
    if (leftWalkingState == 0) image(LeftWalkImg[0], location.x, location.y);
    else if (leftWalkingState == 1) image(LeftWalkImg[1], location.x, location.y);

    if (frameCount % 30 == 0) {
      leftWalkingState ++;

      if (leftWalkingState == 2) {
        leftWalkingState = 0;
      }
    }
  }

  void walkingRight() {
    if (rightWalkingState == 0) image(rightWalkImg[0], location.x, location.y);
    else if (rightWalkingState == 1) image(rightWalkImg[1], location.x, location.y);

    if (frameCount % 30 == 0) {
      rightWalkingState ++;

      if (rightWalkingState == 2) {
        rightWalkingState = 0;
      }
    }
  }

  void soldierMoving() {
    if (!movingRight) {
      walkingLeft();
    } else {
      walkingRight();
    }
  }

  void shellImage() {
    vel.x = 0;
    image(shellImg[0], location.x, location.y);
  }

  void shellMovement(Mario theMario) {
    if (!hitOnce) {
      if (theMario.appearLeftOrRightSprite) {
        vel.x = -8;
      } else {
        vel.x = 8;
      }
      hitOnce = true;
    }
    if (shellImgState == 0) image(shellImg[0], location.x, location.y);
    else if (shellImgState == 1) image(shellImg[1], location.x, location.y); 
    else if (shellImgState == 2) image(shellImg[2], location.x, location.y);

    if (frameCount % 5 == 0) {
      shellImgState ++;
      if (shellImgState == 3) {
        shellImgState = 0;
      }
    }
  }

  void soldierDies(Mario theMario) {
    dimension = new PVector(36, 36);
    imageMode(CENTER);
    if (hitCounter == 1) {
      shellImage();
    } else if (hitCounter == 2) { 
      shellMovement(theMario);
    } else if (hitCounter == 3) {
      shellImage();  
      hitCounter = 1;
      hitOnce = false;
    }
  }

  void marioAndSoldierCollisoin(Mario theMario) {
    PVector charLocation = new PVector(theMario.location.x, theMario.location.y);
    PVector enemyLocation = new PVector(location.x, location.y);

    float distX = dist (charLocation.x, charLocation.y, location.x, charLocation.y);
    float distY = dist (charLocation.x, charLocation.y, charLocation.x, location.y);

    if (distX <= width/2+110) {
      displaySoldier = true;
    }

    if (charLocation.x < enemyLocation.x && distX >= 0) {
      distX *= -1;
    }
    if (charLocation.y < enemyLocation.y && distY >= 0) {
      distY *= -1;
    }

    float overlapX = (theMario.dimension.x/2 + dimension.x/2) - (abs(distX));
    float overlapY = (theMario.dimension.y/2 + dimension.y/2) - (abs(distY));

    if ((abs(distX) < theMario.dimension.x/2+dimension.x/2) && (abs(distY) < theMario.dimension.y/2+dimension.y/2)) {
      if (overlapX >= overlapY) {
        if (distY < 0) {
          theMario.location.y = location.y-dimension.y/2-theMario.dimension.y/2;
          theMario.vel.y = -11;          
          deathEnabled = true;
          hitCounter++;
        } else if (distY > 0) {
          theMario.vel.y = 0;
          theMario.ac.y = 0;
          theMario.location.y = location.y+dimension.y+theMario.dimension.y/2;
        }
      } else {
        if (distX < 0) {
          //theMario.location.x = location.x-dimension.x/2-theMario.dimension.x/2;
          theMario.marioDies = true;
        } else if (distX > 0) {
          //theMario.location.x = location.x+dimension.x/2+theMario.dimension.x/2;
          theMario.marioDies = true;
        }
      }
    }
  }
}