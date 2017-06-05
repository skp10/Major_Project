class Tile {

  ArrayList<Grass> grasses = new ArrayList<Grass>();
  ArrayList<Muncher> munchers = new ArrayList<Muncher>();
  ArrayList<Coin> coins = new ArrayList<Coin>();
  ArrayList<QuestionBox> qBoxes = new ArrayList<QuestionBox>();

  float x, y;
  float w, h;

  char type;
  PImage tileImg;

  int imageState;


  Tile(float x, float y, float w, float h, char type, PVector grav) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;

    addsGrass();
    addsMuncher();
    addsCoin();
    addsQuestionBox(grav);

    if (type == '.') {
      tileImg = null;
    }
  }

  void display() {   
    imageMode(CORNER);
    if (type!= '.' && type != 'v' && type != 'c' && type != '?') {     
      image(tileImg, x, y, w, h);
    } else if (type == 'v') {
      for (Muncher munch : munchers) {
        munch.location = new PVector(x, y);
        munch.dimension = new PVector(w, h);
        munch.display();
      }
    } else if (type == 'c') {
      for (Coin theCoin : coins) {
        theCoin.location = new PVector(x, y);
        theCoin.dimension = new PVector(w, h);
        theCoin.display();  
      }
    }else if (type == '?') {
      for (QuestionBox theBox : qBoxes) {
        theBox.display();    
        theBox.addforce(gravity);
        theBox.move();
      }
    }
  }

  void checkCollision(Mario theMario, ArrayList<Koopa> enemy) {
    grassCollision(theMario, enemy);
    muncherCollision(theMario);
    coinCollision(theMario);
    questionBoxCollision(theMario);
  }

  void grassCollision(Mario themario, ArrayList<Koopa> enemy) {
    for (Grass grass : grasses) {
      grass.location.x = x;
      grass.location.y = y;

      if (type == '#' || type == '`' || type == '^') {
        grass.marioTopGrassCollision(themario);
        grass.koopaTopGrassCollision(enemy);
      } else if (type == '/' || type == '*' || type == '{' || type == '}') {
        grass.marioAllWayCollision(themario);
        grass.koopaAllWayCollision(enemy);
      }
    }
  }

  void muncherCollision(Mario theMario) {
    for (Muncher theMuncher : munchers) {
      theMuncher.marioCollision(theMario);  
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
  void questionBoxCollision(Mario theMario) {
    for (QuestionBox theBox : qBoxes) {
      theBox.collision(theMario);
    }
  }

  void addsMuncher() {
    if (type == 'v') {
      munchers.add(new Muncher());
    }
  }

  void addsCoin() {
    if (type == 'c') {
      coins.add(new Coin());  
    }
  }
  
  void addsQuestionBox(PVector grav) {
    if (type == '?') {
      qBoxes.add(new QuestionBox(grav));
      
      for (QuestionBox box : qBoxes) {
        box.location = new PVector(x, y);
        box.originalLocation = new PVector(x, y);
      }
    }
  }
  
  void addsGrass() {
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