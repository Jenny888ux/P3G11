import processing.sound.*;

SoundFile sound;
Reverb reverb;
Delay delay;

void setup(){
size(500,200);
frameRate(30);
sound = new SoundFile(this, "sound.wav");
reverb = new Reverb(this);
reverb.process(sound);
delay = new Delay(this);
delay.process(sound);

sound.loop();
}

void draw() {
  float mX = map(mouseX, 0, width, 0, 1);
  
  float room=mX; //Dunno
  float damp=mX; //Dunno
  float wet=mX; //Primær ændring
  
  reverb.set(room, damp, wet);
}
