class Blob {

  private float minx, miny, maxx, maxy;

  private float bHeight, bWidth;

  private ArrayList<PVector> points;

  public Blob(float x, float y) {
    this.minx = x;
    this.miny = y;
    this.maxx = x;
    this.maxy = y;

    points = new ArrayList<PVector>();
    points.add(new PVector(x, y));
  }

  public void display() {
    //display a rectangle at coordiantes
    pushMatrix();
    stroke(0);
    fill(255);
    strokeWeight(2);
    rectMode(CORNERS);
    rect(minx+ 512, miny, maxx+ 512, maxy);

    /*for (PVector v : points) {
     stroke(0, 0, 255);
     point(v.x, v.y);
     }*/

    popMatrix();
  }

  public float sizeOfBlob() {
    //size formula of a square
    return ((maxx-minx)*(maxy-miny));
  }

  public void add(float x, float y) {
    //add a new vector
    points.add(new PVector(x, y));
    //set the min or max value based on both augments
    minx = min(minx, x);
    miny = min(miny, y);
    maxx = max(maxx, x);
    maxy = max(maxy, y);
  }


  public boolean neighborhood(float x, float y) {
    float d = 10000000;
    for (PVector v : points) {
      //distance between the actual point and everyother point.
      float tempDistance = distBetween(x, y, v.x, v.y);
      if (tempDistance < d) {
        d = tempDistance;
      }
    }
    //distance
    if (d < 1000) {
      return true;
    } else {
      return false;
    }
  }

  public void calcFeatures() {
    bWidth = maxx-minx;
    bHeight = maxy-miny;
  }
  
  public float getHeight(){
    return bHeight;
  }
  
  public float getWidth(){
    return bWidth;
  }
  
  //public void sendPureData(){
    //OscMessage msg = new OscMessage("test");
    //msg.add(bWidth);
    //msg.add(bHeight);
    //oscP5.send(msg, pureData);
    
  //}
}
