// Based on https://www.kasperkamperman.com/blog/animated-bokeh-effect/
// So this effect is achieved by essentially cheating. I created the bokeh blurs in photoshop as well as the gradient
// and just using PImage's blending modes to create this effect. I'm going to be making other sketches where this
// effect becomes more and more procedurally generated.

PImage maxBlur;
PImage medBlur;
PImage minBlur;
PImage background;
PImage gradient;
float radius = 80;

int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, c1, c2;


void setup(){
  size(1080, 1080); 
  gradient = loadImage("Gradient.png");
  maxBlur = loadImage("20pxGaussBokeh.png");
  medBlur = loadImage("4pxGaussBokeh.png");
  minBlur = loadImage("1pxGaussBokeh.png");
  background = loadImage("Background.png");
  
  
  // Define colors
  b1 = color(204, 102, 0);
  b2 =  color(0, 102, 153);
}

void draw(){
  noLoop();
    
 // setGradient(0, 0, width, height, b1, b2, X_AXIS);
  
  gradient = createGradientImg();
  
  //image(gradient, 0, 0);

  // We want the gradient's image mode to be overlay
  blend(gradient, 0, 0, 1080, 1080, 0, 0, 1080, 1080, OVERLAY);
  
  bokehImagePopulate(20);

}

void bokehImagePopulate(int amount){
  PVector pos = new PVector(random(width) - 150, random(height) - 150);
  int size = (int)random(128, 512);
  
  for(int i = 0; i < amount*2; i++){
    pos = new PVector(random(width) - 150, random(height) - 150);
    size = (int)random(128, 512);
    blend(maxBlur, 0, 0, 512, 512, (int)pos.x, (int)pos.y, size, size, DODGE);
  }
  
  for(int i = 0; i < amount; i++){
    pos = new PVector(random(width) - 150, random(height) - 150);
    size = (int)random(128, 512);
    blend(medBlur, 0, 0, 512, 512, (int)pos.x, (int)pos.y, size, size, DODGE);
  }
  
  for(int i = 0; i < amount; i++){
    pos = new PVector(random(width) - 150, random(height) - 150);
    size = (int)random(128, 512);
    blend(minBlur, 0, 0, 512, 512, (int)pos.x, (int)pos.y, size, size, DODGE);
  }
  
}

// https://stackoverflow.com/questions/13786807/processing-efficiently-drawing-a-gradient/13788080#13788080
PImage createGradientImg(){
  // We're going to have multiple colors
  // always be at a 45 degree angle so from 0, 0 to 1080, 1080
  // color lerp between

  pushStyle(); // Isolate drawing styles such as colormode
    colorMode(HSB, 360, 100, 100);
    PImage gradient = createImage(width, height, ARGB);
    // length of array will be entire sketch
    int length = width * height;
    
    
    color yellow = #000850; // #00085
    color cyan = #1bdaeb; // #1bdaeb
    color purple = #9b3b81; // #9b3b81
    color orange = #d27e34; //#d27e34
    color[] colors = {orange, cyan, purple, orange};
    int colBuffer = length / (colors.length - 1);


    for(int i = 0; i < length; i++){
      int x = i % gradient.width;
      int y = (int)(i/gradient.width);
      int col1 = 0, col2 = 0;
      if(i / colBuffer == 0){
         col1 = 0;
         col2 = 1;
      }
       if(i / colBuffer == 1){
         col1 = 0;
         col2 = 1;
      }
      if(i / colBuffer == 2){
         col1 = 0;
         col2 = 1;
      }
      gradient.pixels[i] = color(map(x - y, 0, width, hue(colors[col1]), hue(colors[col2])), map(x - y, 0, width, 
                                                      saturation(colors[col1]), saturation(colors[col2])), map(x - y, 0, width, 
                                                      brightness(colors[col1]), brightness(colors[col2])), 255);
    }
    gradient.updatePixels();
  popStyle();
  return gradient;
  
}


void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}

// Old system where I created shapes using begin/endshape. Not quite what I wanted in the end.
void populateBokehRandom(int amount){
   float xMin= radius / 2.0;
   float yMin = radius / 2.0;
   float xMax = width - xMin;
   float yMax = height - yMin;

  for(int i = 0; i < amount; i++){
     color col =  color(random(255),random(255),random(255), 63);
     
     col = color(255, .7 * 255, .3 * 255, 64);
     
     fill(col);
          col = color(255, .7 * 255, .3 * 255, 255);

     stroke(col);
     drawBokeh(random(xMin, xMax), random(yMin, yMax));
  }
}


// Draw the Bokeh using vertices and begin/end shape
// float x and y for it's offset location
void drawBokeh(float x, float y){
  beginShape();
  for(float a = 0; a < TWO_PI; a+=0.1){
     vertex(x(a, radius) + x, y(a, radius) + y);
  }
  endShape(CLOSE);
}

// Get x coordinate for the bokeh
float x(float t, float r){
  return sin(t) * r + sin(t) * 8.0;
}

// Get y coordinate for the bokeh
float y(float t, float r){
  return cos(t) * r; 
}