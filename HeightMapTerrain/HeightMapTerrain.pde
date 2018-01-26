import queasycam.*;

QueasyCam cam;

String filename = "Heightmap.png";
PImage heightmapImg;

color[] terrain;
int imgWidth;
int imgHeight;

float groundScale = 10;

// Used for camera movement and rotation
float xPos = 0;
float yPos = 0;
float xMovement = 10;
float yMovement = 10;
float xRot = 0;
float yRot = 0;
float xRotSpeed = .1;
float yRotSpeed = .1;
boolean forward = false;
boolean backward = false;
boolean right = false;
boolean left = false;
boolean rotUp = false;
boolean rotDown = false;
boolean rotLeft = false;
boolean rotRight = false;

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
  noStroke();
  cam = new QueasyCam(this);
  cam.speed = 1;              // default is 3
  cam.sensitivity = 0.25;      // default is 2
}

void draw(){
  float[] terrainGray = rgbToGrayscale(terrain);
  lights();

  background(0);


  translate(width/2, height/2+50);
  rotateX(PI/2);
  translate(-width/2, -height/2);

  for (int y = 1; y < imgWidth-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < imgHeight; x++) {
      fill(color(234, 10, 100));
      vertex(x * groundScale, y * groundScale, terrainGray[x + y * imgWidth]);
      vertex(x * groundScale, (y+1) * groundScale, terrainGray[x + (y+1) * imgWidth]);
    }
    endShape();
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