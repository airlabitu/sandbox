/* FAKEY FAKEY source code
 * 
 * Based on instructables by Simone Ferrecchia.
 * Altered by Thomas Kaufmanas, AIR LAB ITU, 2022
 *
 * See link for further Fakey Fakey documentation:
 * https://airlab.itu.dk/technologies/equipment/fakey-fakey/
 * 
 */

#include <Keyboard.h>
#include <Mouse.h>
#include <movingAvg.h>


//------- ADC level-thresholds for touch (default state is 200 and 300) -----//
const int PressedMaxThreshold = 200;
const int ReleasedMinThreshold = 300;
const byte PinCount = 12;
//---------------------------------------------------------------------------//


//-------- Arrays for defining input (keystrokes) on pins -------------------//
const byte InputPins[PinCount] = {A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11};
const char KeyCodes[PinCount] = {KEY_LEFT_ARROW,
                                 KEY_UP_ARROW,
                                 KEY_DOWN_ARROW,
                                 KEY_RIGHT_ARROW,
                                 MOUSE_LEFT,        // NB: Index 4 must be a Mouse-click (MOUSE_LEFT / MOUSE_RIGHT / MOUSE_MIDDLE)
                                 ' ',
                                 'A',
                                 'W',
                                 'S',
                                 'D',
                                 'Q',
                                 'E'
                                };
//---------------------------------------------------------------------------//


struct TouchInput //Structure for pin-objects
{
  byte analogPin;
  char keycode;
  movingAvg filter = movingAvg(20); //Averaging last 20 datapoints 
  boolean wasPressed = false;
};

TouchInput Pins[PinCount];  //Creating pin-objects

void setup()
{
  Serial.begin(115200);
  for (int i = 0; i < PinCount; i++)  //Providing data to all pin-objects
  {
    Pins[i].analogPin = InputPins[i];
    Pins[i].keycode = KeyCodes[i];
    Pins[i].filter.begin();
  }
  Mouse.begin();  //Starting mouse communication
}

void loop()
{
  for (int i = 0; i < PinCount; i++)
  {
    float currentAverage = Pins[i].filter.reading(analogRead(Pins[i].analogPin));
    boolean previousState = Pins[i].wasPressed;
    boolean currentState = previousState; // Default if in the dead zone

    if (currentAverage < PressedMaxThreshold)
    {
      currentState = true;      // Pressed
    }
    else if  (currentAverage > ReleasedMinThreshold)
    {
      currentState = false;      // Released
    }


//------ Section for sending keystroke-commands if state has changed! -------//
//------ The code checks for index4 (A4-pin) to use a specific function -----//
//------ for mouse-click, as described above. -------------------------------//

    if (currentState != previousState)
    {
      if (currentState) {
        if (i == 4) {                    
          Mouse.press(Pins[i].keycode);
        }
        else {
          Keyboard.press(Pins[i].keycode);
        }
      }
      else {
        if (i == 4) {
          Mouse.release(Pins[i].keycode);
        }
        else {
          Keyboard.release(Pins[i].keycode);
        }
      }
      Pins[i].wasPressed = currentState;
    }


    
  } //end of main for-loop
} //end of void-loop
