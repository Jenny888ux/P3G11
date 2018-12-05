class Graph{
  
  Minim minim;
  AudioPlayer soundFile;
  FFT fft;
  float prevY;
  
  Graph(AudioPlayer soundFile){
    super();
    this.soundFile = soundFile;
    //fft = new FFT( soundFile.bufferSize(), soundFile.sampleRate() );
    //minim = new Minim(this);
  }
/*
  public void drawTheGraph() {
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
  
  public void FFTGraph(int[] distanceArray){
     println(distanceArray);
  }
*/
}
