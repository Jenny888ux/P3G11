import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import ddf.minim.analysis.FFT;

public class FFTSketch extends PApplet {
  Minim minim;
  AudioPlayer soundFile;
  FFT fft;
  float prevY;
  
  public FFTSketch(AudioPlayer soundFile) {
    super();
    this.soundFile = soundFile;
    PApplet.runSketch(new String[]{this.getClass().getSimpleName()}, this);
  }

  public void settings() {
    size(512, 425);
  }

  public void setup() {
    fft = new FFT( soundFile.bufferSize(), soundFile.sampleRate() );
  }


  public void draw() {
    background(0);
    stroke(255);
    float size = fft.specSize();
    fft.forward( soundFile.mix );


    for (int i = 0; i < size; i++)
    {
      float scale = 500;
      float plotVar = height - fft.getBand(i)* scale;
      stroke(255, 0, 0);
      line( i, height, i, plotVar );
    }
    drawGraph(size);
  }

  void drawGraph(float size) {

    for (int i = 0; i <= size; i += 50) {

      fill(255, 255, 255);
      textSize(15);
      text(i/2, i-10, height-10);
      stroke(255);
      line(i, height, i, 0);
    }
    for (int j = 0; j < height; j += 33) {

      fill(255, 255, 255);
      textSize(15);
      text(12-j/(height/12), 0, j);

      stroke(255);
      line(0, j, size, j);
    }
  }
}
