import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import ddf.minim.analysis.FFT;

public class FFTSketch extends PApplet {
  float prevY;

  public FFTSketch() {
    PApplet.runSketch(new String[]{this.getClass().getSimpleName()}, this);
  }

  public void settings() {
    size(600, 400);
  }

  public void draw() {
    background(0);
    stroke(255);

    if (distanceArray != null) {

      int size = distanceArray.size();
      for (int i = 1; i < distanceArray.size(); i+=100) {
        
        int temp = distanceArray.get(i);
        
        int m = int(map(temp, 0, 400, 0, height));
        int plotVar = height-m;
        stroke(255, 0, 0);
        int x = int(map(i, 1, size, 0, width));
        line(x, height, x, plotVar);
        
      }
      drawGraph(size);
          
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
}
