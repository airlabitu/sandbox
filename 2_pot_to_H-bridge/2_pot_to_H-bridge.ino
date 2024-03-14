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
  pot_a_value = analogRead(pot_a_pin);
  heat_a = map(pot_a_value, 0, 1023, 0, 255);
  pot_b_value = 1023-analogRead(pot_b_pin); // reverse direction for equal interaction on the box
  heat_b = map(pot_b_value, 0, 1023, 0, 255);

  Serial.println(pot_a_value);
  Serial.println(pot_b_value);
  Serial.println();
  analogWrite(enA, heat_a);
	analogWrite(enB, heat_b);
  delay(100);
}
