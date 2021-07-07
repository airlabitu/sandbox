/**
 * This is a simple sound file player. Use the mouse position to control playback
 * speed, amplitude and stereo panning.
 */

import processing.sound.*;

Sound s;
SoundFile soundfile;

void setup() {
  size(640, 360);
  background(255);
  s = new Sound(this);
  Sound.list();
  s.outputDevice(1); // for some reasone 2: Headphones makes noise, 1: b1 seems to work okay
  
  // Load a soundfile
  soundfile = new SoundFile(this, "vibraphon.aiff");


  // Play the file in a loop
  soundfile.loop();
}      


void draw() {

}
