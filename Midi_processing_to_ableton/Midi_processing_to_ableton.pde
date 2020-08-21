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
  /*
  tracks[0] = new Track("track 0", 0, myBus);
  tracks[1] = new Track("track 1", 1, myBus);
  tracks[2] = new Track("track 2", 2, myBus);
  tracks[3] = new Track("track 3", 3, myBus);
  tracks[4] = new Track("track 4", 4, myBus);
  tracks[5] = new Track("track 5", 5, myBus);
  */
  
  tracks[round(random(0,2))].start();
  tracks[round(random(3,5))].start();
  tracksPlaying = 2;
}

void draw() {
  if (!mapping){
    for (int i = 0; i < tracks.length; i++){
      tracks[i].update();
    }
    /*
    tracks[0].update();
    tracks[1].update();
    tracks[2].update();
    tracks[3].update();
    tracks[4].update();
    tracks[5].update();
    */
  }

  if (millis() > timer + interval){
    timer = millis();
    interval = int(random(5000, 10000));
    float val = round(random(1000)/1000);
   
    println(val);
    
    if (val == 0) {
      println("start a track");
      if (tracksPlaying < 3){
        int trackIndex = round(random(tracks.length-1));
        println("attempting start of track ", trackIndex);
        boolean succes = false;
        succes = tracks[trackIndex].start();
        if (succes) {
          tracksPlaying ++;
          println("succes");
        }
        else println("fail");
      }
      else println("too many tracks running");
    }
    else {
      println("stop a track");
      if (tracksPlaying > 1){
        int trackIndex = round(random(tracks.length-1));
        println("attempting stop of track ", trackIndex);
        boolean succes = false;
        succes = tracks[trackIndex].stop();
        if (succes) {
          tracksPlaying --;
          println("succes");
        }
        else println("fail");
      }
      else println("not enough tracks running");
    }
    print("tracks running: ");
    for (int i = 0; i < tracks.length; i++){
      if (tracks[i].state == 0 || tracks[i].state == 1) print(i, "YES ");
      else print(i, "NO ");
    }
    println();
    println("total running: ", tracksPlaying);
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
    /*
    if (key == '0') myBus.sendControllerChange(0, tracks[0].number, 0);
    else if (key == '1') myBus.sendControllerChange(0, tracks[1].number, 0);
    else if (key == '2') myBus.sendControllerChange(0, tracks[2].number, 0);
    else if (key == '3') myBus.sendControllerChange(0, tracks[3].number, 0);
    */
  }
 
  /*
  if (key=='s') tracks[0].start();
  else if (key=='e') tracks[0].stop();
  */
}
