int dir_pin = 3;
int pulse_pin = 2;

void setup() {
  pinMode(dir_pin, OUTPUT);
  pinMode(pulse_pin, OUTPUT);
  digitalWrite(dir_pin, HIGH);
  // put your setup code here, to run once:

}

void loop() {
  digitalWrite(pulse_pin, HIGH);
  delay(2);
  digitalWrite(pulse_pin, LOW);
  delay(1);
  // put your main code here, to run repeatedly:

}
