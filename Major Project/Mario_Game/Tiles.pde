class Tile {
  
  // DECLARES THE ARRAYLIST OF THE DIFFERENT OBJECTS...
  ArrayList<Grass> grasses;
  ArrayList<Box> emptyBoxes;
  ArrayList<Muncher> munchers;
  ArrayList<Coin> coins;
  ArrayList<QuestionBox> qBoxes;
  ArrayList<SpinnerBox> spinBoxes;
  ArrayList<LevelComplete> levelDone;
  
  // X AND Y AND WIDTH AND HEIGHT OF THE OBJECT...
  float x, y;
  float w, h;

  char type;
  PImage tileImg;

  int imageState;

  Tile(float x, float y, float w, float h, char type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
    
    // INITIALIZES THE TILE/OBJECTS...
    grasses = new ArrayList<Grass>();
    emptyBoxes = new ArrayList<Box>();
    munchers = new ArrayList<Muncher>();
    coins = new ArrayList<Coin>();
    qBoxes = new ArrayList<QuestionBox>();
    spinBoxes = new ArrayList<SpinnerBox>();
    levelDone = new ArrayList<LevelComplete>();
    
    //ADDS OBJECT...
    addGrass();
    addMuncher();
    addCoin();
    addQuestionBox();
    addSpinnerBox();
    
    if (type == 'o') {                                        // if is EmptyBox...
      emptyBoxes.add(new Box());
      tileImg = loadImage("Items/emptyBox/emptyBox.png");  
    }
    else if (type == 'w') {                                   // if is LevelComplete object...
      levelDone.add(new LevelComplete(x, y));
      tileImg = loadImage("Items/levelComplete.png");  
    }

    if (type == '.') {
      tileImg = null;
    }
  }

  void display(PVector grav, Mario theMario, ArrayList<Koopa> koopas, ArrayList<SoldierEnemy> soldiers, SoundTrack theSound) {
    // Displays the tile of the object...
    
    imageMode(CORNER);
    if (type!= '.' && type != 'v' && type != 'c' && type != '?' && type != '0' && type != 'k' && type != 's') {     
      image(tileImg, x, y);
      grassCollision(theMario, koopas, soldiers, theSound);
    }
    else if (type == 'v') {                          // if munchers...
      for (Muncher theMuncher : munchers) {
        theMuncher.location = new PVector(x, y);
        theMuncher.dimension = new PVector(w, h);
        theMuncher.display();
        if (!theMario.marioDies) {
          theMuncher.marioCollision(theMario);
        }
      }
    }
    else if (type == 'c') {                          // if coins...
      for (Coin theCoin : coins) {
        theCoin.location = new PVector(x, y);
        theCoin.dimension = new PVector(w, h);
        theCoin.display();  
      }
    }
    else if (type == '?') {                          // if is questionBox...
      for (QuestionBox theBox : qBoxes) {
        theBox.display();    
        theBox.addforce(grav);
        theBox.move();
        theBox.collision(theMario, koopas, soldiers, theSound);
      }
    }else if (type == '0') {                        // if is spinnerBox...
      for (SpinnerBox theBox : spinBoxes) {
        theBox.display();
        theBox.addforce(grav);
        theBox.move();
        theBox.checkMillis();
        theBox.collision(theMario, koopas, soldiers, theSound);
      }
    }
    
    // --------------------------------------CHECKS FOR COLLISION -------------------------------------------------------------
    for (Box theBox : emptyBoxes) {              // EmptyBox Collision...
      theBox.location = new PVector(x, y);
      theBox.isEmptyBox = true;
      if (!theMario.marioDies) {
        theBox.marioAllWayCollision(theMario, theSound);
      }
      theBox.koopaAllWayCollision(koopas);
      theBox.soldierAllWayCollision(soldiers);
    }
    
    for (LevelComplete theLevel : levelDone) {          // Level Complete Object Collision...
      theLevel.collision(theMario, theSound);
    }
    
    if (!theMario.marioDies) {                  
      coinCollision(theMario, theSound);               // Coin collision...                   
    }
  }

  void grassCollision(Mario theMario, ArrayList<Koopa> koopas, ArrayList<SoldierEnemy> soldiers, SoundTrack theSound) {
    // Checks for Grass Collision...
    
    for (Grass grass : grasses) {
      grass.location.x = x;
      grass.location.y = y;

      if (type == '#' || type == '`' || type == '^') {                        //Different types of grass...
        if (!theMario.marioDies) {
          grass.marioTopCollision(theMario, theSound);
        }
        grass.koopaTopCollision(koopas);
        grass.soldierTopCollision(soldiers);
      } 
      else if (type == '/' || type == '*' || type == '{' || type == '}') {                        // Same again... Different types of grass...
        if (!theMario.marioDies) {
          grass.marioAllWayCollision(theMario, theSound);
        }
        grass.koopaAllWayCollision(koopas);
        grass.soldierAllWayCollision(soldiers);
      }
    }
  }
  
  void coinCollision(Mario theMario, SoundTrack theSound) {
    // Checks For Coin Collision (IF MARIO CREATES COLLISION WITH COIN THEN THE COIN WILL BE REMOVED)...
    
    for (int i = coins.size()-1; i >= 0; i--) {
      Coin theCoin = coins.get(i);
      
      theCoin.marioCollision(theMario, theSound);
      
      if (theCoin.marioCollectsCoin) {
        coins.remove(i);
      }
    }
  }
  
  void addMuncher() {
    // Adds Muncher in its Arraylist...
    
    if (type == 'v') {
      munchers.add(new Muncher());
    }
  }

  void addCoin() {
    // Adds Coin in its Arraylist...
    
    if (type == 'c') {
      coins.add(new Coin());  
    }
  }
  
  void addQuestionBox() {
    // Adds Questionbox in its Arraylist...
    
    if (type == '?') {
      qBoxes.add(new QuestionBox(x, y));
    }
  }
  
  void addSpinnerBox() {
    // Adds Spinnerbox in its Arraylist...
    
    if (type == '0') {
      spinBoxes.add(new SpinnerBox(x, y));  
    }
  }
  
  void addGrass() {
    // Adds Grass in its Arraylist...
    
    if (type == '#') {                                                                  // the character is different types of grass...
      grasses.add(new Grass());
      tileImg = loadImage("Grass/GrassTop.png");
    } else if (type == '/' || type == '*' || type == '`' || type == '^') {
      grasses.add(new Grass());
      if (type == '/' || type == '`') {
        tileImg = loadImage("Grass/GrassTop_LeftORRight_Slope/GrassTopLeftSlope.png");
      } else if (type == '*' || type == '^') {
        tileImg = loadImage("Grass/GrassTop_LeftORRight_Slope/GrassTopRightSlope.png");
      }
    } else if (type == '_') {
      tileImg = loadImage("Grass/GrassMud/GrassMud.png");
    } else if (type == '{' || type == '}' || type == '[' || type == ']') {
      if (type != '[' || type != ']') {
        grasses.add(new Grass());
      }
      if (type == '{' || type == '[') {
        tileImg = loadImage("Grass/GrassMud/GrassLeftMud.png");
      } else if (type == '}' || type == ']') {
        tileImg = loadImage("Grass/GrassMud/GrassRightMud.png");
      }
    }
  }
}