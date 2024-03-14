#include <DmxSimple.h>


int state = 1;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  DmxSimple.usePin(3);
  DmxSimple.maxChannel(111);
}

void loop() {
  // put your main code here, to run repeatedly:
  switch (state) {
    
    case 1:
      Serial.println("s1");
      // intro - default to black
      DmxSimple.write(100, 0);
      DmxSimple.write(101, 0);
      DmxSimple.write(102, 0);
      
      // state visuals
      for(int r = 0; r < 255; r++){
        DmxSimple.write(100, r);
        delay(10);
      }

      // outro
      for(int r = 255; r > 0; r--){
        DmxSimple.write(100, r);
        delay(3);
      }
      // change state
      state = 2;


      break;

    case 2:
      Serial.println("s2");
      DmxSimple.write(100, 0);
      DmxSimple.write(101, 0);
      DmxSimple.write(102, 0);
      for(int g = 0; g < 255; g++){
        DmxSimple.write(101, g);
        delay(10);
      }
      state = 3;
      break;

    case 3:
      Serial.println("s3");
      DmxSimple.write(100, 0);
      DmxSimple.write(101, 0);
      DmxSimple.write(102, 0);
      for(int b = 0; b < 255; b++){
        DmxSimple.write(102, b);
        delay(10);
      }
      state = 1;
      break;
  }

}


