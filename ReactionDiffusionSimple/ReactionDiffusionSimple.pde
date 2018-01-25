Cell[][] grid;
Cell[][] next;

float dA = 1.0;
float dB = 0.5;
float[] feed = {0.0545, 0.0367, .0432, .014, 0.03};
float[] killRate = {0.062, 0.0649, 0.06, .052, .059};
float timeStep = 1;

// Coral: 0, Mitosis: 1, Flowers: 2, Cloverish Mitosis: 3, Nameless: 4
String[] rdNames = {"Coral", "Mitosis", "Flowers", "Clover Shaped Mitosis", "Dots"};
int rdSelector = 4;

void setup(){
  // X should be 100 px less than Y due to spacing of text
  size(700, 800); 
  pixelDensity(1);
 
  initialize();
}

void draw(){
  println(frameRate);
  background(51); 
 
  for(int x = 1; x < width-1; x++){
   for(int y = 1; y < height-1; y++){
     float a = grid[x][y].getA();
     float b = grid[x][y].getB();
     float newA = ( a + 
                     (dA * laplaceA(x, y)) - 
                     (a * b * b) + 
                     (feed[rdSelector] * (1 - a)) * timeStep);
     float newB = ( b + 
                     (dB * laplaceB(x, y)) +
                     (a * b * b) -
                     ((killRate[rdSelector] + feed[rdSelector]) * b) * timeStep);
     next[x][y].setA(constrain(newA, 0, 1));                     
     next[x][y].setB(constrain(newB, 0, 1)); 
                     
   }
  }
 
 color col = color(0, 0, 0);
 loadPixels();
 for(int x = 0; x < width; x++){
   for(int y = 0; y < height; y++){
     float a = grid[x][y].getA();
     float b = grid[x][y].getB();
     float c = floor((a-b)*255);
     c = constrain(c, 0, 255);
     col = color(c, c, c);
     int pixIndex = (x + y * width);
     pixels[pixIndex] = col;

   }
 }
 updatePixels();
 
 swapGrids();
 
 drawText();
}

void mouseClicked(){
  rdSelector = (rdSelector + 1) % feed.length;
  initialize();
}

void initialize(){
  grid = new Cell[width][height];
  next = new Cell[width][height];
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
      grid[x][y] = next[x][y] = new Cell(1, 0);
    }
  }

  int squareSize = floor(random(5, 20));
  int xStart = width / 2 - squareSize;
  // The +100 is an offset for the text since text takes 100 px of space
  int yStart = (height + 100)/ 2  - squareSize;
  int xEnd = xStart + squareSize;
  int yEnd = yStart + squareSize;
  
  for(int x = xStart; x < xEnd; x++){
    for(int y = yStart; y < yEnd; y++){
       grid[x][y].setB(1);
       next[x][y].setB(1);
    }
  }
}

void drawText(){
  textSize(32);
  fill(0, 102, 153); 
  text("Click to change pattern", 10, 30); 
  text(rdNames[rdSelector], 10, 60);
  
}

void swapGrids(){
 Cell[][] temp = grid;
 grid = next;
 next = temp;
}

float laplaceA(int x, int y){
  float sumA = 0;
  
  sumA += grid[x][y].getA() * -1;
  sumA += grid[x-1][y].getA() * 0.2;
  sumA += grid[x+1][y].getA() * 0.2;
  sumA += grid[x][y+1].getA() * 0.2;
  sumA += grid[x][y-1].getA() * 0.2;
  sumA += grid[x-1][y-1].getA() * 0.05;
  sumA += grid[x-1][y+1].getA() * 0.05;
  sumA += grid[x+1][y-1].getA() * 0.05;
  sumA += grid[x+1][y+1].getA() * 0.05;

  
 return sumA; 
}

float laplaceB(int x, int y){
  float sumB = 0;
  
  sumB += grid[x][y].getB() * -1;
  sumB += grid[x-1][y].getB() * 0.2;
  sumB += grid[x+1][y].getB() * 0.2;
  sumB += grid[x][y+1].getB() * 0.2;
  sumB += grid[x][y-1].getB() * 0.2;
  sumB += grid[x-1][y-1].getB() * 0.05;
  sumB += grid[x-1][y+1].getB() * 0.05;
  sumB += grid[x+1][y-1].getB() * 0.05;
  sumB += grid[x+1][y+1].getB() * 0.05;
  
  return sumB; 
}