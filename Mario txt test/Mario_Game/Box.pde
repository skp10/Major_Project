class Box {

  PVector location;
  PVector dimension;

  PVector vel;
  PVector ac;
  float mass;

  float marioJumpVelocity;

  Box() {
    location = new PVector(0, 0);
    dimension = new PVector(33, 33);

    marioJumpVelocity = -16;
  }

  void move() {
    vel.add(ac);
    ac.y = 0;
    location.y += vel.y;
    ac.mult(0);
  }

  void addforce(PVector force) {
    PVector f = PVector.div(force, mass);
    ac.add(f);
  }

  void marioAllWayCollision(Mario themario) {
    PVector charLocation = new PVector(themario.location.x, themario.location.y);
    PVector objLocation = new PVector(location.x+dimension.x/2, location.y+dimension.y/2);

    float distX = dist (charLocation.x, charLocation.y, objLocation.x, charLocation.y);
    float distY = dist (charLocation.x, charLocation.y, charLocation.x, objLocation.y);

    if (charLocation.x < objLocation.x && distX > 0) {
      distX *= -1;
    }
    if (charLocation.y < objLocation.y && distY > 0) {
      distY *= -1;
    }

    float overlapX = (themario.dimension.x/2 + dimension.x/2) - (abs(distX));
    float overlapY = (themario.dimension.y/2 + dimension.y/2) - (abs(distY));

    if ((abs(distX) < themario.dimension.x/2+dimension.x/2) && (abs(distY) < themario.dimension.y/2+dimension.y/2)) {
      if (overlapX >= overlapY) {
        if (distY < 0) {
          themario.vel.y = 0;
          themario.ac.y = 0;
          themario.jumpingImgState = false;
          if (themario.jumping) {
            themario.vel.y = marioJumpVelocity;
          }
          themario.location.y = location.y-themario.dimension.y/2;
        } else if (distY > 0) {
          themario.vel.y = 0;
          themario.ac.y = 0;
          themario.location.y = location.y+dimension.y+themario.dimension.y/2;
          vel.y = -7;
        }
      } else {
        if (distX < 0) {
          themario.location.x = location.x-themario.dimension.x/2;
        } else if (distX > 0) {
          themario.location.x = location.x+dimension.x+themario.dimension.x/2;
        }
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
}