#include <FastLED.h>

#define rows 12
#define columns 100

int dir_count = 0;

//int data_pins [] = {22,23,24,25,26,27,28,29,30,31,32,33,34,35,36}; // length needs to match rows

int timer_intervals[]{ 40, 30, 50, 30, 40, 50, 30, 50, 30, 50, 30, 50 };
unsigned long timers[]{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
int rain_positions[12][100];
bool dir = false;

CRGB leds[rows][columns];

int space_to_next_drop = 5;

void setup() {


  Serial.begin(9600);
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
  //FastLED.addLeds<NEOPIXEL, 32>(leds[0], columns);
  //FastLED.addLeds<NEOPIXEL, 33>(leds[11], columns);
  FastLED.addLeds<NEOPIXEL, 21>(leds[10], columns);
  FastLED.addLeds<NEOPIXEL, 14>(leds[11], columns);
  //FastLED.addLeds<NEOPIXEL, 13>(leds[14], columns);
  for (int c = columns - 1; c >= 0; c--) {
    Serial.println(c);
  }
  rain_positions[0][0] = 1;  // test drop
}

void loop() {
  bool changes_to_make = false;

  for (int r = 0; r < rows; r++) {



    if (millis() > timers[r] + timer_intervals[r]) {
      timers[r] = millis();
      changes_to_make = true;
      
      dir_count ++;
      if (dir_count > 2000){
        dir_count = 0;
        dir = !dir;
      }

      if (dir){
        
        // move all existing drops
        for (int c = columns - 1; c >= 0; c--) {
          if (rain_positions[r][c] == 1) {
            rain_positions[r][c] = 0;                                // turn off old one
            if (c + 1 <= columns - 1) rain_positions[r][c + 1] = 1;  // turn on new one
          }
        }

        // add new drop in the front
        bool drop_found = false;
        for (int c = 0; c < space_to_next_drop; c++) {
          if (rain_positions[r][c] == 1) drop_found = true;
        }
        if (!drop_found) {
          rain_positions[r][0] = 1;
          space_to_next_drop = int(random(4, 10));
        }
      }

      else{
        // move all existing drops
        for (int c = 0; c <= columns-1; c++) {
          if (rain_positions[r][c] == 1) {
            rain_positions[r][c] = 0;                                // turn off old one
            if (c - 1 >= 0) rain_positions[r][c - 1] = 1;  // turn on new one
          }
        }

        // add new drop in the front
        bool drop_found = false;
        for (int c = columns - 1; c > columns - 1 - space_to_next_drop; c--) {
          if (rain_positions[r][c] == 1) drop_found = true;
        }
        if (!drop_found) {
          rain_positions[r][columns - 1] = 1;
          space_to_next_drop = int(random(4, 10));
        }
      }

      // send new pixels to physical strip
      for (int c = 0; c < columns; c++) {

        if (rain_positions[r][c] == 1) {
          leds[r][c] = CRGB(50, 50, 50);
          if (c - 1 >= 0) leds[r][c - 1] = CRGB(255, 255, 255);
          if (c - 2 >= 0) leds[r][c - 2] = CRGB(50, 50, 50);
        } else leds[r][c] = CRGB(0, 0, 0);
      }
    }
  }

  if (changes_to_make) {
    FastLED.show();
  }
}
