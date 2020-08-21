import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

Track [] tracks;

long timer = 0;
long interval = 10000;

int tracksPlaying;

boolean mapping = false;


void setup() {
  size(600, 400);
  background(0);
  frameRate(15);
  
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, -1, "Bus 1"); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
  
  
  tracks = new Track[6]; // initialize tracks array with size
  
  for (int i = 0; i < tracks.length; i++){
    tracks[i] = new Track("track " + i, i, myBus);
  }
  tracks[round(random(0,tracks.length))].start();
}

void draw() {
  if (!mapping){
    for (int i = 0; i < tracks.length; i++){
      tracks[i].update();
    }
  }
  
  if (millis() > timer + interval){
    println("time to take action");
    timer = millis();
    interval = int(random(5000, 10000));
    float val = round(random(1000)/1000);
   
    println(val);
    
    if (val == 0 && playingTrack(tracks) == -1) {
      println("start a track");
      int trackIndex = round(random(tracks.length-1));
      tracks[trackIndex].start();

    }
    else if (val == 0) println("a track is already running");
    
    if (val == 1 && playingTrack(tracks) != -1){
      
      println("stop running track");
      tracks[playingTrack(tracks)].stop();
    }
    else if (val == 1) println("no tracks to stop");
    print("tracks running: ");
    for (int i = 0; i < tracks.length; i++){
      if (tracks[i].isPlaying) print(i, "YES ");
      else print(i, "NO ");
    }
    println();
    println();
  }
  background(0);
  
  text("Mapping mode: " + mapping, 10, 30);
  
  for (int i = 0; i < tracks.length; i ++){
    rect(i*100+10, height-10, 80, -tracks[i].vol*3);
  }
  
}

// for mapping midi messages to vol channels in Ableton Live
void keyReleased(){
  println(char(4));
  if (key == 'm') mapping = !mapping; // toggle midi mapping mode
  
  if (mapping){ // ready to send midi control change messages if mapping mode is active
    String keyString = ""+key;
    for (int i = 0; i < tracks.length; i++){
      if (keyString.equals(""+i)) myBus.sendControllerChange(0, tracks[i].number, 0);
    }
  }
}

int playingTrack(Track [] tracksList){
  
  for (int i = 0; i < tracksList.length; i++){
    if (tracksList[i].isPlaying) return i;  
  }
  return -1;
}
