class Characters {
  PVector location;
  PVector vel;
  PVector ac;
  
  float mass;

  Characters(PVector location, PVector vel, PVector ac, float mass) {
    this.location = new PVector(location.x, location.y);
    this.vel = new PVector(vel.x, vel.y);
    this.ac = new PVector(ac.x, ac.y);
    
    this.mass = mass;
  }

  void move() {
    vel.add(ac);
    ac.y = 0;
    location.y += vel.y;
    ac.mult(0);
  }

  void addforce(PVector force) {
    PVector f = PVector.div(force, mass);
    ac.add(f);
  }
}