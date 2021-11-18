int lastX = 200, lastY = 50;

int oregionX, oregionY;

void setup(){
  size(400, 400);
  oregionX = width/2;
  oregionY = height/2;
  
}

void draw(){
  //pushMatrix();
  //translate(width/2, height/2);
  background(0);
  stroke(0,255,0);
  line(oregionX, oregionY, mouseX, mouseY);
  stroke(0,0,255);
  line(oregionX, oregionY, lastX, lastY);
  
  //println(mouseX-width/2, mouseY-height/2);
  //popMatrix();
  
  text(getRotation(oregionX, oregionY,  mouseX, mouseY, lastX, lastY), 10, 40);
}

// method that calculates rotation of one point around another
float getRotation(float x1, float y1, float x2, float y2, float x3, float y3){
  
  PVector a = new PVector(x1, y1);   // point a
  PVector b = new PVector(x2, y2);   // point b
  PVector r = new PVector(x3, y3);  // reference point
 
  println(a.x, a.y, b.x, b.y, r.x, r.y);
  
  b.sub(a);             // move point b
  r.sub(a);             // move point r
  a.sub(a);             // move point a
  
  
  println(a.x, a.y, b.x, b.y, r.x, r.y);
  println();
  // calculate rotation
  float angle = degrees(r.angleBetween(r,b));
  if (b.x < 0){ // turn result around if b is on the left side of a
    //angle = 360 - angle;  
  }
  return angle; // return angle


}

void mouseReleased(){
  //pushMatrix();
  //translate(width/2, height/2);
  lastX = mouseX;
  lastY = mouseY;
  //popMatrix();
  
}

void keyReleased(){
  if (key == 'o'){
    oregionX = mouseX;
    oregionY = mouseY;
  }
}
