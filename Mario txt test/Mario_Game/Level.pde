class Level {
  ExtraObjects extObjs;
  
  Tile[][] thetile;
  PVector numOfTiles;
  float tileWidth, tileHeight;

  PVector grav;
  
  Level(String file, PVector grav) {
    this.grav = grav;

    extObjs = new ExtraObjects(grav);
    
    String[] lines = loadStrings(file);

    numOfTiles = new PVector(lines[0].length(), lines.length);

    tileWidth = 33;
    tileHeight = height/numOfTiles.y;

    thetile = new Tile[int(numOfTiles.x)][int(numOfTiles.y)];

    for (int y=0; y < numOfTiles.y; y++) {
      for (int x=0; x < numOfTiles.x; x++) {
        char character = lines[y].charAt(x);
        thetile[x][y] = new Tile(x*tileWidth, y*tileHeight, tileWidth, tileHeight, character, grav);
      }
    }
  }

  void display(Mario theMario) {
    for (int y=0; y < numOfTiles.y; y++) {
      for (int x=0; x < numOfTiles.x; x++) {
        thetile[x][y].display();
        thetile[x][y].checkCollision(theMario, extObjs.theKoopa);
      }
    }
    extObjs.display(theMario);
  }
}