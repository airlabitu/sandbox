import processing.serial.*;

Serial myPort;  // Create object from Serial class

void setup(){
  
  size(255, 100);
  String portName = Serial.list()[9];
  println( Serial.list());
  
  myPort = new Serial(this, portName, 9600);

}

void draw(){

}

void keyReleased(){
  myPort.write(1+"c"+mouseX+"w");
}
