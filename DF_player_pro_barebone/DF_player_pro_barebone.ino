/*
Minimal example of how to play mp3 files with the DFPlayer Pro

This example is base on the library (DFRobot_DF1201S) example "play" by DF_Robot, and modified by AIR LAB ITU (airlab.itu.dk)
*/


#include <DFRobot_DF1201S.h>
#include <SoftwareSerial.h>

SoftwareSerial DF1201SSerial(2, 3);  //RX  TX

DFRobot_DF1201S DF1201S;
void setup(void){
  Serial.begin(115200);
  DF1201SSerial.begin(115200);
  while(!DF1201S.begin(DF1201SSerial)){
    Serial.println("Init failed, please check the wire connection!");
    delay(1000);
  }
  /*Set volume*/
  DF1201S.setVol(20);
  /*Enter music mode*/
  DF1201S.switchFunction(DF1201S.MUSIC);
  /*Wait for the end of the prompt tone */
  delay(2000);
  /*Set playback mode to "play track once"*/
  DF1201S.setPlayMode(DF1201S.SINGLE);

  Serial.print("total files: ");
  Serial.println(DF1201S.getTotalFile());
  Serial.println();

  Serial.println("tracks");
  for (int i = 1; i <= DF1201S.getTotalFile(); i++){
    
    DF1201S.playFileNum(i);
    Serial.print("[");
    Serial.print(i);
    Serial.print("]   ");
    Serial.println(DF1201S.getFileName());
    //delay(10);
  }

  DF1201S.playFileNum(5);
  Serial.println();
  Serial.print("now playing: ");
  Serial.println(DF1201S.getFileName());
  //delay(5000);
  //DF1201S.pause();
  //DF1201S.delCurFile();


  //DF1201S.pause();
  
  

}

void loop(){
  /*play file*/
  //DF1201S.playSpecFile("one.mp3"); // make sure to use the name of your mp3 file here
  //delay(21000); // pause the duration of the file + approx 4 sec.
  //DF1201S.playFileNum(3);
  //Serial.println(DF1201S.getFileName());
  //DF1201S.playSpecFile("TRACK001");
  //delay(216000); // // pause the duration of the file + approx 4 sec.
}
