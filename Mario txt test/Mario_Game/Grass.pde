class Grass {

  PVector location;
  PVector dimension;

  float marioJumpVelocity;

  Grass() {
    location = new PVector(0, 0);
    dimension = new PVector(33, 33);

    marioJumpVelocity = -16;
  }

  void marioTopGrassCollision(Mario theMario) {    
    PVector charPoint1 = new PVector(theMario.location.x-theMario.dimension.x/2, theMario.location.y+theMario.dimension.y/2);
    PVector charPoint2 = new PVector(theMario.location.x+theMario.dimension.x/2, theMario.location.y+theMario.dimension.y/2);

    PVector objPoint1 = new PVector(location.x, location.y);
    PVector objPoint2 = new PVector(location.x+dimension.x, location.y);


    if ((theMario.vel.y >= 0) && (charPoint1.y > objPoint1.y && charPoint1.y < objPoint1.y+30) && (charPoint2.x > objPoint1.x) && (charPoint1.x < objPoint2.x)) {
      theMario.jumpingImgState = false;
      theMario.vel.y = 0;
      theMario.ac.y = 0;
      theMario.location.y = location.y-theMario.dimension.y/2;

      if (theMario.jumping) {
        theMario.vel.y = marioJumpVelocity;
      }
    }
  }

  void marioAllWayCollision(Mario theMario) {
    PVector charLocation = new PVector(theMario.location.x, theMario.location.y);
    PVector objLocation = new PVector(location.x+dimension.x/2, location.y+dimension.y/2);

    float distX = dist (charLocation.x, charLocation.y, objLocation.x, charLocation.y);
    float distY = dist (charLocation.x, charLocation.y, charLocation.x, objLocation.y);

    if (charLocation.x < objLocation.x && distX > 0) {
      distX *= -1;
    }
    if (charLocation.y < objLocation.y && distY > 0) {
      distY *= -1;
    }

    float overlapX = (theMario.dimension.x/2 + dimension.x/2) - (abs(distX));
    float overlapY = (theMario.dimension.y/2 + dimension.y/2) - (abs(distY));

    if ((abs(distX) < theMario.dimension.x/2+dimension.x/2) && (abs(distY) < theMario.dimension.y/2+dimension.y/2)) {
      if (overlapX >= overlapY) {
        if (distY < 0) {
          theMario.vel.y = 0;
          theMario.ac.y = 0;
          theMario.jumpingImgState = false;
          if (theMario.jumping) {
            theMario.vel.y = marioJumpVelocity;
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

  void koopaTopGrassCollision(ArrayList<Koopa> theKoop) {
    for (int i=theKoop.size()-1; i >= 0; i--) {
      Koopa koop = theKoop.get(i);

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

  void koopaAllWayCollision(ArrayList<Koopa> theKoop) {
    for (int i = theKoop.size()-1; i >= 0; i--) {
      Koopa koop = theKoop.get(i);
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
  
    void soldierTopGrassCollision(ArrayList<SoldierEnemy> soldiers) {
    for (int i=soldiers.size()-1; i >= 0; i--) {
      SoldierEnemy theSoldier = soldiers.get(i);

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

  void soldierAllWayCollision(ArrayList<SoldierEnemy> soldiers) {
    for (int i = soldiers.size()-1; i >= 0; i--) {
      SoldierEnemy theSoldier = soldiers.get(i);
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