class Mario extends Characters {

  // PROPERTIES OF MARIO...
  PVector dimension;

  // STATE OF MARIO MOVEMENT...
  int leftMovementState;
  int rightMovementState;

  //GROUND Y-POS...
  int ground;

  //GENERAL BOOLEAN CONDITIONS...
  boolean movingRight;
  boolean movingLeft;
  boolean jumping;
  boolean appearLeftOrRightSprite = true;
  boolean playedDeathAudio;

  int imgLength;
  //RIGHT WALK & JUMP MARIO SPRITES...
  PImage[] rightMario;
  PImage rightJump;

  //LEFT WALK & JUMP MARIO SPRITES...
  PImage[] leftMario;
  PImage leftJump;

  boolean jumpingImgState;
  boolean marioDies;
  boolean deathAnimationOnce;

  PImage marioDead;

  Mario(PVector location, PVector vel, float mass) {
    // Constructor that sets up data...
    
    super(location, vel, mass);

    imgLength = 5;
    rightMario = new PImage[imgLength];
    leftMario = new PImage[imgLength];

    dimension = new PVector(36, 46);
    
    // LOADS DIFFERENT MARIO IMAGES...
    for (int i=0; i < imgLength; i++) {
      rightMario[i] = loadImage("Mario/Right_MarioWalk" +i+ ".png");
      leftMario[i] = loadImage("Mario/Left_MarioWalk" +i+ ".png");
    }
    rightJump = loadImage("Mario/Right_MarioJump.png");
    leftJump = loadImage("Mario/Left_MarioJump.png");

    marioDead = loadImage("Mario/marioDie.png");
  }

  void display(SoundTrack theSound) {
    // Displays the Mario Interaction...
    
    fill(255);

    if (!marioDies) {
      if (jumping || jumpingImgState) {
        jumpingImgState = true;
        imageMode(CENTER);
        
        if (!appearLeftOrRightSprite) {                          // Appears left or right sprite...
          image(leftJump, location.x, location.y);
        } else if (appearLeftOrRightSprite) {
          image(rightJump, location.x, location.y);
        }
      } 
      else if (!jumpingImgState) { 
        if (!appearLeftOrRightSprite) {
          Mario_LMovement_SPRITES();
        } else {
          Mario_RMovement_SPRITES();
        }
      }
    } else {
      image(marioDead, location.x, location.y);
      if (!deathAnimationOnce) {
        deathAnimationOnce = true;
        vel.y = -17;
      }
      if (!playedDeathAudio) {
        theSound.levelAudio.close();
        theSound.marioDeadAudio.play();
        playedDeathAudio = true;
      } 
      else {
        if (!theSound.marioDeadAudio.isPlaying()) {
          playerDieRestartSetup();
        }
      }
    }
  }

  void move(float levelEndPixLoc) {
    // Moves the Mario by implemention its properties...
    
    if (!marioDies) {
      leftRightMovement();
    }

    if (location.x < 0+dimension.x/2) {
      location.x = dimension.x/2;
    } else if (location.x > levelEndPixLoc-dimension.x/2) {
      location.x = levelEndPixLoc-dimension.x/2;
    }
    super.move();
    if (location.y+dimension.y/2 > height) {
      marioDies = true;
    }
  }

  boolean jump() {
    // returns true if key pressed...
    
    return (key == ' ');
  }

  boolean moveRight() {
    // returns true if key pressed...
    
    return (keyCode == RIGHT);
  }

  boolean moveLeft() {
    // returns true if key pressed...
    
    return (keyCode == LEFT);
  }

  void Mario_RMovement_SPRITES() {
    // An animation of Mario right movement...
    
    imageMode(CENTER);
    if (!movingRight && appearLeftOrRightSprite) {
      image(rightMario[0], location.x, location.y);
    } 
    else if (movingRight) {     
      if (rightMovementState == 0) image(rightMario[1], location.x, location.y);
      else if (rightMovementState == 1) image(rightMario[2], location.x, location.y);
      else if (rightMovementState == 2) image(rightMario[3], location.x, location.y);
      else if (rightMovementState == 3) image(rightMario[4], location.x, location.y);

      if (frameCount % 5 == 0) {                                                              // is true every 5 frames...
        rightMovementState++;
        if (rightMovementState == 4) {
          rightMovementState = 0;
        }
      }
    }
  }

  void Mario_LMovement_SPRITES() {
    // An animation of Mario left movement...
    
    imageMode(CENTER);
    if (!movingLeft && !appearLeftOrRightSprite) {
      image(leftMario[0], location.x, location.y);
    } else if (movingLeft) {
      if (leftMovementState == 0) image(leftMario[1], location.x, location.y);
      else if (leftMovementState == 1) image(leftMario[2], location.x, location.y);
      else if (leftMovementState == 2) image(leftMario[3], location.x, location.y);
      else if (leftMovementState == 3) image(leftMario[4], location.x, location.y);

      if (frameCount % 5 == 0) {                                                               // is true every 5 frames...
        leftMovementState++;
        if (leftMovementState == 4) {
          leftMovementState = 0;
        }
      }
    }
  }

  void leftRightMovement() {
    // Implements the above functions and calls them at certain condition...
    
    if (appearLeftOrRightSprite) {
      if (movingRight) {        
        location.x += vel.x;
      }
    } else {
      if (movingLeft) {
        location.x -= vel.x;
      }
    }
  }
}