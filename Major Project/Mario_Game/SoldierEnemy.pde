class SoldierEnemy extends Characters {

  // PROPERTIES OF THE SOLDIER...
  PVector dimension;
  
  // IMAGES OF THE SOLDIER...
  PImage rightWalkImg[], LeftWalkImg[];  
  PImage shellImg[];
  
  //UNIVERSAL VARIABLES...
  int shellImgState;  
  int walkingImgSize;
  int leftWalkingState, rightWalkingState;
  int hitCounter;
  
  boolean deathEnabled;
  boolean movingRight;
  boolean hitOnce;
  boolean displaySoldier;
  boolean completelyDead;

  SoldierEnemy(PVector location, PVector vel, float mass) {
    // Constructor that sets up the data...
    
    super(location, vel, mass);    
    isEnemy = true;

    dimension = new PVector(33, 33);

    walkingImgSize = 2;
    rightWalkImg = new PImage[walkingImgSize];
    LeftWalkImg = new PImage[walkingImgSize];

    for (int i=0; i< walkingImgSize; i++) {                                        // LOADS DIFFERENT IMAGES OF THE SOLDIER/ENEMY...
      rightWalkImg[i] = loadImage("Enemies/Soldier/soldierRight"+i+".png");
      LeftWalkImg[i] = loadImage("Enemies/Soldier/soldierLeft"+i+".png");
    }
    shellImg = new PImage[3];
    for (int i=0; i < shellImg.length; i++) {
      shellImg[i] = loadImage("Enemies/Soldier/shell"+i+".png");
    }
  }

  void display(Mario theMario) {
    // Displays the SoldierEnemy...
    
    imageMode(CENTER);

    if (!deathEnabled) {
      soldierMoving();
    } else {
      soldierDies(theMario);
    }
  }

  void walkingLeft() {
    // Displays the Left walking Images (Animation)...
    
    if (leftWalkingState == 0) image(LeftWalkImg[0], location.x, location.y);
    else if (leftWalkingState == 1) image(LeftWalkImg[1], location.x, location.y);

    if (frameCount % 30 == 0) {                                                              // is true every 30 frames...
      leftWalkingState ++;

      if (leftWalkingState == 2) {
        leftWalkingState = 0;
      }
    }
  }

  void walkingRight() {
    // Displays the Right walking Images (Animation)...
    
    if (rightWalkingState == 0) image(rightWalkImg[0], location.x, location.y);
    else if (rightWalkingState == 1) image(rightWalkImg[1], location.x, location.y);

    if (frameCount % 30 == 0) {                                                          // is true every 30 frames...
      rightWalkingState ++;

      if (rightWalkingState == 2) {
        rightWalkingState = 0;
      }
    }
  }

  void soldierMoving() {
    // Displays the SoldierEnemy movements and other images of it at certain condition...
    
    if (!movingRight) {
      walkingLeft();
    } else {
      walkingRight();
    }
  }

  void shellImage() {
    // Displays the shell images...
    
    vel.x = 0;
    image(shellImg[0], location.x, location.y);
  }

  void shellMovement(Mario theMario) {
    // Displays the shell movement images...
    
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
    
    if (frameCount % 5 == 0) {                                                    // is true every 5 frames...
      shellImgState ++;
      if (shellImgState == 3) {
        shellImgState = 0;
      }
    }
  }

  void soldierDies(Mario theMario) {
    // Displays the shell images of the enemy...
    
    dimension = new PVector(36, 36);
    imageMode(CENTER);
    
    if (hitCounter == 1) {
      shellImage();
    } 
    else if (hitCounter == 2) { 
      shellMovement(theMario);
    } 
    else if (hitCounter == 3) {
      shellImage();  
      hitCounter = 1;
      hitOnce = false;
    }
  }

  void marioAndSoldierCollision(Mario theMario) {
    // Checks if the mario and the soldier is creating collision...
    
    PVector charLocation = new PVector(theMario.location.x, theMario.location.y);
    PVector enemyLocation = new PVector(location.x, location.y);

    float distX = dist (charLocation.x, charLocation.y, location.x, charLocation.y);
    float distY = dist (charLocation.x, charLocation.y, charLocation.x, location.y);

    if (distX <= width/2+110) {                                                        // adds the soldier enemy by setting displaySoldier to (true);
      displaySoldier = true;
    }

    if (charLocation.x < enemyLocation.x && distX >= 0) {              // sets the distX to (-);
      distX *= -1;
    }
    if (charLocation.y < enemyLocation.y && distY >= 0) {              // sets the distY to (-);
      distY *= -1;
    }
    
    // FINDS THE OVERLAY...
    float overlapX = (theMario.dimension.x/2 + dimension.x/2) - (abs(distX));
    float overlapY = (theMario.dimension.y/2 + dimension.y/2) - (abs(distY));
    
    // IF CREATES COLLISION...
    if ((abs(distX) < theMario.dimension.x/2+dimension.x/2) && (abs(distY) < theMario.dimension.y/2+dimension.y/2)) {
      if (overlapX >= overlapY) {      // if creates top or bot collision...
        if (distY < 0) {        // if creates top collision...
          sound.marioKickAudio.rewind();
          sound.marioKickAudio.play();
          theMario.location.y = location.y-dimension.y/2-theMario.dimension.y/2;
          theMario.vel.y = -11;          
          deathEnabled = true;
          hitCounter++;
        } else if (distY > 0) {      // if creates bot collision...
          theMario.marioDies = true;
        }
      } else {                              // if creates left or right collision...
        if (distX < 0 || distX > 0) {
          theMario.marioDies = true;
        }
      }
    }
  }
}