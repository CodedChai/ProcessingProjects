// Based on https://www.kasperkamperman.com/blog/animated-bokeh-effect/
// So this effect is achieved by essentially cheating. I created the bokeh blurs in photoshop as well as the gradient
// and just using PImage's blending modes to create this effect. I'm going to be making other sketches where this
// effect becomes more and more procedurally generated.

PImage maxBlur;
PImage medBlur;
PImage minBlur;
PImage gradient;
PImage background;
float radius = 80;
void setup(){
  size(1080, 1080); 
  gradient = loadImage("Gradient.png");
  maxBlur = loadImage("20pxGaussBokeh.png");
  medBlur = loadImage("4pxGaussBokeh.png");
  minBlur = loadImage("1pxGaussBokeh.png");
  background = loadImage("Background.png");
  tint(255, 255, 255);
  image(background, 0, 0);
}

void draw(){
  noLoop();
    
  //translate(width/2, height/2);
   
  
  //image(gradient, 0, 0);
  // We want the gradient's image mode to be overlay
  bokehImagePopulate(20);

  blend(gradient, 0, 0, 1080, 1080, 0, 0, 1080, 1080, OVERLAY);

  //filter(BLUR, 4);
}

void bokehImagePopulate(int amount){
  PVector pos = new PVector(random(width) - 150, random(height) - 150);
  int size = (int)random(128, 512);
  
  for(int i = 0; i < amount; i++){
    pos = new PVector(random(width) - 150, random(height) - 150);
    size = (int)random(128, 512);
    blend(maxBlur, 0, 0, 512, 512, (int)pos.x, (int)pos.y, size, size, ADD);
  }
  
  for(int i = 0; i < amount; i++){
    pos = new PVector(random(width) - 150, random(height) - 150);
    size = (int)random(128, 512);
    blend(medBlur, 0, 0, 512, 512, (int)pos.x, (int)pos.y, size, size, ADD);
  }
  
  for(int i = 0; i < amount; i++){
    pos = new PVector(random(width) - 150, random(height) - 150);
    size = (int)random(128, 512);
    blend(minBlur, 0, 0, 512, 512, (int)pos.x, (int)pos.y, size, size, ADD);
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