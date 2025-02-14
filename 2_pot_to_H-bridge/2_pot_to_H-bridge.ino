#define pot_a_pin A3
#define pot_b_pin A2

int pot_a_value;
int pot_b_value;

int heat_a;
int heat_b;

// Motor A connections
int enA = 9;
int in1 = 8;
int in2 = 7;
// Motor B connections
int enB = 3;
int in3 = 5;
int in4 = 4;

void setup() {
  Serial.begin(9600);
  pinMode(pot_a_pin, INPUT);
  pinMode(pot_b_pin, INPUT);

  // Turn off motors - Initial state
  pinMode(enA, OUTPUT);
	pinMode(enB, OUTPUT);
	pinMode(in1, OUTPUT);
	pinMode(in2, OUTPUT);
	pinMode(in3, OUTPUT);
	pinMode(in4, OUTPUT);

  // Turn on motors - Initial state
	digitalWrite(in1, HIGH);
	digitalWrite(in2, LOW);
	digitalWrite(in3, HIGH);
	digitalWrite(in4, LOW);
}

void loop() {
  // Side A
  pot_a_value = analogRead(pot_a_pin); // reads the sensor (knop)
  heat_a = map(pot_a_value, 0, 1023, 0, 102); // translates from sensor scale (0-1023) to heat output scale (0-102) [0 - 4.95 V]
  analogWrite(enA, heat_a); // updates the heat output
  // print the 
  Serial.print("[A] voltage output: ");
  Serial.println(heat_a/20.59);

  // Side B
  pot_b_value = 1023-analogRead(pot_b_pin); // reads the sensor (knop), and reverse direction for equal interaction on the box
  heat_b = map(pot_b_value, 0, 1023, 0, 255);
  analogWrite(enB, heat_b);
  Serial.print("[B] voltage output: ");
  Serial.println(heat_b/20.59);
  
  Serial.println();
	
  delay(500);
}
