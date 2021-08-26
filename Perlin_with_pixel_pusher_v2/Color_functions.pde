float ring1_yoff = 0.0;        // 2nd dimension of perlin noise
float ring2_yoff = 2.9;        // 2nd dimension of perlin noise
float ring3_yoff = 1.5;        // 2nd dimension of perlin noise
float ring4_yoff = 0.0;        // 2nd dimension of perlin noise
float ring5_yoff = 10.0;        // 2nd dimension of perlin noise
float ring6_yoff = 30.0;        // 2nd dimension of perlin noise

boolean showCurves = false;

// --- RING 1 ---
void ring1() {
  
  // We are going to draw a polygon out of the wave points
  if (showCurves) {
    fill(255);
    stroke(255);
    beginShape();
  }

  float xoff = 0;  // 2D Noise

  // Iterate over horizontal pixels
  for (float x = 0; x <= width; x ++) {
    // Calculate a y value according to noise, map to 
    float y = map(noise(xoff, ring1_yoff), 0, 1, 0, 80); // 2D Noise

    if (showCurves) vertex(x, y); // Set the vertex

    float brightness = constrain(map(y, 0, 80, 350, 0), 0, 255);
    stroke(brightness, max(brightness-15, 0), max(brightness-70, 0)); // green
    // stroke(map(y, 0, 80, 255, 0), 255, map(y, 0, 80, 255, 0)); // green / white
    // stroke(map(y, 0, 80, 255, 0), 255, 0); // green / yellow
    // stroke(0, 200, map(y, 0, 80, 255, 0)); // green / blue

    line(x, 80, x, 100);
    
    xoff += 0.05; // Increment x dimension for noise // how steep or smooth the courve hills are
  }
  
  ring1_yoff += 0.01; // increment y dimension for noise // speed of the courve changes
  
  if (showCurves) {
    stroke(255);
    vertex(width, 80);
    vertex(0, 80);
    endShape(CLOSE);
  }
}


// --- RING 2 ---
void ring2() {
  
  // We are going to draw a polygon out of the wave points
  if (showCurves) {
    fill(255);
    stroke(255);
    beginShape();
  }

  float xoff = 0;       // Option #1: 2D Noise
  //float xoff = yoff; // Option #2: 1D Noise
  // Iterate over horizontal pixels
  for (float x = 0; x <= width; x ++) {
    // Calculate a y value according to noise, map to 
    float y = map(noise(xoff, ring2_yoff), 0, 1, 0, 80); // Option #1: 2D Noise

    if (showCurves) vertex(x, y+100); // Set the vertex
    
    stroke(0, map(y, 0, 80, 255, 0), 0); // green
    // stroke(map(y, 0, 80, 255, 0), 0, 0); // red / black
    // -- stroke(map(y, 0, 80, 255, 0), 255, map(y, 0, 80, 255, 0)); // green / white
    // -- stroke(map(y, 0, 80, 255, 0), 255, 0); // green / yellow
    //stroke(200, 0, map(y, 0, 80, 255, 0)); // red / blue

    line(x, 80+100, x, 100+100);

    xoff += 0.1; // Increment x dimension for noise // how steep / smooth the courve hills are
  }
  ring2_yoff += 0.025; // increment y dimension for noise // speed of the courve changes
  
  if (showCurves) {
    stroke(255);
    vertex(width, 80+100);
    vertex(0, 80+100);
    endShape(CLOSE);
  }
}


// --- RING 3 BLUE ---
void ring3() {
  
  // We are going to draw a polygon out of the wave points
  if (showCurves) {
    fill(255);
    stroke(255);
    beginShape();
  }

  float xoff = 0;       // Option #1: 2D Noise
  // Iterate over horizontal pixels
  for (float x = 0; x <= width; x ++) {
    // Calculate a y value according to noise, map to 
    float y = map(noise(xoff, ring3_yoff), 0, 1, 0, 80); // Option #1: 2D Noise

    // Set the vertex
    if (showCurves) vertex(x, y+200);

    //stroke(0, 0, map(y, 0, 80, 255, 0)); // blue / black
    // -- stroke(map(y, 0, 80, 255, 0), 255, map(y, 0, 80, 255, 0)); // green / white
    // -- stroke(map(y, 0, 80, 255, 0), 255, 0); // green / yellow
    stroke(0, 0, constrain(map(y, 0, 80, 400, 0), 0, 255)); // blue

    line(x, 80+200, x, 100+200);

    
    xoff += 0.1; // Increment x dimension for noise // how steep / smooth the courve hills are
  }
  
  ring3_yoff += 0.025; // increment y dimension for noise // speed of the courve changes
  
  if (showCurves) {
    stroke(255);
    vertex(width, 80+200);
    vertex(0, 80+200);
    endShape(CLOSE);
  }
}



