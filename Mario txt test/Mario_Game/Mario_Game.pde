import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer homeAudio, level1Audio;

Mario mario;

Button playButton;
Button instructButton;
Button gobackButton;

Button level[];

int gameState;

final PVector gravity = new PVector(0, 0.1);        // CONSTANT Variable...

PImage world;
PImage homeScreen, generalScreen;
PImage arrowKeys, spaceBar;

Level theLevel;

void setup() {
  size(800, 594);
  mario = new Mario(new PVector(100, height/2), new PVector(3, 0), 0.1);

  playButton = new Button(new PVector(width/2, height/2+50), "Text/playGame.png");
  instructButton = new Button(new PVector(width/2, 2*height/3+11), "Text/instructions.png");
  gobackButton = new Button(new PVector(150, 100), "Text/goBack.png");

  theLevel = new Level("Levels/1.txt", gravity);
  world = loadImage("levelWorlds/levelWorld1.png");
  homeScreen = loadImage("homeScreen.png");
  generalScreen = loadImage("generalScreen.png");
  
  arrowKeys = loadImage("arrowKeys.png");
  spaceBar = loadImage("spaceBar.png");
  
  level = new Button[3];
  
  for (int i=0; i< level.length; i++) {
    level[i] = new Button(new PVector(200+ 200*i, height/3), "Text/level"+(i+1)+".png");  
  }
  
  minim = new Minim(this);
  homeAudio = minim.loadFile("SoundTrack/home.wav");
  level1Audio = minim.loadFile("SoundTrack/level1.wav");
}

void draw() {
  
  if (gameState == 0 || gameState == 1 || gameState == 2) {
    if (!homeAudio.isPlaying()) {
      homeAudio.rewind();
      homeAudio.play();
    } 
  }else if (gameState == 3) {
    level1Audio.play();  
  }
  
  if (gameState == 0) {
    startGame();
  } else if (gameState == 1) {
    levelChoose();
  } else if (gameState == 2) {
    instructions();
  } 
  else if (gameState == 3) {  
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
    } else if (mario.location.x <= width/2) {
      imageMode(CORNER);
      image(world, int((-width/2)/4), 0);
      theLevel.display(mario);
      marioInteraction();
      //println(mario.location.x);
    } else {
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

void mousePressed() {
  if (gameState == 0) {
    if (playButton.buttonPressed()) {
      gameState = 1;
    } else if (instructButton.buttonPressed()) {
      gameState = 2;
    }
  }else if (gameState == 1) {
    if (gobackButton.buttonPressed()) { 
      gameState = 0;
    }    
  }else if (gameState == 2) {
    if (gobackButton.buttonPressed()) {
      gameState = 0;  
    }
    
  }
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

void startGame() {
  imageMode(CORNER);
  image(homeScreen, 0, 0);
  playButton.display();
  instructButton.display();
}

void levelChoose() {
  imageMode(CORNER);
  image(generalScreen, 0, 0);
  gobackButton.display();
  for (Button theLevel : level) {
    theLevel.display();  
  }
}

void instructions() {
  imageMode(CORNER);
  image(generalScreen, 0, 0);
  gobackButton.display();
  image(arrowKeys, 600, 187);
  image(spaceBar, 300, 400);
}