/*
This code gives an example of how to move a point in a direction based on a given angle
*/

PVector orign, movedPoint;

float rotation;

void setup() {
  size(500, 500);
}


void draw() {
  background(0);
  
  orign = new PVector(250, 250); // set origin
  rotation = getRotation(orign.x, orign.y, mouseX, mouseY); // get angle between mouse and origin point 
  
  // draw origin
  fill(255, 0, 0);
  ellipse(orign.x, orign.y, 12, 12);
  
  // iterate along the angle line while drawing ellipses
  fill(0, 255, 0);
  for (int i = 20; i < 500; i+=20){
    movedPoint = moveAlongAngle(orign, rotation, i);
    ellipse(movedPoint.x, movedPoint.y, 12, 12);
  }

}


// --- method that calculates rotation of one point around another ---
float getRotation(float x1, float y1, float x2, float y2){
  
  PVector a = new PVector(x1, y1);   // point a
  PVector b = new PVector(x2, y2);   // point b
  PVector r = new PVector(0, -100);  // reference point
 
  b.sub(a);             // move point b
  a.sub(a);             // move point a
  
  // calculate rotation
  float angle = degrees(PVector.angleBetween(r,b));
  if (b.x < 0){ // turn result around if b is on the left side of a
    angle = 360 - angle;  
  }
  return angle; // return angle
}


// --- method that returns a new point moved a given distance in the direction of a angle ---
PVector moveAlongAngle(PVector point, float angle, float moveDist){
  
  PVector returnVector = new PVector(0, -moveDist);
  
  returnVector.rotate(radians(angle));
  returnVector.add(point);
  
  return returnVector;
}
