class Point {

  float x, y;

  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }

  float compareXY(Point point) {
    float distanceX = abs(this.x-point.getX());
    float distanceY = abs(this.y-point.getY());
    float distance = sqrt(pow(distanceX,2)+pow(distanceY,2));
    return distance;
  }
  
  float getX(){
   return x; 
  }
  
  float getY(){
   return y; 
  }
}
