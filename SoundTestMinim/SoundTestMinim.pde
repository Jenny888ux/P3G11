import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer sound;

float from, to;
int millis;

float mx,my;

void setup() {
  size(400, 400);

  minim = new Minim(this);
  sound = minim.loadFile("sound.wav", 1024);
  sound.loop();
  sound.setGain(0);
}

void draw() {
  
  float mx = map(mouseX, 0,width, -80,10);
  float my = map(mouseY, 0, height, -1, 1);
  
  sound.setPan(my);
  //sound.setGain(mx);
  //println(sound.getGain());
  println(sound.getPan());
}
