import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer sound;
Delay myDelay;

void setup(){
 size(400,400);
 
 minim = new Minim(this);
 sound = minim.loadFile("sound.wav", 1024);
 myDelay = new Delay(0.4, 0.5, true, true);
 sound.loop();
}

void draw(){
  float mX = map(mouseX, 0, width, -1, 1);
  
  sound.setBalance(mX);
  //sound.setBandWidth(mX);
  //sound.delay();
  //sound.setFreq();
}
