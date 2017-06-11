class Characters {
  PVector location;
  PVector vel;
  PVector ac;
  
  boolean isKoopa;
  
  float mass;

  Characters(PVector location, PVector vel, PVector ac, float mass) {
    this.location = new PVector(location.x, location.y);
    this.vel = new PVector(vel.x, vel.y);
    this.ac = new PVector(ac.x, ac.y);
    
    this.mass = mass;
  }

  void move() {
    vel.add(ac);
    location.y += vel.y;
    if (isKoopa) {
      location.x -= vel.x;
    }
    ac.mult(0);
  }

  void addforce(PVector force) {
    PVector f = PVector.div(force, mass);
    ac.add(f);
  }
}