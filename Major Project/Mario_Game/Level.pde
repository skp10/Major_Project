class Level {
  
  // DECLARES EXTRAOBJECTS CLASS...
  ExtraObjects extObjs;
  
  // DECLARES 2D ARRAY TILES...
  Tile[][] thetile;
  
  // UNIVERSAL VAR(S)...
  PVector numOfTiles;
  float tileWidth, tileHeight;

  PVector grav;
  
  Level(String file, PVector grav) {
    // Constructor that sets up the data...
    
    this.grav = grav;

    extObjs = new ExtraObjects(grav);
    
    String[] lines = loadStrings(file);                

    numOfTiles = new PVector(lines[0].length(), lines.length);

    tileWidth = 33;
    tileHeight = height/numOfTiles.y;

    thetile = new Tile[int(numOfTiles.x)][int(numOfTiles.y)];
    
    // READS THE TEXT FILE AND GIVES EACH CHARACTER AN INDIVIDUAL IDENTITY...
    for (int y=0; y < numOfTiles.y; y++) {                                                  
      for (int x=0; x < numOfTiles.x; x++) {
        char character = lines[y].charAt(x);
        if (character == 'k') {                                                                                         // if is Koopa....
          extObjs.koopas.add(new Koopa(new PVector(x*tileHeight, y*tileWidth), new PVector(1, 0), 0.3)); 
        }
        else if (character == 's') {                                                                                    // if is SoldierEnemy...
          extObjs.soldiers.add(new SoldierEnemy(new PVector(x*tileHeight, y*tileWidth), new PVector(1, 0), 0.3));  
        }
        thetile[x][y] = new Tile(x*tileWidth, y*tileHeight, tileWidth, tileHeight, character);
      }
    }
  }

  void display(Mario theMario, SoundTrack theSound) {
    // Displays the each character of the textfile...
    
    for (int y=0; y < numOfTiles.y; y++) {
      for (int x=0; x < numOfTiles.x; x++) {
        thetile[x][y].display(grav, theMario, extObjs.koopas, extObjs.soldiers, theSound);
      }
    }
    extObjs.display(theMario);
  }
}