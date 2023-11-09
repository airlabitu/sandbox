#include <FastLED.h>

#define rows 15
#define columns 200

int data_pins [] = {22,23,24,25,26,27,28,29,30,31,32,33,34,35,36}; // length needs to match rows

CRGB leds [ rows ][ columns ];

void setup() { 
    FastLED.addLeds<NEOPIXEL, 22>(leds[0], columns);
    FastLED.addLeds<NEOPIXEL, 23>(leds[1], columns);
    FastLED.addLeds<NEOPIXEL, 15>(leds[2], columns);
    FastLED.addLeds<NEOPIXEL, 25>(leds[3], columns);
    FastLED.addLeds<NEOPIXEL, 26>(leds[4], columns);
    FastLED.addLeds<NEOPIXEL, 27>(leds[5], columns);
    FastLED.addLeds<NEOPIXEL, 16>(leds[6], columns);
    FastLED.addLeds<NEOPIXEL, 17>(leds[7], columns);
    FastLED.addLeds<NEOPIXEL, 18>(leds[8], columns);
    FastLED.addLeds<NEOPIXEL, 19>(leds[9], columns);
    FastLED.addLeds<NEOPIXEL, 32>(leds[0], columns);
    FastLED.addLeds<NEOPIXEL, 33>(leds[11], columns);
    FastLED.addLeds<NEOPIXEL, 21>(leds[12], columns);
    FastLED.addLeds<NEOPIXEL, 14>(leds[13], columns);
    FastLED.addLeds<NEOPIXEL, 13>(leds[14], columns);
}

void loop() { 
  for (int r = 0; r < rows; r++){
    for (int c = 0; c < columns; c++){
      leds[r][c] = CRGB::Red;
    }   
  }
  FastLED.show();
  delay(5);
  for (int r = 0; r < rows; r++){
    for (int c = 0; c < columns; c++){
      leds[r][c] = CRGB::Black;
    }   
  }
  FastLED.show();
  delay(5);
}
