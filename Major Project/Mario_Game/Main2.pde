void theGame() {
  // Display everything (basically displays the game) including the camera of mario movement...

  if (marioLife > 0) {
    checkSound();
    if (mario.location.x >= width/2 && mario.location.x <= theLevel.tileWidth*theLevel.numOfTiles.x-width/2) {      // checks if the mario is within the camera range...
      pushMatrix();
      translate(int(-mario.location.x/4), 0);                                                    /* CAMERA follows the MARIO */
      imageMode(CORNER);
      image(world, 0, 0);
      popMatrix();

      pushMatrix();
      translate(int(-mario.location.x+width/2), 0);
      theLevel.display(mario, sound);
      marioInteraction();
      //println(mario.location.x);
      popMatrix();
    } else if (mario.location.x <= width/2) {                          // Camera doesnot follow the mario...
      imageMode(CORNER);
      image(world, int((-width/2)/4), 0);
      theLevel.display(mario, sound);
      marioInteraction();
      //println(mario.location.x);
    } else {                                                        // Camera doesnot follow the mario...
      pushMatrix();
      translate(int(-(theLevel.tileWidth*theLevel.numOfTiles.x-width/2)/4), 0);
      imageMode(CORNER);
      image(world, 0, 0);
      popMatrix();

      pushMatrix();
      translate(int(-(theLevel.tileWidth*theLevel.numOfTiles.x-width/2)+width/2), 0);
      theLevel.display(mario, sound);
      marioInteraction();
      popMatrix();
    }
    coinScoreAndMarioLifeDisplay();
  } else {                                                        // if (marioLife <= 0)...
    if (!sound.marioDeadAudio.isPlaying()) {
      gameState = 4;
    }
  }
}

void coinScoreAndMarioLifeDisplay() {
  // Displays the score of the coin and life of the mario...

  String score = "SCORE ";
  textFont(font);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(28);
  text(score+coinPointsCounter, 150, 90);

  String lifeOfMario = "X "+str(marioLife);
  text(lifeOfMario, width-150, 90);
}

void playerDieRestartSetup() {
  // If the mario dies, and mariolife is > 0, then restarts the level...

  marioLife --; 
  gameState = 3;
  
  if (level1Reset) {                                     // Is LEVEL 1
    theLevel = new Level("Levels/1.txt", gravity);
    world = loadImage("levelWorlds/levelWorld1.png");
  }
  else if (level2Reset) {                                     // Is LEVEL 2
    theLevel = new Level("Levels/2.txt", gravity);
    world = loadImage("levelWorlds/levelWorld2.png");
  } 
  else if (level3Reset) {                                            // Is LEVEL 3
    theLevel = new Level("Levels/3.txt", gravity);
    world = loadImage("levelWorlds/levelWorld3.png");
  } 
  if (marioLife > 0) { 
    setup();                            // CALLS THE SETUP...
  }
}

void nextLevel() {
  /* If mario clears the course / level then the next level will be unlocked and 
   if the mario clears all the level then the player wins the game...*/

  if (isLevel[0] && !level1Check) {
    isLevel[1] = true;
    level2Enable = true;
    level1Check = true;
    level1Reset = false;
    level2Reset = true;
  } 
  else if (isLevel[1] && !level2Check) {
    level3Enable = true;
    isLevel[2] = true;
    level2Check = true;
    level2Reset = false;    
    level3Reset = true;
  } 
  else if (isLevel[2] && !level3Check) {     
    gameState = 5;
    level3Check = true;
  }
  if (gameState != 5) {
    gameState = 1;
    setup();
  } else {
    youWin();
  }
}