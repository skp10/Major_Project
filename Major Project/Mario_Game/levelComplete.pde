class LevelComplete {
  
  // PROPERTIES OF LEVELCOMPLETE OBJECT...
  PVector location;
  PVector dimension;
  
  boolean playedOnce;
  
  LevelComplete(float x, float y) {
    // Constructor that sets up the data...
    
    location = new PVector(x, y);
    dimension = new PVector(83, 165);
  }

  void collision(Mario theMario, SoundTrack theSound) {
    // Creates Collision with mario and with itself...
    
    // LOCATION OF MARIO AND THE OBJECT...
    PVector marioLocation = new PVector(theMario.location.x, theMario.location.y);
    PVector objLocation = new PVector(location.x+dimension.x/2, location.y+dimension.y/2);
    
    // DIST FROM MARIO AND THE OVJECT...
    float distX = dist (marioLocation.x, marioLocation.y, objLocation.x, marioLocation.y);
    float distY = dist (marioLocation.x, marioLocation.y, marioLocation.x, objLocation.y);
    
    // IF THE MARIO IS CREATING COLLISION...
    if ((abs(distX) < theMario.dimension.x/2+int((dimension.x/2)/3)) && (abs(distY) < theMario.dimension.y/2+dimension.y/2)) {
      theSound.levelAudio.close();
      levelCompleted = true;
      theMario.vel.mult(0);
      if (!playedOnce) {
        theSound.courseClearAudio.rewind();
        theSound.courseClearAudio.play();
        playedOnce = true;
      }
      if (playedOnce) {
        if (!theSound.courseClearAudio.isPlaying()) {
          nextLevel();
        }
      }
    }
  }
}