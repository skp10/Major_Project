class Grass extends Box {

  Grass() {
    super();
  }

  void marioTopGrassCollision(Mario themario) {    
    PVector charPoint1 = new PVector(themario.location.x-themario.dimension.x/2, themario.location.y+themario.dimension.y/2);
    PVector charPoint2 = new PVector(themario.location.x+themario.dimension.x/2, themario.location.y+themario.dimension.y/2);

    PVector objPoint1 = new PVector(location.x, location.y);
    PVector objPoint2 = new PVector(location.x+dimension.x, location.y);


    if ((themario.vel.y >= 0) && (charPoint1.y > objPoint1.y && charPoint1.y < objPoint1.y+30) && (charPoint2.x > objPoint1.x) && (charPoint1.x < objPoint2.x)) {
      themario.jumpingImgState = false;
      themario.vel.y = 0;
      themario.ac.y = 0;
      themario.location.y = location.y-themario.dimension.y/2;

      if (themario.jumping) {
        themario.vel.y = marioJumpVelocity;
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
}