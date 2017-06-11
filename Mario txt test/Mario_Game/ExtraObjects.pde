class ExtraObjects {
  
  ArrayList<Koopa> koopas;
  PVector grav;  
  
  ExtraObjects(PVector grav) {
    this.grav = grav;
    
    koopas = new ArrayList<Koopa>();   
  }
  
  void display(Mario theMario) {
    for (int i=0; i<koopas.size(); i++) {
      Koopa theKoopa = koopas.get(i);
      
      if (theKoopa.displayKoopa) {
        theKoopa.display(theMario);     
        theKoopa.move();
        theKoopa.addforce(grav);
      }
      theKoopa.marioAndKoopaCollision(theMario);
    }
    //for (int i=0; i< koopas.size(); i++) {
    //  Koopa koopi = koopas.get(i);
    //  for (int j=0; j <koopas.size() && j != i; j++) {
    //    Koopa koopj = koopas.get(j);
        
    //    float distX = dist(koopi.location.x, koopi.location.y, koopj.location.x, koopi.location.y);
    //    float distY = dist(koopi.location.x, koopi.location.y, koopi.location.x, koopj.location.y);
        
    //    if (distX <= koopi.dimension.x/2 && distY <= koopi.dimension.y/2) {
    //      koopi.vel.x *= -1;
    //      koopi.movingRight = !koopi.movingRight;
    //    }
    //  }
    //}
  }
}