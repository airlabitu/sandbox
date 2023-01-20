void setup(){
  size(1080, 1080);
  fill(#EEF659);
  noStroke();
}

void draw(){
  //background(#FF69CC);
  fill(#FF69CC, 80);
  rect(0,0,width,height);
  fill(#EEF659);
  textSize(random(20, 70));
  frameRate(int(random(2,10)));
  int x = (int)random(10, width-150);
  int y = (int)random(10, height-50);
  text("We are hiring", x, y);
  textSize(random(20, 70));
  text("We are hiring", y, x);
  if (key == 'i'){
    rect(width/2-400, height/2-175, 800, 300);
    fill(#FF69CC);
    textSize(55);
    text("TA position open for the fall 2022", width/2-400+30, height/2-100+70-75);
    text("in AIR LAB", width/2-400+30+240, height/2-100+70-10);
    textSize(35);
    text("airlab.itu.dk/lab-ta-fall-2022", width/2-210, height/2+50-15);
    text("deadline: August 11th 2022", width/2-200, height/2+100+10-20);
    
    
  }
  
}

void plot(){

}
