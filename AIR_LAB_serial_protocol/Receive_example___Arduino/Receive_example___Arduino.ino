// AIR Lab serial protocol.
// we are using the protocol from the SimpleDMX library.
// and have made send and receive examples for two-way communication between Processing and Arduino

// Arduino (sending) -> Processing (receiving)
// Processing (sending) -> Arduino (receiving)

// link to all codes: https://github.com/airlabitu/sandbox/tree/master/AIR_LAB_serial_protocol


void setup() {
  Serial.begin(9600);
  Serial.println();
  Serial.println("Syntax:");
  Serial.println(" 123c : use channel 123");
  Serial.println(" 45w  : set current channel to value 45");
}

int value = 0;
int channel;

void loop() {
  int c;

  while(!Serial.available());
  c = Serial.read();
  if ((c>='0') && (c<='9')) {
    value = 10*value + c - '0';
  } else {
    if (c=='c') channel = value;
    else if (c=='w') {
      // here you have received the whole message, and can act on the channel and value variables
      if (channel == 1) {
        Serial.print("Set motor 1 to value: ");
        Serial.println(value);
      }
      else if(channel == 2){
        Serial.print("Set motor 2 to value: ");
        Serial.println(value);
      }
      Serial.println();
    }
    value = 0;
  }
}
