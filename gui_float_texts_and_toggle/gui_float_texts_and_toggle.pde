import controlP5.*;

ControlP5 cp5;
PFont font;


void setup() {
  size(400,400);
  setupGUI();
  /*
  font = createFont("arial",10);
  smooth();
  cp5 = new ControlP5(this);
  
  cp5.addTextfield("voltage_side_a")
     .setPosition(50,20)
     .setSize(40,20)
     .setFont(font)
     .setCaptionLabel("voltage")
     .setColor(color(255))
     ;
  // create a toggle and change the default look to a (on/off) switch look
  cp5.addToggle("gui_control_a")
     .setPosition(20, 20)
     .setSize(20,20)
     .setFont(font)
     .setCaptionLabel("")
     .setValue(false)
     ;
  
  cp5.addTextfield("voltage_side_b")
     .setPosition(50,80)
     .setSize(40,20)
     .setFont(font)
     .setCaptionLabel("voltage")
     .setColor(color(255))
     ;
  // create a toggle and change the default look to a (on/off) switch look
  cp5.addToggle("gui_control_b")
     .setPosition(20, 80)
     .setSize(20,20)
     .setFont(font)
     .setCaptionLabel("")
     .setValue(false)
     ;
     */
  
  
     
}

  

void draw() {
  background(0);
}


void setupGUI(){
    font = createFont("arial",10);
  smooth();
  cp5 = new ControlP5(this);
  
  cp5.addTextfield("voltage_side_a")
     .setPosition(50,20)
     .setSize(40,20)
     .setFont(font)
     .setCaptionLabel("voltage")
     .setColor(color(255))
     ;
  // create a toggle and change the default look to a (on/off) switch look
  cp5.addToggle("gui_control_a")
     .setPosition(20, 20)
     .setSize(20,20)
     .setFont(font)
     .setCaptionLabel("")
     .setValue(false)
     ;
  
  cp5.addTextfield("voltage_side_b")
     .setPosition(50,80)
     .setSize(40,20)
     .setFont(font)
     .setCaptionLabel("voltage")
     .setColor(color(255))
     ;
  // create a toggle and change the default look to a (on/off) switch look
  cp5.addToggle("gui_control_b")
     .setPosition(20, 80)
     .setSize(20,20)
     .setFont(font)
     .setCaptionLabel("")
     .setValue(false)
     ;
  
}


void gui_control_a(boolean theFlag) {
  if (theFlag) {
    cp5.get(Textfield.class,"voltage_side_a").setLock(false);
    cp5.get(Textfield.class,"voltage_side_a").setColorForeground(color(0,0,255));
    cp5.get(Textfield.class,"voltage_side_a").setColorBackground(color(0,0,100));
    cp5.get(Textfield.class,"voltage_side_a").setColorLabel(color(255));
    cp5.get(Textfield.class,"voltage_side_a").setColorValue(color(255));
  }
  else {
    cp5.get(Textfield.class,"voltage_side_a").setLock(true);
    cp5.get(Textfield.class,"voltage_side_a").setColorForeground(color(100));
    cp5.get(Textfield.class,"voltage_side_a").setColorBackground(color(20));
    cp5.get(Textfield.class,"voltage_side_a").setColorLabel(color(100));
    cp5.get(Textfield.class,"voltage_side_a").setColorValue(color(100));
  }
}

void gui_control_b(boolean theFlag) {
  if (theFlag) {
    cp5.get(Textfield.class,"voltage_side_b").setLock(false);
    cp5.get(Textfield.class,"voltage_side_b").setColorForeground(color(0,0,255));
    cp5.get(Textfield.class,"voltage_side_b").setColorBackground(color(0,0,100));
    cp5.get(Textfield.class,"voltage_side_b").setColorLabel(color(255));
    cp5.get(Textfield.class,"voltage_side_b").setColorValue(color(255));
  }
  else {
    cp5.get(Textfield.class,"voltage_side_b").setLock(true);
    cp5.get(Textfield.class,"voltage_side_b").setColorForeground(color(100));
    cp5.get(Textfield.class,"voltage_side_b").setColorBackground(color(20));
    cp5.get(Textfield.class,"voltage_side_b").setColorLabel(color(100));
    cp5.get(Textfield.class,"voltage_side_b").setColorValue(color(100));
  }
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    if (theEvent.getName().equals("voltage_side_a")){ // side A
      float data = float(theEvent.getStringValue());
      if (!Float.isNaN(data)){
        println("data side a is float", data, "send to Arduino");
        // send data to arduino here
      }
    }
    else if (theEvent.getName().equals("voltage_side_b")){ // side B
      float data = float(theEvent.getStringValue());
      if (!Float.isNaN(data)){
        println("data side b is float", data, "send to Arduino");
        // send data to arduino here
      }
    }
  }
}
