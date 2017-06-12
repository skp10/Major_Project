class Characters {
  PVector location;
  PVector vel;
  PVector ac;
  
  boolean isEnemy;
  
  float mass;

  Characters(PVector location, PVector vel, float mass) {
    this.location = new PVector(location.x, location.y);
    this.vel = new PVector(vel.x, vel.y);
    this.ac = new PVector(0, 0);
    
    this.mass = mass;
  }

  void move() {
    vel.add(ac);
    location.y += vel.y;
    if (isEnemy) {
      location.x -= vel.x;
    }
    ac.mult(0);
  }

  void addforce(PVector force) {
    PVector f = PVector.div(force, mass);
    ac.add(f);
  }
}