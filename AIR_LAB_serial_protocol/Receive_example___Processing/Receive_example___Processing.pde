import processing.serial.*;

Serial myPort;                       // The serial port
int[] serialInArray = new int[3];    // Where we'll put what we receive


// Serial protocol variables
int value = 0;
int channel;


void setup() {
  println(Serial.list());
  String portName = Serial.list()[10];
  myPort = new Serial(this, portName, 9600);
}

void draw() {

}

// event function called by processing when receiving new serial data
void serialEvent(Serial myPort) {
  
  // read a byte from the serial port:
  int inByte = myPort.read();
  
   
  if ((inByte>='0') && (inByte<='9')) {
    value = 10*value + inByte - '0';
  } else {
    if (inByte=='c') channel = value;
    else if (inByte=='w') {
      println("Done reading", channel, value);  // here we have the full data message saved in 'channel' and 'value'
    }
    value = 0;
  }
}
