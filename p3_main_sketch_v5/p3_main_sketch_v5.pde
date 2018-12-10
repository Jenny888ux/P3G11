import processing.sound.*;
import blobDetection.*;
import KinectPV2.*;

SoundFile file;
float amp1, rate1;
SoundFile file2;
float amp2, rate2;
SoundFile file3;
float amp3, rate3;
SoundFile file4;
float amp4, rate4;
SoundFile file5;
float amp5, rate5;

int soundNB = 0; 

int timer;


KinectPV2 kinect;
BlobDetection BlobDetection;

Camera colorCam;


float distanceThreshold, colorThreshold;

PImage display, depthImage;
int depth[];
int widthOfWindow, heightOfWindow;

void setup() {
  widthOfWindow = 512;
  heightOfWindow = 424;
  //oscP5 = new OscP5(this,12000);
  //pureData = new NetAddress("localhost",8000);

  //kinect
  colorCam = new Camera();
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.enableColorImg(true);
  kinect.init();

  //blob detection
  BlobDetection = new BlobDetection(512, 424);
  BlobDetection.setPosDiscrimination(false);
  BlobDetection.setThreshold(1f);

  //sound
  file = new SoundFile(this, "069_drums2.wav");
  file2 = new SoundFile(this, "124_bass2.wav");
  file3 = new SoundFile(this, "125_guitar2.wav");
  file4 = new SoundFile(this, "100_voice.aif");
  playSoundN();
  
}

void settings() {
  size(512, 424);
}

void draw() {
  background(0);
  depth = kinect.getRawDepthData();
  depthImage = kinect.getDepthImage();

  // Being overly cautious here
  if (depth == null && depthImage == null) {
    return;
  }
  // threshold min max kinect width kinect height 
  Threshold(1500, 2000, 512, 424);

  //image(display, 0, 0, 1024, 848);

  PImage BlobImage = display;


  pushMatrix();
  translate(0, 0);

  BlobDetection.computeBlobs(BlobImage.pixels);

  //image(display, 0, 0, widthOfWindow, heightOfWindow);
  drawBlobsAndEdges(true, true);

  popMatrix();
}

//Click on window to see how far away each pixel is from kinect
void mouseClicked() {
  float i = mouseX + mouseY*widthOfWindow;
  float i2 = map(i, 0, 868, 0, 217);

  println(depth[int(i2)]);
  int j = depth[int(i2)];
  print("Meter away from camera: " + depthLookUpTable(j));
}

void mousePressed() {
  if (mouseButton == LEFT) {
    soundNB++;
    playSoundN();
  } else if (mouseButton == RIGHT && soundNB > 0) {
    soundNB--;
    playSoundP();
  }
}

//Threshold algorithm
public void Threshold(int threshold_min, int threshold_max, int kw, int kh) {
  display = createImage(kw, kh, RGB);
  //display.loadPixels();

  for (int x = 1; x < kw-1; x++) {

    for (int y = 1; y <kh-1; y++) {

      int index = x + y * kw;
      if (depth[index] > threshold_min && depth[index] < threshold_max) {
        //paints the things in the threshold white
        display.pixels[index] = color(255, 255, 255);
      } else {
        display.pixels[index] = color(0, 0, 0);
      }
    }
  }
  //display.updatePixels();
}


public float depthLookUpTable(int index) {
  float[] depthLookUp = new float[5500];
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
  return depthLookUp[index];
}

public float rawDepthToMeters(int depthValue) {
  if (depthValue < 5499) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges) {
  noFill();
  ArrayList<Blob> blobs = new ArrayList<Blob>();
  for (int n = 0; n < BlobDetection.getBlobNb(); n++) {
    blobs.add(BlobDetection.getBlob(n));
  }

  Blob biggestBlob = null;
  ArrayList<Blob> blobsOfSize = arrayListofBlobs(blobs, 20000);

  if (blobsOfSize != null) {
    for (Blob b : blobsOfSize) {
      biggestBlob = biggestblob(b);
    }
  }

  if (biggestBlob != null) {
    // Blobs
    if (drawBlobs) {
      strokeWeight(4);
      stroke(255, 0, 0);
      rect(biggestBlob.xMin*widthOfWindow, biggestBlob.yMin*heightOfWindow, biggestBlob.w*widthOfWindow, biggestBlob.h*heightOfWindow);
      soundOnCondition(biggestBlob.w*widthOfWindow, biggestBlob.h*heightOfWindow);

      // Edges
      if (drawEdges) {
        findEdgesOfBiggestBlobAndDrawThem(biggestBlob);

      }
    }
  }
}


