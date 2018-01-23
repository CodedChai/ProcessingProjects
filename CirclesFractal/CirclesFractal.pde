void setup(){
  size(600, 600);
}

void draw(){
  background(0);
  stroke(255);
  noFill();
  drawCircle(width/2, height/2, 600);
  noLoop();
}

void drawCircle(float x, float y, float d){
  ellipse(x, y, d, d);
  if(d > 2){
    drawCircle(x + d * 0.5, y, d * 0.5);
    drawCircle(x - d * 0.5, y, d * 0.5);
    drawCircle(x, y+ d * 0.5, d * 0.5);
  }
}