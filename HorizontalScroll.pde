import com.hamoid.*;

PImage img;
VideoExport videoExport;

int speed = 2;
int screenWidth;
int imageWidth;
int x1;
int x2;
int pass;
int maxPass;

void setup() {
  size(1080, 720);
  frameRate(60);
  videoExport = new VideoExport(this, "./data/video.mp4");

  maxPass = 5;
  screenWidth = 1080;
  
  img = loadImage("./data/logo.png");
  imageWidth = img.width;
  x1 = screenWidth;
  x2 = x1 + imageWidth;
  pass = 1;
  
  videoExport.startMovie();
}

void draw() {
  drawBounce();

  videoExport.saveFrame();
  
  if((keyPressed && key == ESC)) {
    noLoop();
    videoExport.endMovie();
  }
}

void drawBounce() {
  background(255, 255, 255);
  x1 -= speed;

  if(x1 <= -imageWidth + screenWidth) {
    speed *= -1;
    pass++;
  }
 
  image(img, x1, 0);
  
  if(pass == 2 && x1 > screenWidth) {
    videoExport.endMovie();
    noLoop();
  }
}

void drawLooping() {
  background(255, 255, 255);
  x1 -= speed;
  x2 -= speed;

  if(x1 < -imageWidth) {
    x1 = x2 + imageWidth;
    pass++;
    println(pass);
  }
  
  if(pass <= maxPass) {
    image(img, x1, 0);
  }
  
  if(x2 < -imageWidth) {
    x2 = x1 + imageWidth;
    pass++;
    println(pass);
    if(pass > maxPass) {
      noLoop();
      videoExport.endMovie();
    }
  }
  
  image(img, x2, 0);
 }
