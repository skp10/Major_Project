class ExtraObjects {
  PVector grav;
  
  ArrayList<Koopa> theKoopa;
  
  PVector enemyVel;
  PVector enemyAc;
  
  final float enemyMass = 0.3; 
  PVector koopaDimension;
  
  ExtraObjects(PVector grav) {
    this.grav = grav;
    
    theKoopa = new ArrayList<Koopa>();
    enemyVel = new PVector(1, 0);
    enemyAc = new PVector(0, 0);
    
    koopaDimension = new PVector();
    
    for (int i=0; i < 10; i++) {  //LOCATION-----------
      theKoopa.add(new Koopa(new PVector(1500, 300), enemyVel, enemyAc, enemyMass));
    }
  }
  
  void display(Mario theMario) {
    Koopa koop0 = theKoopa.get(0);
    koop0.display(theMario);
    koop0.marioAndKoopaCollision(theMario);
    koop0.move();
    koop0.location.x -= koop0.vel.x;
    koop0.addforce(grav);
  }
}