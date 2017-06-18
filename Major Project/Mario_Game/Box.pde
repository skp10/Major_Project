class Box extends Grass {

  // PROPERTIES OF THE BOX...
  PVector location;
  PVector originalLocation;
  PVector dimension;
  float mass;

  PVector vel;
  PVector ac;

  float marioJumpVelocity;

  // USED FOR OBJECTS THAT EXTEND BOX...
  boolean questionBoxCheck;
  boolean spinnerBoxCheck;

  //UNIVERSAL VARIABLE...
  boolean collisionEnabled;
  boolean stateChangerEnabled;
  int timePassed;

  boolean botCollision;
  int numOfHits;

  boolean isEmptyBox;

  Box() {
    // Constructor that sets up data...

    location = new PVector(0, 0);
    dimension = new PVector(33, 33);
    ac = new PVector(0, 0);

    marioJumpVelocity = -16;

    numOfHits = int(random(1, 5));
  }

  void move() {
    // Properties of the box is implemented...

    vel.add(ac);
    ac.y = 0;
    location.y += vel.y;
    ac.mult(0);
  }

  void addforce(PVector force) {
    // Adds force to the accleration : EX, GRAVITY...

    PVector f = PVector.div(force, mass);
    ac.add(f);
  }

  void marioAllWayCollision(Mario theMario, SoundTrack theSound) {
    // Collision Detection with the Mario (All side Collision)...

    super.location.x = location.x;
    super.location.y = location.y;
    super.marioTopCollision(theMario, theSound);

    //FINDS CHARACTER AND THE OBJECT LOCATION...
    PVector charLocation = new PVector(theMario.location.x, theMario.location.y);
    PVector objLocation = new PVector(location.x+dimension.x/2, location.y+dimension.y/2);

    float distX = dist (charLocation.x, charLocation.y, objLocation.x, charLocation.y);
    float distY = dist (charLocation.x, charLocation.y, charLocation.x, objLocation.y);

    if (charLocation.x < objLocation.x && distX > 0) {                                  // SETS THE DIST(X) (-)...
      distX *= -1;
    }
    if (charLocation.y < objLocation.y && distY > 0) {                                  // SETS THE DIST(Y) (-)...
      distY *= -1;
    }

    float overlapX = (theMario.dimension.x/2 + dimension.x/2) - (abs(distX));           // Finds the overlap...
    float overlapY = (theMario.dimension.y/2 + dimension.y/2) - (abs(distY));

    if ((abs(distX) < theMario.dimension.x/2+dimension.x/2) && (abs(distY) < theMario.dimension.y/2+dimension.y/2)) {        // Checks if it is creating collision...
      if (overlapX >= overlapY) {            //Checks if it is creating top or bottom collision...
        if (distY < 0) {            // Checks if it is creating top collision...
          theMario.vel.y = 0;
          theMario.ac.y = 0;
          theMario.jumpingImgState = false;

          if (theMario.jumping) {
            theMario.vel.y = marioJumpVelocity;
          }
          theMario.location.y = location.y-theMario.dimension.y/2;
        } else if (distY > 0 && theMario.vel.y < 0) {                  // Checks if it is creating bot collision...
          theMario.vel.y = 0;
          theMario.ac.y = 0;
          theMario.location.y = location.y+dimension.y+theMario.dimension.y/2;
          if ((numOfHits > 0 || !questionBoxCheck) && !isEmptyBox) {
            vel.y = -5;
          }
          if (questionBoxCheck && numOfHits > 0) {              // if it is question box...
            theSound.coinCollectAudio.rewind();
            theSound.coinCollectAudio.play();
            coinPointsCounter += 300;
          }
          botCollision = true;
          numOfHits --;

          if (spinnerBoxCheck) {                            // if it is spinner box...
            collisionEnabled = false;
            stateChangerEnabled = true;
            timePassed = millis();
          }
        }
      } else {                        // Checks if it is creating left or right collision...
        if (distX < 0) {
          theMario.location.x = location.x-theMario.dimension.x/2;
        } else if (distX > 0) {
          theMario.location.x = location.x+dimension.x+theMario.dimension.x/2;
        }
      }
    }
  }

  void koopaAllWayCollision(ArrayList<Koopa> koopas) {                              // USES THE SAME COLLISION DETECTION ALGORITHM AS ABOVE (MARIO AND BOX)...
    // Koopa collision with the box...

    for (int i = koopas.size()-1; i >= 0; i--) {
      Koopa koop = koopas.get(i);
      if (!koop.completelyDead) {
        super.location.x = location.x;
        super.location.y = location.y;
        super.koopaTopCollision(koopas);

        PVector charLocation = new PVector(koop.location.x, koop.location.y);
        PVector objLocation = new PVector(location.x+dimension.x/2, location.y+dimension.y/2);

        float distX = dist (charLocation.x, charLocation.y, objLocation.x, charLocation.y);
        float distY = dist (charLocation.x, charLocation.y, charLocation.x, objLocation.y);

        if (charLocation.x < objLocation.x && distX > 0) {
          distX *= -1;
        }
        if (charLocation.y < objLocation.y && distY > 0) {
          distY *= -1;
        }

        float overlapX = (koop.dimension.x/2 + dimension.x/2) - (abs(distX));
        float overlapY = (koop.dimension.y/2 + dimension.y/2) - (abs(distY));

        if ((abs(distX) < koop.dimension.x/2+dimension.x/2) && (abs(distY) < koop.dimension.y/2+dimension.y/2)) {
          if (overlapX >= overlapY) {
            if (distY < 0) {
              koop.vel.y = 0;
              koop.ac.y = 0;
              koop.location.y = location.y-koop.dimension.y/2;
            } else if (distY > 0) {
              koop.vel.y = 0;
              koop.ac.y = 0;
              koop.location.y = location.y+dimension.y+koop.dimension.y/2;
            }
          } else {
            if (distX < 0) {
              koop.location.x = location.x - koop.dimension.x/2;
              koop.vel.x *= -1;
              koop.movingRight = !koop.movingRight;
            }
            if (distX > 0) {
              koop.location.x = location.x + dimension.x + koop.dimension.x/2;
              koop.vel.x *= -1;
              koop.movingRight = !koop.movingRight;
            }
          }
        }
      }
    }
  }

  void soldierAllWayCollision(ArrayList<SoldierEnemy> soldiers) {                          // USES THE SAME COLLISION DETECTION CODE AGAIN...
    // Soldier enemy collision with the box...

    for (int i = soldiers.size()-1; i >= 0; i--) {
      SoldierEnemy theSoldier = soldiers.get(i);

      if (!theSoldier.completelyDead) {
        super.location.x = location.x;
        super.location.y = location.y;
        super.soldierTopCollision(soldiers);

        PVector charLocation = new PVector(theSoldier.location.x, theSoldier.location.y);
        PVector objLocation = new PVector(location.x+dimension.x/2, location.y+dimension.y/2);

        float distX = dist (charLocation.x, charLocation.y, objLocation.x, charLocation.y);
        float distY = dist (charLocation.x, charLocation.y, charLocation.x, objLocation.y);

        if (charLocation.x < objLocation.x && distX > 0) {
          distX *= -1;
        }
        if (charLocation.y < objLocation.y && distY > 0) {
          distY *= -1;
        }

        float overlapX = (theSoldier.dimension.x/2 + dimension.x/2) - (abs(distX));
        float overlapY = (theSoldier.dimension.y/2 + dimension.y/2) - (abs(distY));

        if ((abs(distX) < theSoldier.dimension.x/2+dimension.x/2) && (abs(distY) < theSoldier.dimension.y/2+dimension.y/2)) {
          if (overlapX >= overlapY) {
            if (distY < 0) {
              theSoldier.vel.y = 0;
              theSoldier.ac.y = 0;
              theSoldier.location.y = location.y-theSoldier.dimension.y/2;
            } else if (distY > 0) {
              theSoldier.vel.y = 0;
              theSoldier.ac.y = 0;
              theSoldier.location.y = location.y+dimension.y+theSoldier.dimension.y/2;
            }
          } else {
            if (distX < 0) {
              theSoldier.location.x = location.x - theSoldier.dimension.x/2;
              theSoldier.vel.x *= -1;
              theSoldier.movingRight = !theSoldier.movingRight;
            }
            if (distX > 0) {
              theSoldier.location.x = location.x + dimension.x + theSoldier.dimension.x/2;
              theSoldier.vel.x *= -1;
              theSoldier.movingRight = !theSoldier.movingRight;
            }
          }
        }
      }
    }
  }
}