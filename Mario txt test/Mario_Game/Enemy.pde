class Enemy extends Characters{
  
  PImage img[];
  
  Enemy(PVector location, PVector vel, PVector ac, float mass, String[] imgLocation) {
    super(location, vel, ac, mass);    
    
    img = new PImage[2];
    
    for (int i=0; i< img.length; i++) {
      img[i] = loadImage(imgLocation[i]+i+".png");    
    }
  }
  
  void display() {
      
  }
  
  void move() {
    
  }
}