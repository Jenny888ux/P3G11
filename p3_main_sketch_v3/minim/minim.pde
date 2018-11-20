import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer soundFile;
FFT         fft;

void setup()
{
  size(512, 200);
  
  minim = new Minim(this);
  soundFile = minim.loadFile("sound.wav",1024);

  soundFile.loop();
 
  fft = new FFT( soundFile.bufferSize(), soundFile.sampleRate() );
  
}

void draw()
{
  background(0);
  stroke(255);

  fft.forward( soundFile.mix );
  
  for(int i = 0; i < fft.specSize(); i++)
  {
    line( i, height, i, height - fft.getBand(i)*8 );
  }
}
