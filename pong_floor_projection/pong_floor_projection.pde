// Based on this code: https://openprocessing.org/sketch/47481/ by Gabriel Lovato

// adapted for two playser within a Kinect tracking and floow projection space by Halfdan Hauch Jensen (halj@itu.dk) at AIR LAB ITU
import oscP5.*;

OscP5 oscP5;
Blob [] blobs;
int framesSinceLastOscMessage = 0;

boolean gameStart = false;

float x = 150;
float y = 150;
float speedX = random(7, 10);
float speedY = random(7, 10);
int leftColor = 128;
int rightColor = 128;
int diam;
int rectSize = 150;
float diamHit;

int left_pad_y, right_pad_y;


void setup() {
  size(1920, 1080);
  oscP5 = new OscP5(this, 6789);
  noStroke();
  smooth();
  ellipseMode(CENTER);
}

void draw() { 
  background(255);
  
  try{
    if (blobs != null){
      for (int i = 0; i < blobs.length; i++){
        if (blobs[i].x < 100) left_pad_y = int(map(blobs[i].y, 0, 480, 0, 1080));
        else if (blobs[i].x > 640-100) right_pad_y = int(map(blobs[i].y, 0, 480, 0, 1080));
      }
    }
  }
  catch(NullPointerException e){
    println("NullPointerException catched", millis());
  
  }
  
  
  fill(128,128,128);
  diam = 20;
  ellipse(x, y, diam, diam);

  fill(leftColor);
  //rect(0, 0, 20, height);
  rect(20, left_pad_y-rectSize/2, 10, rectSize);
  fill(rightColor);
  rect(width-30, right_pad_y-rectSize/2, 10, rectSize);


  if (gameStart) {

    x = x + speedX;
    y = y + speedY;

    // if ball hits right bar, invert X direction and apply effects
    if ( x > width-30 && x < width -20 && y > right_pad_y-rectSize/2 && y < right_pad_y+rectSize/2 ) {
      speedX = speedX * -1;
      x = x + speedX;
      rightColor = 0;
      fill(random(0,128),random(0,128),random(0,128));
      diamHit = random(75,150);
      ellipse(x,y,diamHit,diamHit);
      rectSize = rectSize-10;
      rectSize = constrain(rectSize, 10,150);      
    } 
    
    // if ball hits left bar, invert X direction and apply effects
    if ( x < 30 && x > 20 && y > left_pad_y-rectSize/2 && y < left_pad_y+rectSize/2 ) {
      speedX = speedX * -1;
      x = x + speedX;
      rightColor = 0;
      fill(random(0,128),random(0,128),random(0,128));
      diamHit = random(75,150);
      ellipse(x,y,diamHit,diamHit);
      rectSize = rectSize-10;
      rectSize = constrain(rectSize, 10,150);      
    } 

    else {     
      leftColor = 128;
      rightColor = 128;
    }
    // resets things if you lose
    if (x > width) { 
      gameStart = false;
      x = 150;
      y = 150; 
      speedX = random(7, 10);
      speedY = random(7, 10);
      rectSize = 150;
    }
    
    if (x < 0) { 
      gameStart = false;
      x = width-150;
      y = 150; 
      speedX = random(-7, -10);
      speedY = random(7, 10);
      rectSize = 150;
    }


    // if ball hits up or down, change direction of Y   
    if ( y > height || y < 0 ) {
      speedY = speedY * -1;
      y = y + speedY;
    }
  }
}
void mousePressed() {
  gameStart = true;
}
                
