Mario mario;

int gameState;

final PVector gravity = new PVector(0, 0.1);        // CONSTANT Variable...

PImage world;
PImage homeScreen;

Level theLevel;

void setup() {
  size(800, 594);
  mario = new Mario(new PVector(100, height/2), new PVector(3, 0), 0.1);

  theLevel = new Level("Levels/1.txt", gravity);
  world = loadImage("levelWorlds/levelWorld1.png");
  homeScreen = loadImage("homeScreen.png");
}

void draw() {
  
  if (gameState == 0) {
    imageMode(CORNER);
    image(homeScreen, 0, 0);
  }
  else if (gameState == 1) {
    
  }
  else if (gameState == 2) {  
    if (mario.location.x >= width/2 && mario.location.x <= theLevel.tileWidth*theLevel.numOfTiles.x-width/2) {
      pushMatrix();
      translate(int(-mario.location.x/4), 0);
        imageMode(CORNER);
        image(world, 0, 0);
      popMatrix();
      pushMatrix();
        translate(int(-mario.location.x+width/2), 0);
        theLevel.display(mario);
        marioInteraction();
        //println(mario.location.x);
      popMatrix();
    } 
    else if (mario.location.x <= width/2) {
      imageMode(CORNER);
      image(world, int((-width/2)/4), 0);
      theLevel.display(mario);
      marioInteraction();
      //println(mario.location.x);
    }
    else {
      pushMatrix();
        translate(int(-(theLevel.tileWidth*theLevel.numOfTiles.x-width/2)/4), 0);
        imageMode(CORNER);
        image(world, 0, 0);
      popMatrix();
      pushMatrix();
        translate(int(-(theLevel.tileWidth*theLevel.numOfTiles.x-width/2)+width/2), 0);
        theLevel.display(mario);
        marioInteraction();
      popMatrix();    
    }
  }
}

void marioInteraction() {
  float levelEndPixelLoc = theLevel.tileWidth*theLevel.numOfTiles.x;
  mario.display();
  mario.move(levelEndPixelLoc);
  mario.addforce(gravity);
}


void keyPressed() {
  if (mario.jump()) {
    mario.jumping = true;
  }
  if (mario.moveRight()) {
    mario.movingRight = true;
    mario.appearLeftOrRightSprite = true;
  }
  if (mario.moveLeft() && !mario.movingRight) {
    mario.movingLeft = true;
    mario.appearLeftOrRightSprite = false;
  }
}

void keyReleased() {
  if (mario.jump()) {
    mario.jumping = false;
  }
  if (mario.moveRight()) {
    mario.movingRight = false;
  }
  if (mario.moveLeft()) {
    mario.movingLeft = false;
  }
}