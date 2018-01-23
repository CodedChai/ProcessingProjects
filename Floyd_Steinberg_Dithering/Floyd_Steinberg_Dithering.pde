PImage ditheredImage;
PImage original;

int resolutionLimit = 384;

String fileName = "ethan.jpg";

void setup() {
  size(2560, 1080);
  ditheredImage = loadImage(fileName);
  rescale(ditheredImage);
  original = loadImage(fileName);
  ditheredImage.filter(GRAY);
  rescale(original);
  image(original, 0, 0);
}

int index(int x, int y, int width){
  return x + y * width;
}

void lowerResolution(PImage img){
  int x = img.width;
  int y = img.height;
  int scaleFactor = 1;
  scaleFactor = max(1, round(max(x, y) / resolutionLimit)); 
  img.resize(x/scaleFactor, y/scaleFactor);
  
}

void rescale(PImage img){
  int x = img.width;
  int y = img.height;
  int newX = width/2;
  int newY = height;
  
  if(x > y){
      img.resize(newX, y/x * newX);
  } else {
    img.resize(x/y * newY, newY);
  }
}

void draw(){
  ditheredImage.loadPixels();
  for(int y = 0; y < ditheredImage.height - 1; y++){
    for(int x = 1; x < ditheredImage.width - 1; x++){  
      color pixel = ditheredImage.pixels[index(x, y, ditheredImage.width)]; 
      
      float oldR = red(pixel);
      float oldG = green(pixel);
      float oldB = blue(pixel);
      
      
      // Number is actually one higher since math
      int paletteSize = 1;
      
      int newR = round(paletteSize*oldR / 255) * (255/paletteSize);
      int newG = round(paletteSize*oldG / 255) * (255/paletteSize);
      int newB = round(paletteSize*oldB / 255) * (255/paletteSize);
      
      ditheredImage.pixels[index(x, y, ditheredImage.width)] = color(newR,newG,newB);
      
      float errorR = oldR - newR;
      float errorG = oldG - newG;
      float errorB = oldB - newB;
      
      int index = index(x+1, y, ditheredImage.width);
      color col = ditheredImage.pixels[index];
      float r = red(col);
      float g = green(col);
      float b = blue(col);
      r = r + errorR * (7.0 / 16.0);
      g = g + errorG * (7.0 / 16.0);
      b = b + errorB * (7.0 / 16.0);
      ditheredImage.pixels[index] = color(r,g,b);
      
      index = index(x-1, y+1, ditheredImage.width);
      col = ditheredImage.pixels[index];
      r = red(col);
      g = green(col);
      b = blue(col);
      r = r + errorR * (3.0 / 16.0);
      g = g + errorG * (3.0 / 16.0);
      b = b + errorB * (3.0 / 16.0);
      ditheredImage.pixels[index] = color(r,g,b);
      
      index = index(x, y+1, ditheredImage.width);
      col = ditheredImage.pixels[index];
      r = red(col);
      g = green(col);
      b = blue(col);
      r = r + errorR * (5.0 / 16.0);
      g = g + errorG * (5.0 / 16.0);
      b = b + errorB * (5.0 / 16.0);
      ditheredImage.pixels[index] = color(r,g,b);
      
      index = index(x+1, y+1, ditheredImage.width);
      col = ditheredImage.pixels[index];
      r = red(col);
      g = green(col);
      b = blue(col);
      r = r + errorR * (1.0 / 16.0);
      g = g + errorG * (1.0 / 16.0);
      b = b + errorB * (1.0 / 16.0);
      ditheredImage.pixels[index] = color(r,g,b);
    }
  }
  ditheredImage.updatePixels();
  rescale(ditheredImage);
  image(ditheredImage, 1280, 0);
}