ArrayList<Blob> arrayListofBlobs(ArrayList<Blob> blobs_, int size) {
  ArrayList<Blob> blobsOfSize = new ArrayList<Blob>();
  if (blobs_ != null) {
    for (Blob b : blobs_) {
      float area = ((b.w*512) * (b.h*424));
      if (area > size) {
        blobsOfSize.add(b);
      }
    }
  }
  return blobsOfSize;
}

Blob biggestblob(Blob b) {
  Blob BiggestBlob;
  float blobarea = ((b.w*512) * (b.h*424));
  float temparea = 2000000000;
  if (temparea > blobarea) {

    temparea = blobarea;
    BiggestBlob = b;
    return BiggestBlob;
  }
  return null;
}

void soundOnCondition(float widthOfBlob, float heightOfBlob) {
  //float widthofk = map(widthOfBlob, 0,1024,0,512);
  //float heightofk = map(heightOfBlob,0,848,0,424);
  int widthMap = 424*2;
  int heightMap = 250*2;
  int maxHeight = 450*2;
  if (soundNB == 0) {
    rate1 = map(widthOfBlob, widthMap, 0, 0, 4);
    amp1 = map(heightOfBlob, heightMap, maxHeight, 0, 1);
    file.amp(amp1);
    file.rate(rate1);
  } else if (soundNB == 1) {
    rate2 = map(widthOfBlob, widthMap, 0, 0, 4);
    amp2 = map(heightOfBlob, heightMap, maxHeight, 0, 1);
    file2.amp(amp2);
    file2.rate(rate2);
  } else if (soundNB == 2) {
    rate3 = map(widthOfBlob, widthMap,0, 0, 4);
    amp3 = map(heightOfBlob, heightMap, maxHeight, 0, 1);
    file3.amp(amp3);
    file3.rate(rate3);
  } else if (soundNB == 3) {
    rate4 = map(widthOfBlob, widthMap, 0, 0, 4);
    amp4 = map(heightOfBlob, heightMap, maxHeight, 0, 1);
    file4.amp(amp4);
    file4.rate(rate4);
  } else if (soundNB == 4) {
    
  }
}

void playSoundN() {
  if (soundNB == 0) {
    file.loop();
  } else if (soundNB == 1) {
    file2.loop();
  } else if (soundNB == 2) {
    file3.loop();
  } else if (soundNB == 3){
   //file4.loop(); 
  }
}
void playSoundP() {
  if (soundNB == 0) {
    file2.stop();
  } else if (soundNB == 1) {
    file3.stop();
  } else if (soundNB == 2) {
    file4.stop();
  } else if (soundNB == 3){
   
  }
}


void findEdgesOfBiggestBlobAndDrawThem(Blob biggestBlob) {
  Blob blob;
  EdgeVertex A, B;
  blob = biggestBlob;
  ArrayList<PVector> edges = new ArrayList<PVector>();
  strokeWeight(2);
  stroke(255, 255, 255);
  float x1, x2, y1, y2;
  for (int i = 0; i < blob.getEdgeNb(); i++) {
    A = blob.getEdgeVertexA(i);
    B = blob.getEdgeVertexB(i);
    if (A !=null && B !=null) {
      x1 = A.x*widthOfWindow;
      x2 = B.x*widthOfWindow;
      y1 = A.y*heightOfWindow;
      y2 = B.y*heightOfWindow;
      line(A.x*widthOfWindow, A.y*heightOfWindow, B.x*widthOfWindow, B.y*heightOfWindow);
      edges.add(new PVector(x1, y1));
      edges.add(new PVector(x2, y2));
    }
  }
}
