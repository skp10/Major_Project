class Grass {

  // PROPERTIES OF THE GRASS...
  PVector location;
  PVector dimension;

  float marioJumpVelocity;

  Grass() {
    // Constructor that sets up the data...

    location = new PVector(0, 0);
    dimension = new PVector(33, 33);

    marioJumpVelocity = -16;
  }

  void marioTopCollision(Mario theMario, SoundTrack theSound) {  
    // checks for the Mario and top line of the grass is creating collision...

    // TOP LINE POINTS...      (MARIO)...
    PVector charPoint1 = new PVector(theMario.location.x-theMario.dimension.x/2, theMario.location.y+theMario.dimension.y/2);
    PVector charPoint2 = new PVector(theMario.location.x+theMario.dimension.x/2, theMario.location.y+theMario.dimension.y/2);

    // TOP LINE POINTS...      (ENEMY)....
    PVector objPoint1 = new PVector(location.x, location.y);
    PVector objPoint2 = new PVector(location.x+dimension.x, location.y);

    // IF CREATING COLLISION...
    if ((theMario.vel.y >= 0) && (charPoint1.y > objPoint1.y && charPoint1.y < objPoint1.y+30) && (charPoint2.x > objPoint1.x) && (charPoint1.x < objPoint2.x)) {
      theMario.jumpingImgState = false;
      theMario.vel.y = 0;
      theMario.ac.y = 0;
      theMario.location.y = location.y-theMario.dimension.y/2;
      if (!levelCompleted) {
        if (theMario.jumping) {                  // if mario is jumping...
          theSound.marioJumpAudio.rewind();
          theSound.marioJumpAudio.play();
          theMario.vel.y = marioJumpVelocity;
        }
      }
    }
  }

  void marioAllWayCollision(Mario theMario, SoundTrack theSound) {
    // If mario is creating all side collision of the grass...

    // LOCATION OF THE MARIO AND THE GRASS...
    PVector marioLocation = new PVector(theMario.location.x, theMario.location.y);              
    PVector objLocation = new PVector(location.x+dimension.x/2, location.y+dimension.y/2);

    // FINDS THE DIST OF THE GRASS AND THE MARIO...
    float distX = dist (marioLocation.x, marioLocation.y, objLocation.x, marioLocation.y);
    float distY = dist (marioLocation.x, marioLocation.y, marioLocation.x, objLocation.y);

    if (marioLocation.x < objLocation.x && distX > 0) {              // Sets the dist(X) to (-)...
      distX *= -1;
    }
    if (marioLocation.y < objLocation.y && distY > 0) {              // Sets the dist(X) to (-)...
      distY *= -1;
    }

    float overlapX = (theMario.dimension.x/2 + dimension.x/2) - (abs(distX));
    float overlapY = (theMario.dimension.y/2 + dimension.y/2) - (abs(distY));

    // CHECKS IF CREATING COLLISION...
    if ((abs(distX) < theMario.dimension.x/2+dimension.x/2) && (abs(distY) < theMario.dimension.y/2+dimension.y/2)) {
      if (overlapX >= overlapY) {
        if (distY < 0) {
          theMario.vel.y = 0;
          theMario.ac.y = 0;
          theMario.jumpingImgState = false;
          if (!levelCompleted) {
            if (theMario.jumping) {
              theSound.marioJumpAudio.rewind();
              theSound.marioJumpAudio.play();
              theMario.vel.y = marioJumpVelocity;
            }
          }
          theMario.location.y = location.y-theMario.dimension.y/2;
        } else if (distY > 0) {
          theMario.vel.y = 0;
          theMario.ac.y = 0;
          theMario.location.y = location.y+dimension.y+theMario.dimension.y/2;
        }
      } else {
        if (distX < 0) {
          theMario.location.x = location.x-theMario.dimension.x/2;
        } else if (distX > 0) {
          theMario.location.x = location.x+dimension.x+theMario.dimension.x/2;
        }
      }
    }
  }

  void koopaTopCollision(ArrayList<Koopa> koopas) {   //------------------------- USES THE SAME COLLISION DETECTION FROM THE ABOVE TWO FUNCTIONS...---------------------------------//
    // Checks if the koopa is creating collision to the top line of the grass...
    for (int i=koopas.size()-1; i >= 0; i--) {
      Koopa koop = koopas.get(i);

      if (!koop.completelyDead) {
        PVector charPoint1 = new PVector(koop.location.x-koop.dimension.x/2, koop.location.y+koop.dimension.y/2);
        PVector charPoint2 = new PVector(koop.location.x+koop.dimension.x/2, koop.location.y+koop.dimension.y/2);

        PVector objPoint1 = new PVector(location.x, location.y);
        PVector objPoint2 = new PVector(location.x+dimension.x, location.y);


        if ((koop.vel.y >= 0) && (charPoint1.y > objPoint1.y && charPoint1.y < objPoint1.y+30) && (charPoint2.x > objPoint1.x) && (charPoint1.x < objPoint2.x)) {
          koop.vel.y = 0;
          koop.ac.y = 0;
          koop.location.y = location.y-koop.dimension.y/2;
        }
      }
    }
  }

  void koopaAllWayCollision(ArrayList<Koopa> koopas) {
    // Checks if the koopa is creating collision to all the sides of the object...

    for (int i = koopas.size()-1; i >= 0; i--) {
      Koopa koop = koopas.get(i);

      if (!koop.completelyDead) {
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

  void soldierTopCollision(ArrayList<SoldierEnemy> soldiers) {
    // Checks if the soldier is creating collision to the top line of the grass...

    for (int i=soldiers.size()-1; i >= 0; i--) {
      SoldierEnemy theSoldier = soldiers.get(i);
      if (!theSoldier.completelyDead) {
        PVector charPoint1 = new PVector(theSoldier.location.x-theSoldier.dimension.x/2, theSoldier.location.y+theSoldier.dimension.y/2);
        PVector charPoint2 = new PVector(theSoldier.location.x+theSoldier.dimension.x/2, theSoldier.location.y+theSoldier.dimension.y/2);

        PVector objPoint1 = new PVector(location.x, location.y);
        PVector objPoint2 = new PVector(location.x+dimension.x, location.y);


        if ((theSoldier.vel.y >= 0) && (charPoint1.y > objPoint1.y && charPoint1.y < objPoint1.y+30) && (charPoint2.x > objPoint1.x) && (charPoint1.x < objPoint2.x)) {
          theSoldier.vel.y = 0;
          theSoldier.ac.y = 0;
          theSoldier.location.y = location.y-theSoldier.dimension.y/2;
        }
      }
    }
  }

  void soldierAllWayCollision(ArrayList<SoldierEnemy> soldiers) {
    // Check for soldier creating collision allway/ all sides of the grass...

    for (int i = soldiers.size()-1; i >= 0; i--) {
      SoldierEnemy theSoldier = soldiers.get(i);

      if (!theSoldier.completelyDead) {
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