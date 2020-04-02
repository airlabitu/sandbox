/* 
  this code calculates a stereo sound balance (left/right ear), based on a players orientation and relation in space to a sound
  code by: Halfdan Hauch Jensen, halj@itu.dk, AIR LAB, IT University of Copenhagen
*/

float orientation; // players front facing angle
float balance; // stereo balance -1 to 1
PVector player = new PVector(); // player position
PVector sound = new PVector(200, 300); // sound position

void setup(){
  size(640, 480);
  stroke(255);
}

void draw(){
  background(0);
  
  // move the player
  player.x = mouseX;
  player.y = mouseY;
  
  // get balance
  balance = getBalance(player.x, player.y, orientation, sound.x, sound.y);

  
  // visualize everything  
  line(sound.x, sound.y, player.x, player.y);
  fill(255,0,0);
  fill(0,0,255);
  circle(player.x, player.y, 40);
  fill(0,255,0);
  circle(sound.x, sound.y, 40);
  pushMatrix();
  translate(player.x, player.y);
  rotate(radians(orientation));
  line(0, 0, 0, -100); // draw orientation line
  popMatrix();
  fill(255);
  textSize(30);
  text(balance, 20, 50);

}

// --- method that calculates a sound balance based on a player(listeners) position and orientation, and the sound origin (position) ---
float getBalance(float playerX, float playerY, float playerOrientation, float soundX, float soundY){
  
  PVector a = new PVector(playerX, playerY);   // point a
  PVector b = new PVector(soundX, soundY);     // point b
  PVector r = new PVector(0, -100);            // reference point
  r.rotate(radians(playerOrientation+90));     // rotate from front to side of the player
 
  b.sub(a);             // move point b
  a.sub(a);             // move point a
  
  // calculate rotation
  float angle = degrees(PVector.angleBetween(r,b));

  return map(angle, 0, 180, -1, 1); // return angle as balance betweem -1 and 1
}


// rotate player
void keyPressed(){
  if (key == '+') orientation+=3;
  else if (key =='-') orientation-=3;
  
}
