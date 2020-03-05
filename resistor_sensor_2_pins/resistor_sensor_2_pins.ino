// code by Halfdan Hauch Jensen (halj@itu.dk), AIR LAB ITU

// Builds on this tutorial: https://www.circuitbasics.com/arduino-ohm-meter/

// Code and wiring is altered in order to detect two resistors simultaniously, and that I was unable to make 
// the tutorial work as intented, with the given schematics and code.

// GUIDE
  // Put a permanent resistor (i used 1K) between 5v and A0, and another one between 5v and A2
  // To get a reading connect a resistor between either GND and A0, or GND and A2.

// NB!
  // The values are not accurate ohm readings as the original tutorial is aiming at, but can be used as sensor values to differentiate bewteen different resistors.
  // this might be usable for detecting what object is placed on top of a sensor...
  // This was a quick and dirty attempt at this, and must be read as such :-)

int sensorPin1= A0; // sensor 1
int sensorPin2= A2; // sensor 2

int Vin= 5;
boolean led = false;

int raw_1= 0; // sensor 1
float Vout_1= 0; // sensor 1
float R1_1= 1000; // sensor 1
float R2_1= 0; // sensor 1
float buffer_1= 0; // sensor 1



int raw_2= 0; // sensor 2
float Vout_2= 0; // sensor 2
float R1_2= 1000; // sensor 2
float R2_2= 0; // sensor 2
float buffer_2= 0; // sensor 2




void setup()
{
Serial.begin(9600);
pinMode(13, OUTPUT);
}

void loop()
{
raw_1= analogRead(sensorPin1);
if(raw_1) 
{
buffer_1= raw_1 * Vin;
Vout_1= (buffer_1)/1024.0;
buffer_1= (Vin/Vout_1) -1;
R2_1= R1_1 * buffer_1;
Serial.print("Vout 1: ");
Serial.println(Vout_1);
Serial.print("R2_1: ");
Serial.println(R2_1);
}



raw_2= analogRead(sensorPin2);
if(raw_2) 
{
buffer_2= raw_2 * Vin;
Vout_2= (buffer_2)/1024.0;
buffer_2= (Vin/Vout_2) -1;
R2_2= R1_2 * buffer_2;
Serial.print("Vout_2: ");
Serial.println(Vout_2);
Serial.print("R2_2: ");
Serial.println(R2_2);
Serial.println();
}

led=!led; // toggeling LED in order to see if the Arduino chrashed
digitalWrite(13, led);

delay(1000); // delay to slow down readings

}
