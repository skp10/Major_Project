class Tile {

  ArrayList<Grass> grasses;
  ArrayList<Muncher> munchers;
  ArrayList<Coin> coins;
  ArrayList<QuestionBox> qBoxes;
  ArrayList<SpinnerBox> spinBoxes;

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
    
    grasses = new ArrayList<Grass>();
    munchers = new ArrayList<Muncher>();
    coins = new ArrayList<Coin>();
    qBoxes = new ArrayList<QuestionBox>();
    spinBoxes = new ArrayList<SpinnerBox>();

    addGrass();
    addMuncher();
    addCoin();
    addQuestionBox();
    addSpinnerBox();

    if (type == '.') {
      tileImg = null;
    }
  }

  void display(PVector grav, Mario theMario, ArrayList<Koopa> koopas, ArrayList<SoldierEnemy> soldiers) {   
    imageMode(CORNER);
    if (type!= '.' && type != 'v' && type != 'c' && type != '?' && type != '0' && type != 'k' && type != 's') {     
      image(tileImg, x, y, w, h);
      grassCollision(theMario, koopas, soldiers);
    }
    else if (type == 'v') {
      for (Muncher theMuncher : munchers) {
        theMuncher.location = new PVector(x, y);
        theMuncher.dimension = new PVector(w, h);
        theMuncher.display();
        theMuncher.marioCollision(theMario);
      }
    }
    else if (type == 'c') {
      for (Coin theCoin : coins) {
        theCoin.location = new PVector(x, y);
        theCoin.dimension = new PVector(w, h);
        theCoin.display();  
      }
    }
    else if (type == '?') {
      for (QuestionBox theBox : qBoxes) {
        theBox.display();    
        theBox.addforce(grav);
        theBox.move();
        theBox.collision(theMario, koopas);
      }
    }else if (type == '0') {
      for (SpinnerBox theBox : spinBoxes) {
        theBox.display();
        theBox.addforce(grav);
        theBox.move();
        theBox.checkMillis();
        theBox.collision(theMario, koopas);
      }
    }
  }

  void checkCollision(Mario theMario) {    
    coinCollision(theMario);
  }

  void grassCollision(Mario themario, ArrayList<Koopa> koopas, ArrayList<SoldierEnemy> soldiers) {
    for (Grass grass : grasses) {
      grass.location.x = x;
      grass.location.y = y;

      if (type == '#' || type == '`' || type == '^') {
        grass.marioTopGrassCollision(themario);
        grass.koopaTopGrassCollision(koopas);
        grass.soldierTopGrassCollision(soldiers);
      } else if (type == '/' || type == '*' || type == '{' || type == '}') {
        grass.marioAllWayCollision(themario);
        grass.koopaAllWayCollision(koopas);
        grass.soldierAllWayCollision(soldiers);
      }
    }
  }
  
  void coinCollision(Mario theMario) {
    for (int i = coins.size()-1; i >= 0; i--) {
      Coin theCoin = coins.get(i);
      
      theCoin.marioCollision(theMario);
      if (theCoin.marioCollectsCoin) {
        coins.remove(i);  
      }
    }
  }
  
  void addMuncher() {
    if (type == 'v') {
      munchers.add(new Muncher());
    }
  }

  void addCoin() {
    if (type == 'c') {
      coins.add(new Coin());  
    }
  }
  
  void addQuestionBox() {
    if (type == '?') {
      qBoxes.add(new QuestionBox(x, y));
    }
  }
  
  void addSpinnerBox() {
    if (type == '0') {
      spinBoxes.add(new SpinnerBox(x, y));  
    }
  }
  
  void addGrass() {
    if (type == '#') {
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