/*#-------------------------------------------------------------------------------
# Project Title:      MAJOR PROJECT --- MARIO GAME
# Purpose:        Show what you learned in through this semester in COMPUTER SCIENCE 30
#
# Author:      SHRAWAN PARMAR
#
# Created:     18/06/2017
#
#      ------- SPRITES FROM --------- " https://www.spriters-resource.com/snes/smarioworld/ "...
#
#                            # You will find all the Instructions in the the Game...
#    
#                                             ////////  GAME STATES:  ////////
          
                                                      - HOME PAGE
                                                      - PLAYGAME (CHOOSE LEVEL)
                                                      - INSTRUCTIONS
                                                      - THE GAME (PLAYING GAME)
                                                      - GAME OVER
                                                      - YOU WIN
#-------------------------------------------------------------------------------*/
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

SoundTrack sound;

// DECLARES THE PLAYER...
Mario mario;

// DECLARES THE BUTTON OBJECT...
Button playButton;
Button instructButton;
Button gobackButton;
Button level[];

Level theLevel;

// UNIVERSAL VARIABLES...
int gameState;
int coinPointsCounter;

// CONSTANT GRAVITY VARIABLE...
final PVector gravity = new PVector(0, 0.1);        // CONSTANT Variable...

// MAIN SCRIPT IMAGES...
PImage world;
PImage homeScreen, generalScreen;
PImage gameOver, youWin;
PImage arrowKeys, spaceBar;
PImage levelLock, levelUnLock;

PFont font;

// UNIVERSAL VARIABLES FOR RESETING LEVEL(S)...
int marioLife;                  
boolean[] isLevel;
boolean levelCompleted;
boolean level1Enable, level2Enable, level3Enable;
boolean level1Check, level2Check, level3Check;
boolean level1Reset, level2Reset, level3Reset;

boolean resetOnce;
boolean ranOnce;

void setup() {
  size(800, 594);
  coinPointsCounter = 0;  
  levelCompleted = false;
  
  if (!ranOnce) {          // Is true only once...
    marioLife = 3;
    isLevel = new boolean[3];
    ranOnce = true;
  }
  
  level1Enable = true;
  resetOnce = false;
  
  mario = new Mario(new PVector(100, height/2), new PVector(3, 0), 0.1);
  
  // INITIALIZES BUTTON CLASS...
  playButton = new Button(new PVector(width/2, height/2+50), "Text/playGame.png");
  instructButton = new Button(new PVector(width/2, 2*height/3+11), "Text/instructions.png");
  gobackButton = new Button(new PVector(150, 100), "Text/goBack.png");
  
  // DIFFERENT STATE IMAGES...
  homeScreen = loadImage("homeScreen.png");
  generalScreen = loadImage("generalScreen.png");
  gameOver = loadImage("gameOver.png");
  youWin = loadImage("youWin.png");
  
  // KEYBOARD PARTS IMAGES...
  arrowKeys = loadImage("arrowKeys.png");
  spaceBar = loadImage("spaceBar.png");

  level = new Button[3];

  for (int i=0; i < level.length; i++) {
    level[i] = new Button(new PVector(200+ 200*i, height/2), "Text/level"+(i+1)+".png");
  }

  sound = new SoundTrack(this);
  levelLock = loadImage("Locks/locked.png");
  levelUnLock = loadImage("Locks/unLocked.png");
  font = loadFont("BerlinSansFBDemi-Bold-48.vlw");
}

void draw() {
  if (gameState == 0 || gameState == 1 || gameState == 2) {
    if (!sound.homeAudio.isPlaying()) {
      sound.homeAudio.rewind();
      sound.homeAudio.play();
    }
  }
  
  // MARIO GAME STATES...
  if (gameState == 0) {
    startGame();
  } 
  else if (gameState == 1) {
    levelChoose();
  } 
  else if (gameState == 2) {
    instructions();
  } 
  else if (gameState == 3) { 
    theGame();
  } 
  else if (gameState == 4) {
    gameOver();
  } 
  else if (gameState == 5) {
    youWin();
  }
}

