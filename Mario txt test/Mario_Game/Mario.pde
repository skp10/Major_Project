class Mario extends Characters {

  int leftMovementState;
  int rightMovementState;

  PImage marioDie;

  ////PHYSICS...
  //PVector location;
  //PVector vel;      // Velocity
  //PVector ac;       // acceleration
  //float mass = 0.1;

  //PROPERTIES OF MARIO...
  PVector dimension;

  //GROUND Y-POS...
  int ground;

  //GENERAL BOOLEAN CONDITIONS...
  boolean movingRight;
  boolean movingLeft;
  boolean jumping;
  boolean appearLeftOrRightSprite = true;

  int imgLength;
  //RIGHT WALK & JUMP MARIO SPRITES...
  PImage[] rightMario;
  PImage rightJump;

  //LEFT WALK & JUMP MARIO SPRITES...
  PImage[] leftMario;
  PImage leftJump;

  boolean jumpingImgState;

  boolean marioDies;

  //DEFAULT CONSTRUCTOR...
  Mario(PVector location, PVector vel, PVector ac, float mass) {
    super(location, vel, ac, mass);      //super(location, vel, ac, mass...

    //location = new PVector(100, height/2);
    //vel = new PVector(3, 0);
    //ac = new PVector(0, 0);
    imgLength = 5;
    rightMario = new PImage[imgLength];
    leftMario = new PImage[imgLength];

    dimension = new PVector(36, 46);

    for (int i=0; i < imgLength; i++) {
      rightMario[i] = loadImage("Mario/Right_MarioWalk" +i+ ".png");
      leftMario[i] = loadImage("Mario/Left_MarioWalk" +i+ ".png");
    }
    rightJump = loadImage("Mario/Right_MarioJump.png");
    leftJump = loadImage("Mario/Left_MarioJump.png");

    marioDie = loadImage("Mario/marioDie.png");
  }

  void display() {
    fill(255);

    if (!marioDies) {
      if (jumping || jumpingImgState) {
        jumpingImgState = true;
        imageMode(CENTER);
        if (!appearLeftOrRightSprite) {
          image(leftJump, location.x, location.y);
        } else if (appearLeftOrRightSprite) {
          image(rightJump, location.x, location.y);
        }
      } else if (!jumpingImgState) { 
        if (!appearLeftOrRightSprite) {
          Mario_LMovement_SPRITES();
        } else {
          Mario_RMovement_SPRITES();
        }
      }
    } else {
      image(marioDie, location.x, location.y);
    }
  }

  void move(float levelEndPixLoc) {
    //if (jumping) {        // && touchingGround()
    //  vel.y = - 16;
    //}
    leftRightMovement();

    if (location.x < 0+dimension.x/2) {
      location.x = dimension.x/2;
    }
    else if (location.x > levelEndPixLoc-dimension.x/2) {
      location.x = levelEndPixLoc-dimension.x/2;
    }
    super.move();
  }

  boolean jump() {
    return (key == ' ');
  }

  boolean moveRight() {
    return (keyCode == RIGHT);
  }

  boolean moveLeft() {
    return (keyCode == LEFT);
  }

  void Mario_RMovement_SPRITES() {
    imageMode(CENTER);
    if (!movingRight && appearLeftOrRightSprite) {
      image(rightMario[0], location.x, location.y);
    } else if (movingRight) {
      if (rightMovementState == 0) {

        image(rightMario[1], location.x, location.y);
      } else if (rightMovementState == 1) {

        image(rightMario[2], location.x, location.y);
      } else if (rightMovementState == 2) {

        image(rightMario[3], location.x, location.y);
      } else if (rightMovementState == 3) {

        image(rightMario[4], location.x, location.y);
      }

      if (frameCount % 5 == 0) {
        rightMovementState++;
        if (rightMovementState == 4) {
          rightMovementState = 0;
        }
      }
    }
  }

  void Mario_LMovement_SPRITES() {
    imageMode(CENTER);
    if (!movingLeft && !appearLeftOrRightSprite) {
      image(leftMario[0], location.x, location.y);
    } else if (movingLeft) {
      if (leftMovementState == 0) {

        image(leftMario[1], location.x, location.y);
      } else if (leftMovementState == 1) {

        image(leftMario[2], location.x, location.y);
      } else if (leftMovementState == 2) {

        image(leftMario[3], location.x, location.y);
      } else if (leftMovementState == 3) {

        image(leftMario[4], location.x, location.y);
      }

      if (frameCount % 5 == 0) {
        leftMovementState++;
        if (leftMovementState == 4) {
          leftMovementState = 0;
        }
      }
    }
  }

  void leftRightMovement() {
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