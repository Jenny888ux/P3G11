import processing.sound.*;

//AudioDevice device;
SoundFile file;

int red, green, blue;

void setup() {
  size(640, 360);
  background(255);

  // Create an AudioDevice with low buffer size 
  // and create an array containing 5 empty soundfiles
  //device = new AudioDevice(this, 48000, 32);
  //file = new SoundFile;

  // Load 5 soundfiles from a folder in a for loop. 
  //for (int i = 0; i < file.length; i++) {
    file = new SoundFile(this, "sound.wav");
  //}
}

void draw() {
  background(red, green, blue);
}

void keyPressed() {
  // Set a random background color each time you hit then number keys
  red=int(random(255));
  green=int(random(255));
  blue=int(random(255));
  file.loop();
  // Assign a sound to each number on your keyboard. 1-5 play at
  // an octave below the original pitch of the file, 6-0 play at
  // an octave above.
  switch(key) {
  case '1':
  file.stop();
   file.rate(1);
   file.amp(0.2);
   file.play();
    break;
    
  case '2':
  file.stop();
   file.rate(1);
   file.amp(1);
   file.play();
    break;
  case '3':
   file.rate(3);
    break;
  case '4':
  file.stop();
    file.play(0.5, 1.0);
    break;
  case '5':
  file.stop();
    file.play(0.5, 1.0);
    break;
  case '6':
  file.stop();
    file.play(2.0, 1.0);
    break;
  case '7':
  file.stop();
    file.play(2.0, 1.0);
    break;
  case '8':
  file.stop();
    file.play(2.0, 1.0);
    break;
  case '9':
  file.stop();
    file.play(2.0, 1.0);
    break;
  case '0':
  file.stop();
    file.play(2.0, 1.0);
    break;
  }
}
