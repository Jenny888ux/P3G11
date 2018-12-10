public class Camera extends PApplet {
  
  public Camera() {
    PApplet.runSketch(new String[]{this.getClass().getSimpleName()}, this);
  }

  public void settings() {
    
    size(1920, 1080);
  }
  
  void setup() {
    
  }
  
  void draw(){
    if(kinect != null){
       PImage cam = kinect.getColorImage();
       image(cam, 0, 0, 1920, 1080);
    }
  }
}
