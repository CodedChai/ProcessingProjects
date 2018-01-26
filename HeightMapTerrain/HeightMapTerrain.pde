String filename = "Heightmap.png";
PImage heightmapImg;

color[] terrain;
int imgWidth;
int imgHeight;

float groundScale = 10;

// Used for movement
float xPos = 0;
float yPos = 0;
float xMovement = 10;
float yMovement = 10;
boolean forward = false;
boolean backward = false;
boolean right = false;
boolean left = false;

void setup(){
  size(1280, 720, P3D);
  heightmapImg = loadImage(filename);
  imgWidth = heightmapImg.width;
  imgHeight = heightmapImg.height;
  //heightmapImg.filter(GRAY);
  //image(heightmapImg, 0, 0);
  //terrain = new color[heightmapImg.width * heightmapImg.height];
  terrain = heightmapImg.pixels;
  
  // Graphics settings
  smooth(2);
}

void draw(){
  float[] terrainGray = rgbToGrayscale(terrain);
  //for(int i = 0; i < terrainGray.length; i++){
  //  println(terrain[i]);
  //}
   lights();
  //println(imgWidth * imgHeight);
  
  background(0);
  noStroke();

  translate(width/2 + xPos, height/2+50);
  rotateX(PI/3);
  translate(-width/2, -height/2 + yPos);
  for (int y = 1; y < imgWidth-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < imgHeight; x++) {
      fill(color(234, 10, 100));
      vertex(x * groundScale, y * groundScale, terrainGray[x + y * imgWidth]);
      vertex(x * groundScale, (y+1) * groundScale, terrainGray[x + (y+1) * imgWidth]);
    }
    endShape();
  }
  movement();
}

void movement(){
  if(left){
    xPos += xMovement; 
  }
  if(right){
    xPos -= xMovement; 
  }
  if(forward){
    yPos += yMovement; 
  }
  if(backward){
    yPos -= yMovement; 
  } 
}

void keyPressed(){
  if(key == 'a' || key == 'A'){
    left = true;
  }
  if(key == 'd' || key == 'D'){
    right = true;
  }
  if(key == 'w' || key == 'W'){
    forward = true;
  }
  if(key == 's' || key == 'S'){
    backward = true; 
  }
}

void keyReleased(){
  if(key == 'a' || key == 'A'){
    left = false;
  }
  if(key == 'd' || key == 'D'){
    right = false;
  }
  if(key == 'w' || key == 'W'){
    forward = false;
  }
  if(key == 's' || key == 'S'){
    backward = false; 
  }
}

float[] rgbToGrayscale(color[] terrain){
  float[] grayscaleValues = new float[terrain.length];
  for(int i = 0; i < terrain.length; i++){
    // Assuming weighted method for GrayScale
    grayscaleValues[i] = (red(terrain[i]) * .3 + green(terrain[i]) * .59 + blue(terrain[i]) * .11);
  }
  
  return grayscaleValues;
}



// Heightmaps will be gray values only so only 256 diff heights