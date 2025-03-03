/*
==========================================================================
  AIR Lab example. L298N H-Bridge, runs two vibration motors

  Wiring:

  ENA <-> pin 3
  INA <-> pin 4
  INB <-> pin 5
  ENB <-> pin 6
  INC <-> pin 7
  IND <-> pin 8
  
==========================================================================
*/

// Definitions Arduino pins connected to input H Bridge

// Output A-B (motor 1)
int EN_A = 3;
int IN_A = 4;
int IN_B = 5;

// Output A-B (motor 2)
int EN_B = 6;
int IN_C = 7;
int IN_D = 8;



void setup()
{
// Set the output pins for motor 1
pinMode(EN_A, OUTPUT);
pinMode(IN_A, OUTPUT);
pinMode(IN_B, OUTPUT);

// Set the output pins for motor 2
pinMode(EN_B, OUTPUT);
pinMode(IN_C, OUTPUT);
pinMode(IN_D, OUTPUT);

// initial state (ON) motor 1
digitalWrite(IN_A, HIGH);
digitalWrite(IN_B, LOW);

// initial state (ON) motor 2
digitalWrite(IN_C, HIGH);
digitalWrite(IN_D, LOW);
}


void loop()
{
// Motor 1
analogWrite(EN_A, 255); // set speed, val 0-255
delay(1000);
analogWrite(EN_A, 0);
delay(1000);

// Motor 2
analogWrite(EN_B, 255); // set speed, val 0-255
delay(1000);
analogWrite(EN_B, 0);
delay(1000);

}