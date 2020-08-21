#include <SPI.h>
#include <FreeStack.h>
#include <SdFat.h>
#include <vs1053_SdFat.h>

/*
// Below is not needed if interrupt driven. Safe to remove if not using.
#if defined(USE_MP3_REFILL_MEANS) && USE_MP3_REFILL_MEANS == USE_MP3_Timer1
  #include <TimerOne.h>
#elif defined(USE_MP3_REFILL_MEANS) && USE_MP3_REFILL_MEANS == USE_MP3_SimpleTimer
  #include <SimpleTimer.h>
#endif
*/

SdFat sd;
vs1053 MP3player;

void setup() {

  Serial.begin(115200);

  //Initialize the SdCard.
  if(!sd.begin(SD_SEL, SPI_FULL_SPEED)) sd.initErrorHalt();
  if(!sd.chdir("/")) sd.errorHalt("sd.chdir");

  //Initialize the MP3 Player Shield
  MP3player.begin();

  // Play file track001.mp3
  MP3player.playTrack(1);
}


void loop() {}
