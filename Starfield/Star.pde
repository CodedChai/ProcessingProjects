class Star {
  float x;
  float y;
  float z;
  float speed = width/70;
  
  float pz;
  
  Star(){
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
    pz = z;
  }
  
  void update(){
    z = z - speed;
    if(z <= 2){
      x = random(-width, width);
      y = random(-height, height);
      z = width;
      pz = z;
    }
  }
  
  void show(){
    fill(255);
    noStroke();
    
    float sx = map(x/z, 0, 1, 0, width);
    float sy = map(y/z, 0, 1, 0, height);
    
    //float r = map(z, 0, width, 8, 0.0);
    //ellipse(sx, sy, r, r);
    
    float px = map(x/pz, 0, 1, 0, width);
    float py = map(y/pz, 0, 1, 0, height);
    stroke(255);
    pz = z;
    line(px, py, sx, sy);
  }
}