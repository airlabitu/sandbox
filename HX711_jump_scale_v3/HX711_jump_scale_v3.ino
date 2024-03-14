#include "HX711.h"

#define LOADCELL_DOUT_PIN 16
#define LOADCELL_SCK_PIN 4

float weight;
float weightTranslated;

int resetCount = 0;
unsigned long resetTimer = 0;

HX711 scale;

int loopCount = 0;
unsigned long lastloopCountTime = 0;

unsigned long weightPrintTimer = 0;

int jumpState = 0;
float jumpMax = 0;

unsigned long lightUpdateTimer = 0;
int lightUpdateInterval = 20;  // updates 50/sec

int upMoveTarget;
int upMoveCount;

int lightMovingDown = false;


float calibration_factor = -7050;  // -7050 worked for my 440lb max scale setup

void setup() {
  Serial.begin(9600);
  scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);
  scale.set_scale();
  scale.tare();                         //Reset the scale to 0
  scale.set_scale(calibration_factor);  //Adjust to this calibration factor
  Serial.println("Starting: Init scale reset");
}

int weightMaxCount = 0;

void loop() {

  // READING THE SCALE WEIGHT - every loop
  readScale();

  switch (jumpState) {

    case 0:                          // waiting for jump
      if (weightTranslated > 0.5) {  // jump started | 0.5 being a threashold value
        jumpMax = weightTranslated;
        jumpState = 1;
        Serial.print("Jump started ");
        Serial.println(jumpMax);
      }
      break;

    case 1:  // finding max weight
      if (weightTranslated > jumpMax) {
        jumpMax = weightTranslated;
        weightMaxCount = 0;
      } else {
        weightMaxCount++;
        if (weightMaxCount > 3) {  // Max weight found - if no new max weight was detected for 3 rounds the jump is over
          jumpState = 2;
          Serial.print("Jump ended ");
          Serial.println(jumpMax);

          upMoveTarget = jumpMax * 2;  // change here to impact the total distance (iterations) of the upmove
          Serial.print("upMoveTarget : ");
          Serial.println(upMoveTarget);

          jumpMax = 0;

          lightMovingDown = false;  // change to moving lights up
          upMoveCount = 0;     // reset the up move counter
        }
      }

      break;

    case 2:  // waiting for jumper to move away
      if (weightTranslated < 0.5) {
        jumpState = 0;
        Serial.println("Platform empty - start over");
      }
      break;
  }





  if (millis() > lightUpdateTimer + lightUpdateInterval) {
    lightUpdateTimer = millis();

    if (lightMovingDown) {  // down move ongoing
      /*
          Code for moving lights down
        */

    }

    else { // up move ongoing
      
      if (upMoveCount < upMoveTarget) {  // upMove target not reached yet
        upMoveCount++;
        /*
            code for moving light up
          */
      } 
      else lightMovingDown = true;  // upMove target reached, start moving down again
    }

  }






  // RESET SCALE - default value = 1000
  resetScale(1000);  // input : nr of continous readings to be off by > 0.3 before resetting

  // PRINT FRAME(loop) COUNT - default value = 2000
  printLoopCount(2000);  // input : nr of loops to calculate across

  // DEBUG PRINTS - last number default value = 1000
  if (millis() > weightPrintTimer + 1000) {  // last number is millis between prints  |  Set to 1 for printing all reading
    weightPrintTimer = millis();
    //printDebug();
  }

}


// --- HELPER FUNCTIONS ---

void printDebug() {

  Serial.print("Reading: ");
  Serial.print(weight);
  Serial.print(" ");
  Serial.print(weightTranslated);
  Serial.print(" lbs");  //Change this to kg and re-adjust the calibration factor if you follow SI units like a sane person
  Serial.print("    calibration_factor: ");
  Serial.print(calibration_factor);
  Serial.println();
}

void readScale() {
  weight = scale.get_units();
  // translate weight to prevent errors in the scale data
  if (weight > 700) weightTranslated = 1189.99 - weight;  // figure out how to handle this
  else if (weight > 0) weightTranslated = weight;
  else if (weight < -1000) weightTranslated = 0;  // figure out how to handle this
  else if (weight < 0) weightTranslated = weight * -1;
}

void printLoopCount(int nrOfLoops) {
  loopCount++;
  if (loopCount == nrOfLoops) {
    float avgMillisPerLoop = (millis() - lastloopCountTime) / loopCount;
    float loopsPerSec = 1000 / avgMillisPerLoop;
    Serial.println();
    Serial.print("Average millis for each loop: ");
    Serial.print(avgMillisPerLoop);
    Serial.print("  Loops per second: ");
    Serial.println(loopsPerSec);
    Serial.println();
    loopCount = 0;
    lastloopCountTime = millis();
  }
}

void resetScale(int loopsToReset) {
  if (millis() > resetTimer + 10) {  // runs every 10 millis. Due to fastest loop iteration measured being 12 millis/loop
    resetTimer = millis();
    if (abs(weight) > 0.3) {
      resetCount++;
      if (resetCount > loopsToReset) {  // reset the scale
        resetCount = 0;
        Serial.println();
        printDebug();
        scale.tare();  //Reset the scale to 0
        Serial.println("SCALE RESET");
        readScale();
        printDebug();
        Serial.println();
      }
    } 
    else resetCount = 0;
  }
}