// --- RING 4 ---
void ring4() {

  // We are going to draw a polygon out of the wave points
  if (showCurves) {
    fill(255);
    stroke(255);
    beginShape();
  }

  float xoff = 0;       // Option #1: 2D Noise
  
  // Iterate over horizontal pixels
  colorMode(HSB, 359);
  for (float x = 0; x <= width; x ++) {
    // Calculate a y value according to noise, map to 
    float y = map(noise(xoff, ring4_yoff), 0, 1, 0, 80); // Option #1: 2D Noise
    
    if (showCurves) vertex(x, y+300);
    
    stroke(60, 359, map(y, 0, 80, 0, 359)); // green / yellow
    
    //stroke(255, map(y, 0, 80, 255, 0), 0); // green / yellow
    //stroke(70, 200, map(y, 0, 80, 255, 0)); // blue / black
    // -- stroke(map(y, 0, 80, 255, 0), 255, map(y, 0, 80, 255, 0)); // green / white
    // -- stroke(map(y, 0, 80, 255, 0), 255, 0); // green / yellow
    // -- stroke(map(y, 0, 80, 255, 0), 0, 200); // blue / red

    line(x, 80+300, x, 100+300);
    
    xoff += 0.1; // Increment x dimension for noise // how steep / smooth the courve hills are
  }
  
  colorMode(RGB);
  
  ring4_yoff += 0.025; // increment y dimension for noise // speed of the courve changes
  
  if (showCurves){
    stroke(255);
    vertex(width, 80+300);
    vertex(0, 80+300);
    endShape(CLOSE);
  }
}


// --- RING 5 ---
void ring5() {
  
  float spiritOneX = 1;
  float spiritTwoX = 1;
  
  //float spiritW = 1;
  
  // We are going to draw a polygon out of the wave points
  if (showCurves) {
    fill(255);
    stroke(255);
    beginShape();
  }

  float xoff = 0;       // Option #1: 2D Noise
  //float xoff = yoff; // Option #2: 1D Noise
  // Iterate over horizontal pixels
  colorMode(HSB, width);
  for (float x = 0; x <= width; x ++) {
    // Calculate a y value according to noise, map to 
    float y = map(noise(xoff, ring5_yoff), 0, 1, 0, 80); // Option #1: 2D Noise
    
    if (x == 10) spiritOneX = y;
    if (x == 160) spiritTwoX = y;
    //if (x == 100) spiritW = y;
    
    if (showCurves) vertex(x, y+400); // Set the vertex
    
    
    stroke(x, width, map(y, 0, 80, width, 0)); // green / yellow
    //stroke(70, 200, map(y, 0, 80, 255, 0)); // blue / black
    // -- stroke(map(y, 0, 80, 255, 0), 255, map(y, 0, 80, 255, 0)); // green / white
    //stroke(255, map(y, 0, 80, 255, 0), 0); // green / yellow
    // -- stroke(map(y, 0, 80, 255, 0), 0, 200); // blue / red

    line(x, 80+400, x, 100+400);

    xoff += 0.2; // Increment x dimension for noise // how steep / smooth the courve hills are
    
  }
  colorMode(RGB, width);
  
  //println("x before", spiritOneX);
  //lightSpirit(spiritOneX, 20, 80+400, 20);
  
  lightSpirit((spiritOneX*5)%width, 20, 80+400, 20);
  lightSpirit((spiritTwoX*5)%width, 20, 80+400, 20);
  
  ring5_yoff += 0.03; // increment y dimension for noise // speed of the courve changes
  
  if (showCurves){
    stroke(255);
    vertex(width, 80+400);
    vertex(0, 80+400);
    endShape(CLOSE);
  }
}




// --- RING 6 ---
void ring6() {
  colorMode(RGB, 255);
  // We are going to draw a polygon out of the wave points
  if (showCurves) {
    fill(255);
    stroke(255);
    beginShape();
  } 

  float xoff = 0;       // Option #1: 2D Noise
  // Iterate over horizontal pixels
  for (float x = 0; x <= width; x ++) {
    // Calculate a y value according to noise, map to 
    float y = map(noise(xoff, ring6_yoff), 0, 1, 0, 80); // Option #1: 2D Noise

    if (showCurves) vertex(x, y+500); // Set the vertex
    
    float brightness = constrain(map(y, 0, 80, 350, 0), 0, 255);
    stroke(brightness, max(brightness-15, 0), max(brightness-70, 0));
    
    // -- stroke(70, 200, map(y, 0, 80, 255, 0)); // blue / black
    // -- stroke(map(y, 0, 80, 255, 0), 255, map(y, 0, 80, 255, 0)); // green / white
    //stroke(map(y, 0, 80, 0, 255), 150, 0); // green / yellow
    // -- stroke(map(y, 0, 80, 255, 0), 0, 200); // blue / red

    line(x, 80+500, x, 100+500);

    xoff += 0.05; // Increment x dimension for noise // how steep / smooth the courve hills are
  }
  
  ring6_yoff += 0.035; // increment y dimension for noise // speed of the courve changes
  
  if (showCurves) {
    stroke(255);
    vertex(width, 80+500);
    vertex(0, 80+500);
    endShape(CLOSE);
  }
}


void lightSpirit(float x, float spiritWidth, float y, float h){
  //println("x just entered", x);
  float index = x - spiritWidth/2;
  //println("i:", index);
  for (int a = 0; a < width; a += width/spiritWidth/2){
    
    stroke(width, a);
    line(index, y, index, y+h);
    index++;
    //println("a", a, "i", index, "y", y, "y+h", y+h);
  }
  for (int a = width; a > 0; a -= width/spiritWidth/2){
    stroke(width, a);
    line(index, y, index, y+h);
    index++;
  }
  //println();
  //println();
}
