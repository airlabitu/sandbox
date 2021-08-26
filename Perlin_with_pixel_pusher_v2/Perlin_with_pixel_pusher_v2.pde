/**
 * Noise Wave
 * by Daniel Shiffman.  
 * 
 * Using Perlin Noise to generate a wave-like pattern. 
 */




void setup() {
  size(220, 600);
  
  registry = new DeviceRegistry();
  testObserver = new TestObserver();
  registry.addObserver(testObserver);
  //colorMode(HSB, 100);
  frameRate(24);
  prepareExitHandler();
}

void draw() {
  background(0);
  ring1();
  ring2();
  ring3();
  ring4();
  ring5();
  ring6();
  fill(255);
  text(frameRate, 3, 15);
  
  if (testObserver.hasStrips) { 
    registry.startPushing();
    List<Strip> strips = registry.getStrips();
  
    int index = 0;
    for(Strip strip : strips) {
      //println("Strip length:", strip.getLength(), "index:", index);  
      for (int i = 0; i < strip.getLength(); i++){
        color c = color(0);
        
        if (index == 0) c = get(i, 90); // ring 1
        else if (index == 1) c = get(i, 190); // ring 2
        else if (index == 2) c = get(i, 290); // ring 3
        else if (index == 3) c = get(i, 390); // ring 4
        else if (index == 4) c = get(i, 490); // ring 5
        else if (index == 5) c = get(i, 590); // ring 6
        
        strip.setPixel(c, i);
      }
    index++;
    }
    
  }

}


void keyReleased (){
  if (key == 'c') showCurves = !showCurves;
}
