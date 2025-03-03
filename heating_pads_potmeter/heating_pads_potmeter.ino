// heat A connections
int enA = 3;//9;
int in1 = 5;//8;
int in2 = 4;//7;

int pot_sensor;
float heat;

int mic_threshold = 100;
int mic_sensor;


void setup() {
  Serial.begin(9600);
	// Set the heat control pins to outputs
  pinMode(enA, OUTPUT);
	pinMode(in1, OUTPUT);
	pinMode(in2, OUTPUT);
	
  pinMode(A0, INPUT); // potentiometer
  pinMode(A1, INPUT); // mic sensor

	// Turn off heat - Initial state
	digitalWrite(in1, HIGH);
	digitalWrite(in2, LOW);
}

void loop() {
  
  mic_sensor = analogRead(A1);
  Serial.println(mic_sensor);
  if (mic_sensor > mic_threshold){
    setHeat(255, 10000); // setHeat(heat, milliseconds); range for heat is 0-255
    //setHeat(0, 10000);
    setHeat(255, 10000);
    //setHeat(0, 4000);
    setHeat(255, 10000);
    //setHeat(0, 4000);
    setHeat(255, 10000);
    //setHeat(0, 4000);
    setHeat(255, 10000);
    
    setHeat(0, 0);

  }
  
  analogWrite(enA, 255);
}

void setHeat(int heat, int delay_){
  Serial.print("Heat: ");
  Serial.println(heat);
  analogWrite(enA, heat);
  delay(delay_);
}
