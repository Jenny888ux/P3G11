import processing.sound.*;

SoundFile file;
float amp;
float rate;

void setup(){
size(1010,510);
frameRate(30);
file = new SoundFile(this, "sound.wav");
file.loop();
}

void draw() {
 //file.stop();
 //amp from 0,0 to 1,0
  if (mouseX > 0 && mouseX < 100){
  amp = 0.1;
  } else if (mouseX > 101 && mouseX < 200) {
    amp = 0.2;
  } else if (mouseX > 201 && mouseX < 300) {
    amp = 0.3;
  } else if (mouseX > 301 && mouseX < 400) {
    amp = 0.4;
  } else if (mouseX > 401 && mouseX < 500) {
    amp = 0.5;
  } else if (mouseX > 501 && mouseX < 600) {
    amp = 0.6;
  } else if (mouseX > 601 && mouseX < 700) {
    amp = 0.7;
  } else if (mouseX > 701 && mouseX < 800) {
    amp = 0.8;
  } else if (mouseX > 801 && mouseX < 900) {
    amp = 0.9;
  } else if (mouseX > 901) {
    amp = 1.0; }
    
  //Rate from >0 to 1,0 which is normal and 2,0 which is double the speed
  rate = mouseY/100;

    delay(100);
    file.amp(amp);
    file.rate(rate);

    print("AMP: "+amp);
    print("RATE "+rate);
    delay(100);
}
