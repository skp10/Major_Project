class Koopa extends Characters {
  
  // PROPERTIES OF THE KOOPA...
  PVector dimension;
  
  // KOOPA WALKING IMAGE...
  int imgLength;
  PImage enemyWalkRight[];
  PImage enemyWalkLeft[];

  int hitCounter;
  int koopaShellState;
  PImage koopaShellImg[];
  
  // UNIVERSAL BOOLEAN VARIABLES...
  boolean hitOnce;
  boolean movingRight;
  boolean displayKoopa;
  boolean deathEnabled;
  
  // KOOPA WALKING STATE...
  int walkingLeftState;
  int walkingRightState;
  
  boolean completelyDead;

  Koopa(PVector location, PVector vel, float mass) {
    // Constructor that sets up the data...
    
    super(location, vel, mass);
    isEnemy = true;

    dimension = new PVector(36, 61);

    koopaShellImg = new PImage[4];

    imgLength = 2;
    enemyWalkRight = new PImage[imgLength];
    enemyWalkLeft = new PImage[imgLength];

    // LOADS KOOPA IMAGES...
    for (int i=0; i < imgLength; i++) {   
      enemyWalkLeft[i] = loadImage("Enemies/Koopa/Shell/koopaLeft"+i+".png");
      enemyWalkRight[i] = loadImage("Enemies/Koopa/Shell/koopaRight"+i+".png");
    }
    for (int i=0; i < koopaShellImg.length; i++) {
      koopaShellImg[i] = loadImage("Enemies/Koopa/Shell/shell"+i+".png");
    }
  }

  void display(Mario theMario) {
    // Displays koopa images...
    
    if (!deathEnabled) {
      koopaMoving();
    } else {
      koopaDies(theMario);
    }
  }

  void walkLeft() {
    // Displays Walking Left images...
    
    imageMode(CENTER);
    if (walkingLeftState == 0) {
      image(enemyWalkLeft[0], location.x, location.y);
    } else if (walkingLeftState == 1) {
      image(enemyWalkLeft[1], location.x, location.y);
    }
    if (frameCount % 30 == 0) {        // is true every 30 frames...
      walkingLeftState ++;
      if (walkingLeftState == 2) {
        walkingLeftState = 0;
      }
    }
  }

  void walkRight() {
    //DISPLAYS WALKING RIGHT IMAGES...
    
    imageMode(CENTER);
    if (walkingRightState == 0) {
      image(enemyWalkRight[0], location.x, location.y);
    } else if (walkingRightState == 1) {
      image(enemyWalkRight[1], location.x, location.y);
    }
    if (frameCount % 30 == 0) {          // Is true every 30 frames...
      walkingRightState ++;
      if (walkingRightState == 2) {
        walkingRightState = 0;
      }
    }
  }

  void koopaMoving() {
    // Checks if the koopa is moving Right or Left...
    
    if (!movingRight) {
      walkLeft();
    } else {
      walkRight();
    }
  }

  void shellImage() {
    vel.x = 0;
    image(koopaShellImg[0], location.x, location.y);
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
    if (koopaShellState == 0) {
      image(koopaShellImg[0], location.x, location.y);
    } else if (koopaShellState == 1) {
      image(koopaShellImg[1], location.x, location.y);
    } else if (koopaShellState == 2) {
      image(koopaShellImg[2], location.x, location.y);
    } else if (koopaShellState == 3) {
      image(koopaShellImg[3], location.x, location.y);
    }
    if (frameCount % 5 == 0) {
      koopaShellState ++;
      if (koopaShellState == 4) {
        koopaShellState = 0;
      }
    }
  }

  void koopaDies(Mario theMario) {
    dimension = new PVector(36, 36);
    
    imageMode(CENTER);
    if (hitCounter == 1) {                                                  // checks the hitCounter value and interacts accordingly...
      shellImage();
    } else if (hitCounter == 2) { 
      shellMovement(theMario);
    } else if (hitCounter == 3) {
      shellImage();  
      hitCounter = 1;
      hitOnce = false;
    }
  }

  void marioAndKoopaCollision(Mario theMario) {
    // Checks for Koopa and Mario collision detection...
    
    PVector charLocation = new PVector(theMario.location.x, theMario.location.y);                          // Mario location...
    PVector enemyLocation = new PVector(location.x, location.y);                                           // Koopa location...
    
    // DISTANCES OF THE MARIO AND KOOPA...
    float distX = dist (charLocation.x, charLocation.y, location.x, charLocation.y);              
    float distY = dist (charLocation.x, charLocation.y, charLocation.x, location.y);

    if (distX <= width/2+110) {                                // Adds Koopa by setting displayKoopa to true...
      displayKoopa = true;
    }

    if (charLocation.x < enemyLocation.x && distX >= 0) {      // Sets the dist(X) to (-);
      distX *= -1;
    }
    if (charLocation.y < enemyLocation.y && distY >= 0) {      // Sets the dist(y) (+);  
      distY *= -1;
    }
    
    // Finds the overlap of the mario and koopa...
    float overlapX = (theMario.dimension.x/2 + dimension.x/2) - (abs(distX));
    float overlapY = (theMario.dimension.y/2 + dimension.y/2) - (abs(distY));
    
    // CHECKS IF IT CREATES COLLISION...
    if ((abs(distX) < theMario.dimension.x/2+dimension.x/2) && (abs(distY) < theMario.dimension.y/2+dimension.y/2)) {
      if (overlapX >= overlapY) {          // If the creating top or bot collision...
        if (distY < 0) {            // if creating top collision...
          sound.marioKickAudio.rewind();
          sound.marioKickAudio.play();
          theMario.location.y = location.y-dimension.y/2-theMario.dimension.y/2;
          theMario.vel.y = -11;          
          deathEnabled = true;
          hitCounter++;
        } else if (distY > 0) {    // if creating bot collision... 
          theMario.marioDies = true;
        }
      } else {                          // if creating left or right collision...
        if (distX < 0 || distX > 0) {
          theMario.marioDies = true;
        }
      }
    }
  }
}