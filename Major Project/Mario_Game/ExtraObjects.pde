class ExtraObjects {

  // DECLARES DIFFERENT OBJECT ARRAYLISTS...
  ArrayList<Koopa> koopas;
  ArrayList<SoldierEnemy> soldiers;
  PVector grav;  

  ExtraObjects(PVector grav) {
    // Constructor that sets up the data...

    this.grav = grav;

    // INITIALIZES THE OBJECT ARRAYLIST...
    koopas = new ArrayList<Koopa>();   
    soldiers = new ArrayList<SoldierEnemy>();
  }

  void display(Mario theMario) {
    // Displays different objects and does different interaction...
    koopaWithKoopaCollision();
    koopaWithSoldierCollision();
    soldierWithSoldierCollision();

    koopaInteraction(theMario);
    soldierEnemyInteraction(theMario);
  }

  void koopaWithKoopaCollision() {
    // Koopa creation collision with another koopa...

    for (int i = koopas.size()-1; i >= 0; i--) {
      Koopa koopi = koopas.get(i);

      for (int j = koopas.size()-1; j >= 0 && j != i; j--) {
        Koopa koopj = koopas.get(j);

        float distX = dist(koopi.location.x, koopi.location.y, koopj.location.x, koopi.location.y);
        float distY = dist(koopi.location.x, koopi.location.y, koopi.location.x, koopj.location.y);

        if (distX <= koopi.dimension.x/2 && distY <= koopi.dimension.y/2) {
          if (koopj.hitCounter == 2) {
            koopi.vel.y = -5;
            koopi.completelyDead = true;
          } else if (koopi.hitCounter == 2) {
            koopj.vel.y = -5;
            koopj.completelyDead = true;
          }
        }
      }
    }
  }

  void koopaWithSoldierCollision() {
    // Soldier creating collision with koopa...

    for (int i = koopas.size()-1; i >= 0; i--) {
      Koopa koop = koopas.get(i);

      for (int j = soldiers.size()-1; j >= 0; j--) {
        SoldierEnemy theSoldier = soldiers.get(j);

        float distX = dist(koop.location.x, koop.location.y, theSoldier.location.x, koop.location.y);
        float distY = dist(koop.location.x, koop.location.y, koop.location.x, theSoldier.location.y);

        if (distX <= koop.dimension.x/2+theSoldier.dimension.x/2 && distY <= koop.dimension.x/2+theSoldier.dimension.y/2) {
          if (koop.hitCounter == 2) {
            theSoldier.vel.y = -5;
            theSoldier.completelyDead = true;
          } else if (theSoldier.hitCounter == 2) {
            koop.vel.y = -5;
            koop.completelyDead = true;
          }
        }
      }
    }
  }

  void soldierWithSoldierCollision() {
    // Soldier creating collision with another soldier...

    for (int i = soldiers.size()-1; i >= 0; i--) {
      SoldierEnemy theSoldieri = soldiers.get(i);

      for (int j = soldiers.size()-1; j >= 0 && j != i; j--) {
        SoldierEnemy theSoldierj = soldiers.get(j);

        float distX = dist(theSoldieri.location.x, theSoldieri.location.y, theSoldierj.location.x, theSoldieri.location.y);
        float distY = dist(theSoldieri.location.x, theSoldieri.location.y, theSoldieri.location.x, theSoldierj.location.y);

        if (distX <= theSoldieri.dimension.x/2 && distY <= theSoldieri.dimension.y/2) {
          if (theSoldierj.hitCounter == 2) {
            theSoldieri.vel.y = -5;
            theSoldieri.completelyDead = true;
          } else if (theSoldieri.hitCounter == 2) {
            theSoldierj.vel.y = -5;
            theSoldierj.completelyDead = true;
          }
        }
      }
    }
  }

  void koopaInteraction(Mario theMario) {
    // Koopa interacts according to its properties... 

    for (int i = koopas.size()-1; i >= 0; i--) {
      Koopa theKoopa = koopas.get(i);
      if (theKoopa.displayKoopa) {
        theKoopa.display(theMario);     
        theKoopa.move();
        theKoopa.addforce(grav);
      }
      if (!theMario.marioDies) {
        theKoopa.marioAndKoopaCollision(theMario);
      }
      if (theKoopa.location.y >= height) {
        koopas.remove(i);
      }
    }
  }

  void soldierEnemyInteraction(Mario theMario) {
    // Soldier enemy interacts according to its properties...

    for (int i = soldiers.size()-1; i >= 0; i--) {
      SoldierEnemy theSoldier = soldiers.get(i);

      if (theSoldier.displaySoldier) {
        theSoldier.display(theMario);
        theSoldier.move();
        theSoldier.addforce(grav);
      }
      if (!theMario.marioDies) {
        theSoldier.marioAndSoldierCollision(theMario);
      }
      if (theSoldier.location.y >= height) {
        soldiers.remove(i);
      }
    }
  }
}