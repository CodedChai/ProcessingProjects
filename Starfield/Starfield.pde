Star[] stars = new Star[2600];

void setup(){
  size(2560, 1440);
  for(int i = 0; i < stars.length; i++){
    stars[i] = new Star();
  }
}

void draw(){
  background(0);
  translate(width/2, height/2);
  for(int i = 0; i < stars.length; i++){
    stars[i].update();
    stars[i].show();
  }
}