void setup(){
  size(400, 400);
  background(0);
}

int x = 0;
int y = 0;
int spacing = 10;
float probability = 0.5;

void draw(){
  stroke(255);
  if(random(1) < probability){
    line(x,y,x+spacing,y+spacing);
  } else {
    line(x,y+spacing,x+spacing,y);
  }
  x += spacing;
  if(x >= width){
    x = 0;
    y += spacing;
  }
  if(y >= height){
    background(0);
    y = 0;
    probability = random(1);
    spacing = (int)random(5, 50);
  }
  
}