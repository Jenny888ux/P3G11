import ddf.minim.*;
import ddf.minim.analysis.*;

public class FFTSketch extends PApplet {
  int[] topPoints;
  ArrayList<Integer> distanceArrayShort;

  public FFTSketch() {
    PApplet.runSketch(new String[]{this.getClass().getSimpleName()}, this);
  }

  public void settings() {
    size(600, 400);
  }

  void setup() {
    distanceArrayShort = new ArrayList();
    topPoints = new int[100];
  }

  public void draw() {
    background(0);
    stroke(255);

    if (distanceArray != null) {
      distanceArrayShort.clear();
      int size = distanceArray.size();
      for (int i = 0; i < distanceArray.size(); i+=100) {

        int temp = distanceArray.get(i);

        int m = int(map(temp, 0, 400, 0, height));
        int plotVar = height-m;
        stroke(255, 0, 0);
        int x = int(map(i, 1, size, 0, width));
        line(x, height, x, plotVar);
        distanceArrayShort.add(plotVar);
      }
      drawGraph(size);
      findTopPoints(distanceArrayShort);
      changeSound();
    }
  }
  void drawGraph(float size) {

    for (int i = 0; i <= size; i += 50) {

      fill(255, 255, 255);
      stroke(255);
      line(i, height, i, 0);
    }
    for (int j = 0; j < height; j += 33) {

      fill(255, 255, 255);

      stroke(255);
      line(0, j, size, j);
    }
  }

  void findTopPoints(ArrayList<Integer> distanceArray) {
    int j = 0;
    topPoints = new int[100];
    for (int i = 1; i < distanceArray.size(); i++) {


      int temp = distanceArray.get(i);
      //println(temp);



      if (i <= 1 || i >= distanceArray.size()-1) {
      } else if (temp > distanceArray.get(i+1) && temp > distanceArray.get(i-1)) {
        topPoints[j] = temp;
        //println(topPoints[j]);
        j ++;
      }
    }
    for (int i = 0; i < topPoints.length-1; i++) {
      //println(topPoints[0]);
    }
    
  }
  //minim.
  //soundFile.loop();
  void changeSound() {
    float arm1 = map(topPoints[0], 250, 450, -80, 10);
    float head = map(topPoints[1], 0, 300, -1, 1);
    float arm2 = map(topPoints[2], 0, 300, -1, 1);
    float leg1 = map(topPoints[3], 0, 300, -80, 10);
    float leg2 = map(topPoints[4], 0, 300, -80, 10);
    
    //println(topPoints[0]);
    //println(topPoints[2]);
    
    //soundFile.setGain(arm1);
    //soundFile.setPan(arm2);
        
  }
}
