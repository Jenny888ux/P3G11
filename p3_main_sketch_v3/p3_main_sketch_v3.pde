import ddf.minim.*;
import ddf.minim.analysis.*;


import blobDetection.*;
import KinectPV2.*;

//import oscP5.*;


ArrayList<Integer> distanceArray;
float comX, comY;

KinectPV2 kinect;
BlobDetection BlobDetection;

//OscP5 oscP5;

float distanceThreshold, colorThreshold;

PImage display, depthImage;
int depth[];
int widthOfWindow, heightOfWindow;

Minim minim;
AudioPlayer soundFile;
FFTSketch FFTWin;

void settings() {
  size(512, 424);
  minim = new Minim(this);
  soundFile = minim.loadFile("sound.wav", 1024);
  //soundFile.loop();
}

void setup() {
  widthOfWindow = 512;
  heightOfWindow = 424;
  //oscP5 = new OscP5(this,12000);
  //pureData = new NetAddress("localhost",8000);

  //kinect
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.init();

  //blob detection
  BlobDetection = new BlobDetection(512, 424);
  BlobDetection.setPosDiscrimination(false);
  BlobDetection.setThreshold(1f);

  //sound

  FFTSketch FFTWin = new FFTSketch(); //Create new window in order not to do blob detection on the graph
  distanceArray  = new ArrayList();
  soundFile.loop();
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
  Threshold(1500, 2500, 512, 424);

  //image(display, 0, 0, 1024, 848);

  PImage BlobImage = display;


  pushMatrix();
  translate(0, 0);

  BlobDetection.computeBlobs(BlobImage.pixels);

  //image(display, 0, 0, widthOfWindow, heightOfWindow);
  drawBlobsAndEdges(true, true);

  popMatrix();

  //graph.drawTheGraph();
}

//Click on window to see how far away each pixel is from kinect
void mouseClicked() {
  float i = mouseX + mouseY*widthOfWindow;
  float i2 = map(i, 0, 868, 0, 217);

  println(depth[int(i2)]);
  int j = depth[int(i2)];
  print("Meter away from camera: " + depthLookUpTable(j));
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
      //soundOnCondition(biggestBlob.w*widthOfWindow, biggestBlob.h*heightOfWindow);

      // Edges
      if (drawEdges) {
        ArrayList<PVector> edges;
        edges = findEdgesOfBiggestBlobAndDrawThem(biggestBlob);
        float sumX = 0;
        float sumY = 0;
        float minX = 0;
        float minY = 0;
        for (PVector point : edges) {
          if (minX < point.x || minY < point.y) {
            minX = point.x;
            minY = point.y;
          }
          sumX += point.x;
          sumY += point.y;
        }

        int edgeNumber = edges.size();
        if (frameCount % 20 == 0) {
          distanceArray.clear();
          comY = sumY/edgeNumber;
          comX = sumX/edgeNumber;
          PVector COM = new PVector(comX, comY);
          distance(COM, edgeNumber, edges); //find distances between COM and edges --> distance into array
        }
        if (comX!=0 && comY !=0) {

          fill(255, 0, 0);
          ellipse(comX, comY, 8, 8);
        }
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

/*void soundOnCondition(float widthOfBlob, float heightOfBlob) {
 //float widthofk = map(widthOfBlob, 0,1024,0,512);
 //float heightofk = map(heightOfBlob,0,848,0,424);
 
 float m1 = map(heightOfBlob, 150, 450, 0, 1);
 amp = m1;
 float m2 = map(widthOfBlob, 0, 424, 0.1f, 3.5f);
 rate = m2;
 
 file.amp(amp);
 file.rate(rate);
 }*/

ArrayList<PVector> findEdgesOfBiggestBlobAndDrawThem(Blob biggestBlob) {
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
  return edges;
}

void distance(PVector COM, int edgeNumber, ArrayList<PVector> edges) {
  for (int i = 0; i < edgeNumber; i++) {
    float x2 = edges.get(i).x;
    float y2 = edges.get(i).y;
    float x1 = COM.x;
    float y1 = COM.y;
    float a = pow((x2 - x1), 2);
    float b = pow((y2 - y1), 2);
    float d = sqrt(a + b);
    int distance = int(d);
    if (i > edgeNumber) { //less edges than previous frame --> delete them
      distanceArray.remove(i);
      i--;
    } else if (distanceArray.size()-1 > i) {
      distanceArray.set(i, distance); 
    } else { 
      distanceArray.add(distance);
    }
  }
}
