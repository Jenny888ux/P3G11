import processing.sound.*;


SoundFile file;
float amp1, rate1;
SoundFile file2;
float amp2,rate2;
int soundNB = 0;

void setup() {
  size(400,200);
  file = new SoundFile(this, "sound1.wav");
  file2 = new SoundFile(this, "song.mp3");
  playSound();
}


void draw() {
  ChangeAR();
}

void ChangeAR(){
 if (soundNB == 0){
   rate1 = map(mouseX, 0, width, 0, 5);
   amp1 = map(mouseY, 0, height, 0,1);
   file.amp(amp1);
   file.rate(rate1);
 }else if(soundNB == 1){
   rate2 = map(mouseX, 0, width, 0, 5);
   amp2 = map(mouseY, 0, height, 0,1);
   file2.amp(amp2);
   file2.rate(rate2);
 } else if(soundNB == 2){
   file.amp(amp1);
   file.rate(rate1);
   file2.amp(amp2);
   file2.rate(rate2);
 }
 
}

void playSound() {
  if (soundNB == 0)
    file.loop();
  else if (soundNB == 1) {
    file.stop();
    file2.loop();
  } else if (soundNB == 2){
    file.loop();
  }
}

void mousePressed(){
 soundNB++; 
 playSound();
}
