import themidibus.*; //Import the library

MidiBus midi; // The MidiBus

Track [] tracks;

long timer1 = 0;
long interval1 = 10000; // start interval

long timer2 = 0;
long interval2 = 20; // frequence to send midi (milliseconds)

int tracksPlaying;

boolean mapping = false;


void setup() {
  size(600, 400);
  background(0);
  frameRate(15);
  
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  println();
  midi = new MidiBus(this, -1, "Bus 1"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  tracks = new Track[6]; // initialize tracks array with size
  
  for (int i = 0; i < tracks.length; i++){
    tracks[i] = new Track("track " + i, i);
  }
  
  tracks[round(random(0,tracks.length-1))].start();
}

void draw() {
  if (!mapping){
    for (int i = 0; i < tracks.length; i++){
      tracks[i].update();
    }
  }
  
  // send updated midi messages
  if (millis() > timer2 + interval2){
    timer2 = millis();
    if (!mapping){
      for (int i = 0; i < tracks.length; i++){
        midi.sendControllerChange(0, tracks[i].number, int(tracks[i].vol));
      }
    }
  }
  
  // change soundscape
  if (millis() > timer1 + interval1){ 
    // soundscape manipulations
    manipulateTracks(); 
  }
  
  // visualize tracks
  visualize();
}

// --- for mapping midi messages to vol channels in Ableton Live
void keyReleased(){
  println(char(4));
  if (key == 'm') mapping = !mapping; // toggle midi mapping mode
  
  if (mapping){ // ready to send midi control change messages if mapping mode is active
    String keyString = ""+key;
    for (int i = 0; i < tracks.length; i++){
      if (keyString.equals(""+i)) midi.sendControllerChange(0, tracks[i].number, 0);
    }
  }
}


// choose and take action on the tracks
void manipulateTracks(){
    if (playingTrack(tracks) == -1) { 
      int trackIndex = round(random(tracks.length-1));
      tracks[trackIndex].start();
      timer1 = millis(); // reload timer
      interval1 = int(random(10000, 40000)); // set lont interval after start
      println(interval1/1000, " sec to next stop");
    }    
    else if (playingTrack(tracks) != -1){
      tracks[playingTrack(tracks)].stop();
      timer1 = millis(); // reload timer
      interval1 = int(random(7000, 12000)); // set short interval after stop
      println(interval1/1000, " sec to next start");
    }
    println();
}

// --- draw track state to screen
void visualize(){
  background(0);
  text("Mapping mode: " + mapping, 10, 30);
  for (int i = 0; i < tracks.length; i ++){
    rect(i*100+10, height-10, 80, -tracks[i].vol*3);
  }
}

// --- get index of playing track, -1 if no tracks are playing
int playingTrack(Track [] tracksList){
  
  for (int i = 0; i < tracksList.length; i++){
    if (tracksList[i].isPlaying) return i;  
  }
  return -1;
}
