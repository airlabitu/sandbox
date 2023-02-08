#include <FastLED.h>

#define NUM_LEDS 1
#define DATA_PIN A5
// Define the array of leds
CRGB leds[NUM_LEDS];

void setup() 
{
  //initialize serial communications at a 9600 baud rate
  Serial.begin(9600);

  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);
  
  // turn off the LED
  leds[0] = CRGB(0,0,0);
  FastLED.show();
}

void loop()
{
  // turn on the LED (red color)
  leds[0] = CRGB(255,0,0);
  FastLED.show();
  
  delay(1000); // wait 1 sec
  
  // turn off the LED
  leds[0] = CRGB(0,0,0);
  FastLED.show();
  
  delay(1000); // wait 1 sec
  



}