void marioInteraction() {
  /* MARIO INTERACTION -- Does mario interaction...*/
  
  float levelEndPixelLoc = theLevel.tileWidth*theLevel.numOfTiles.x;          // Pixel num of the end of the location...
  mario.display(sound);
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
  } 
  else if (gameState == 1) {
    if (gobackButton.buttonPressed()) { 
      gameState = 0;
    } 
    else if (level[0].buttonPressed()) {                      // Level1 button pressed...
      isLevel[0] = true;
      level1Check = false;
      level1Reset = true;
      level2Reset = false;
      level3Reset = false;
      gameState = 3;
      theLevel = new Level("Levels/1.txt", gravity);
      world = loadImage("levelWorlds/levelWorld1.png");
      sound.homeAudio.close();
      sound.levelAudio.play();
    } 
    else if (isLevel[1] && level[1].buttonPressed()) {        // if Level3 button enabled && Level2 button pressed...
      gameState = 3;
      level2Check = false;
      level1Reset = false;
      level2Reset = true;
      level3Reset = false;
      theLevel = new Level("Levels/2.txt", gravity);
      world = loadImage("levelWorlds/levelWorld2.png");
      sound.homeAudio.close();
      sound.levelAudio.play();
    } 
    else if (isLevel[2] && level[2].buttonPressed()) {        // if Level3 button enabled && Level3 button pressed...
      gameState = 3;
      level3Check = false;
      level1Reset = false;
      level2Reset = false;
      level3Reset = true;
      theLevel = new Level("Levels/3.txt", gravity);
      world = loadImage("levelWorlds/levelWorld3.png");
      sound.homeAudio.close();
      sound.levelAudio.play();
    }
  } else if (gameState == 2) {
    if (gobackButton.buttonPressed()) {
      gameState = 0;
    }
  }
}

void keyPressed() {                              
  /* Mario does movement according to the key pressed*/ 
  if (!levelCompleted) {
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
}

void keyReleased() {
  /* Mario stops doing movement when appropriate key is released...*/
  
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
  /* HomePage of the game...*/
  
  imageMode(CORNER);
  image(homeScreen, 0, 0);
  playButton.display();
  instructButton.display();
}

void levelChoose() {
  /* Choose the level you want from three different level options...*/
  
  imageMode(CORNER);
  image(generalScreen, 0, 0);
  
  gobackButton.display();
  
  for (Button theLevel : level) {
    theLevel.display();
  }
  //CREATES LEVEL LOCK...
  imageMode(CENTER);
  image(levelUnLock, 200, 222);

  if (level2Enable) {
    image(levelUnLock, 400, 222);
  } else {
    image(levelLock, 400, 222);
  }

  if (level3Enable) {
    image(levelUnLock, 600, 222);
  } else {
    image(levelLock, 600, 222);
  }
}  

void instructions() {
  /*Instruction of the game State/ scene...*/
  
  imageMode(CORNER);
  image(generalScreen, 0, 0);
  gobackButton.display();
  image(arrowKeys, 600, 187);
  image(spaceBar, 297, 358);
  
  String arrowKey = "Press (LEFT) OR (RIGHT) Arrow keys\nto move";
  fill(255);
  
  textAlign(CORNER);
  textFont(font);
  textSize(17);
  text(arrowKey, 146, 203);
  String spaceBar = "Press the (SPACE BAR) To JUMP";
  text(spaceBar, 146, 303);
  
  String keyNotes = "KEY NOTES\n  - There are (3 LEVELS)\n"
  + "  - After compleating each level, next level will be unlocked\n"
  + "  - Coins worth (100 POINTS)\n"
  + "  - Question Box worth (300 POINTS)";
  
  text(keyNotes, 136, 421);
}

void checkSound() {
  /* Checks the sound of the game (if the sound is not playing then it will play it again)...*/
  
  if (!sound.levelAudio.isPlaying()) {
    sound.levelAudio.rewind();
    sound.levelAudio.play();
  }
}

void gameOver() {
  /* GameOver state where it displays game over image and resets to the home screen...*/
  
  imageMode(CORNER);
  image(gameOver, 0, 0);
  if (!resetOnce) {                              // Do it once...
    sound.gameOverAudio.play();
    resetOnce = true;
  } else {
    if (!sound.gameOverAudio.isPlaying()) {
      gameState = 0;      
      marioLife = 3;
      isLevel = new boolean[3];
      level2Enable = false;
      level3Enable = false;
      level1Check = false;
      level2Check = false;
      level3Check = false;  
      setup();
    }
  }
}

void youWin() {
  /* You win state, where you will win when you pass all the levels and then it will display the image*/
  
  imageMode(CORNER);
  image(youWin, 0, 0);
    if (!resetOnce) {                          // Will do it once...
    sound.youWinAudio.play();
    resetOnce = true;
  } else {
    if (!sound.youWinAudio.isPlaying()) {
      gameState = 0; 
      marioLife = 3;
      isLevel = new boolean[3];
      level2Enable = false;
      level3Enable = false;
      level1Check = false;
      level2Check = false;
      level3Check = false;
      setup();
    }
  }
}        /*################################################## CONTINUATION OF THE MAIN SCRIPT TO (Main2) TAB ##############################################*/