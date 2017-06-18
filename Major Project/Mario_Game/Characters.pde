class Characters {

  // PROPERTIES OF THE CHARACTER...
  PVector location;
  PVector vel;
  PVector ac;
  float mass;

  boolean isEnemy;

  Characters(PVector location, PVector vel, float mass) {
    // Constructor that sets up the data... 
    
    this.location = new PVector(location.x, location.y);
    this.vel = new PVector(vel.x, vel.y);
    this.ac = new PVector(0, 0);

    this.mass = mass;
  }

  void move() {
    // Moves the enemy by implementing the properties of the character (variables)...
    
    vel.add(ac);
    location.y += vel.y;
    if (isEnemy) {
      location.x -= vel.x;
    }
    ac.mult(0);
  }

  void addforce(PVector force) {
    // Adds the force: EX, gracity...
    
    PVector f = PVector.div(force, mass);
    ac.add(f);
  }
}