import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer sound;

void setup(){
 size(400,400);
 
 minim = new Minim(this);
 sound = minim.loadFile("sound.wav", 1024);
 sound.loop();
}

void draw(){
  float mX = map(mouseX, 0, width, -1, 1);
  
  sound.setBalance(mX);
}
