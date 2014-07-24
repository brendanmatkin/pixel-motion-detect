import processing.video.*;
import oscP5.*;
import netP5.*;

Capture cam;
PImage background;
OscP5 oscP5;
NetAddress pureData;      // I was sending to pureData so this is what I called it.. 
int sendPort = 9001;      // OSC send
int receivePort = 9000;   // OSC listen

Region[] reg;
float rCount = 7;       // # of x-axis motion detect regions
float threshold = 75;   // motion threshold
int error = 25;         // # of pixels to ignore in each region (ignore noise) before considered to have movement
int fadeTime = 25;      // number of cycles to hold motion detect in a pixel
int[] onoff;            // array to hold pixel fadeTime

// these must be compatible with your webcam.. 
int camW = 640;        // camera width  
int camH = 480;        // camera height
int camFR = 30;        // camera frame rate 

float rWidth;                              // region width (set automatically)
color motionColor = color(25, 200, 200);   // choice is aesthetic - motion appears as this color 


/****************************************/

void setup() {
  size(camW, camH);
  oscP5 = new OscP5(this, receivePort);
  //pureData = new NetAddress("192.168.2.119", 9006);  // send over a network
  pureData = new NetAddress("127.0.0.1", sendPort);    // localhost (software on same computer

  onoff = new int[width*height];
  rWidth = width/rCount;
  reg = new Region[int(rCount)];
  for (int i = 0; i < rCount; i++) {
    reg[i] = new Region(rWidth*(i+1), rWidth, i+1);
  }
  
  cam = new Capture(this, camW, camH, camFR);
  background = createImage(width, height, RGB);
  cam.start();
}


/******************************************/

void draw() {
  // try putting motionColor in different place to get shimmers, rainbows, or colored noise
  //motionColor = color(random(10, 20), random(200, 225), random(200, 225)); // shimmer color!!
  
  set(0, 0, cam);
  loadPixels();
  background.loadPixels();
  comparePixels();
  updatePixels();
  
  for (int i = 0; i < rCount; i++) {
    reg[i].update();
  }
  
  frame.setTitle(int(frameRate) + " fps");
}


/********************************/
// read new frame when available
void captureEvent (Capture cam) {
  cam.read();
}


/********************************/
// I think this doesn't do anything anymore... mess with it if you want! 
void keyPressed() {
  background.set(0, 0, cam);
}







