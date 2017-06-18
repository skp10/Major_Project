class SoundTrack {
  
  // DECLARES MINIM CLASS...
  Minim minim;

  // BUNCH OF SOUNDS OF THE GAMES...
  AudioPlayer homeAudio, levelAudio, gameOverAudio, youWinAudio;
  AudioPlayer marioJumpAudio, marioKickAudio, marioDeadAudio;
  AudioPlayer coinCollectAudio;
  AudioPlayer courseClearAudio;

  SoundTrack(PApplet theApplet) {
    // Constructor that sets up the data...
    
    minim = new Minim(theApplet);

    // INITALIZES THE DATA/VARIABLES BY LOADING ALL THE AUDIO SOUND...
    homeAudio = minim.loadFile("SoundTrack/home.wav");
    levelAudio = minim.loadFile("SoundTrack/levelBackgroundMusic.wav");
    gameOverAudio = minim.loadFile("SoundTrack/gameOver.wav");
    youWinAudio = minim.loadFile("SoundTrack/youWin.wav");
    
    marioJumpAudio = minim.loadFile("SoundTrack/marioJump.wav");
    marioKickAudio = minim.loadFile("SoundTrack/marioKick.wav");
    marioDeadAudio = minim.loadFile("SoundTrack/marioDies.wav");
    courseClearAudio = minim.loadFile("SoundTrack/courseClear.wav");
    coinCollectAudio = minim.loadFile("SoundTrack/CoinCollection.wav");
  }
}