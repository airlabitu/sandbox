// this code calculates the degrees one point is rotated around another point

void setup(){
  size(640, 480);
  
}

void draw(){
  background(0);
  
  // get rotation
  float rotation = getRotation(width/2, height/2, mouseX, mouseY);
  println(rotation);
  
  // visualize
  fill(255);
  textSize(30);
  text(rotation, 20, 50);
  noStroke();
  fill(255,0,0);
  ellipse(width/2, height/2, 20, 20);
  fill(0,255,0);
  ellipse(mouseX, mouseY, 20, 20);
  stroke(255);
  line(width/2, height/2, width/2, 0);
  line(width/2, height/2, mouseX, mouseY);

}

// method that calculates rotation of one point around another
float getRotation(float x1, float y1, float x2, float y2){
  
  PVector a = new PVector(x1, y1);   // point a
  PVector b = new PVector(x2, y2);   // point b
  PVector r = new PVector(0, -100);  // reference point
 
  b.sub(a);             // move point b
  a.sub(a);             // move point a
  
  // calculate rotation
  float angle = degrees(r.angleBetween(r,b));
  if (b.x < 0){ // turn result around if b is on the left side of a
    angle = 360 - angle;  
  }
  return angle; // return angle


}
