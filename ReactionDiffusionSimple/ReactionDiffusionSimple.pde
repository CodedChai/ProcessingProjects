Cell[][] grid;
Cell[][] next;

float dA = 1.0;
float dB = 0.5;
float[] feed = {0.0545, 0.0367, .0432, .014, 0.03};
float[] killRate = {0.062, 0.0649, 0.06, .052, .059};
float timeStep = 1;

// Coral: 0, Mitosis: 1, Flowers: 2, Cloverish Mitosis: 3, Nameless: 4
int rdSelector = 4;

void setup(){
 size(400, 400); 
 pixelDensity(1);
 
 grid = new Cell[width][height];
 next = new Cell[width][height];
 for(int x = 0; x < width; x++){
   for(int y = 0; y < height; y++){
     grid[x][y] = new Cell(1, 0);
     next[x][y] = new Cell(1, 0);
   }
 }
 
 for(int i = 190; i < 210; i++){
   for(int j = 190; j < 210; j++){
      grid[i][j].setB(1);
      next[i][j].setB(1);
   }
 }
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