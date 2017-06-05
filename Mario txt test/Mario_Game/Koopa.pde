class Koopa extends Characters {

  PVector dimension;

  int imgLength;
  PImage enemyWalkRight[];
  PImage enemyWalkLeft[];

  int hitCounter;
  int koopaShellState;
  PImage koopaShellImg[];

  boolean hitOnce;
  boolean movingRight;

  boolean deathEnabled;

  int walkingLeftState;
  int walkingRightState;

  Koopa(PVector location, PVector vel, PVector ac, float mass) {
    super(location, vel, ac, mass);

    dimension = new PVector(36, 61);

    koopaShellImg = new PImage[4];

    imgLength = 2;
    enemyWalkRight = new PImage[imgLength];
    enemyWalkLeft = new PImage[imgLength];

    for (int i=0; i < imgLength; i++) {
      enemyWalkLeft[i] = loadImage("Enemies/Koopa/Shell/koopaLeft"+i+".png");
      enemyWalkRight[i] = loadImage("Enemies/Koopa/Shell/koopaRight"+i+".png");
    }
    for (int i=0; i < koopaShellImg.length; i++) {
      koopaShellImg[i] = loadImage("Enemies/Koopa/Shell/shell"+i+".png");
    }
  }

  void display(Mario theMario) {
    if (!deathEnabled) {
      koopaMoving();
    } else {
      koopaDies(theMario);
    }
  }

  void walkLeft() {
    imageMode(CENTER);
    if (walkingLeftState == 0) {
      image(enemyWalkLeft[0], location.x, location.y);
    } else if (walkingLeftState == 1) {
      image(enemyWalkLeft[1], location.x, location.y);
    }
    if (frameCount % 30 == 0) {
      walkingLeftState ++;
      if (walkingLeftState == 2) {
        walkingLeftState = 0;
      }
    }
  }

  void walkRight() {
    imageMode(CENTER);
    if (walkingRightState == 0) {
      image(enemyWalkRight[0], location.x, location.y);
    } else if (walkingLeftState == 1) {
      image(enemyWalkRight[1], location.x, location.y);
    }
    if (frameCount % 30 == 0) {
      walkingRightState ++;
      if (walkingRightState == 2) {
        walkingRightState = 0;
      }
    }
  }

  void koopaMoving() {
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

  void marioAndKoopaCollision(Mario theMario) {
    PVector charLocation = new PVector(theMario.location.x, theMario.location.y);
    PVector enemyLocation = new PVector(location.x, location.y);

    float distX = dist (charLocation.x, charLocation.y, location.x, charLocation.y);
    float distY = dist (charLocation.x, charLocation.y, charLocation.x, location.y);

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
          theMario.vel.y *= -1;          
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