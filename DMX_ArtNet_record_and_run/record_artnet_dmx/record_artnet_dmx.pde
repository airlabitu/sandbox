import ch.bildspur.artnet.*;

int frames_to_record; // specify the number of samples to record
int [] dmx_universes; // edit to match source output "MadMapper" etc.
byte[][][] dmxData;// = new byte[dmx_universes.length][frames_to_record][512];
String ip_address; // set IP used by source "MadMapper" etc. 
int framerate;
int frame = 0;
String path_to_viewer = "../run_artnet_dmx/";

ArtNetClient artnet;

void settings(){
  loadSettings();
  
  println("FrameRate:", framerate);
  println("IP:", ip_address);
  println("Frames to record:", frames_to_record);
  print("DMX universes:");
  for (int i = 0; i < dmx_universes.length; i++) print(" ", dmx_universes[i]);
  println();
  
  dmxData = new byte[dmx_universes.length][frames_to_record][512];
  artnet = new ArtNetClient();
  artnet.start(ip_address);
  size(400, 200);
}

void setup()
{
  frameRate(framerate); 
  startScreen();
}

void draw()
{
  if (recording && frame < frames_to_record){ // recording started
    
    for (int u = 0; u < dmx_universes.length; u++){
        dmxData[u][frame] = artnet.readDmxData(0, dmx_universes[u]);
    } 
    frame++;
  }
  else if (recording) { // recording ended
    // add all wanted universes here
    for (int u = 0; u < dmx_universes.length; u++){
      saveDMXUniverse(dmxData[u], dmx_universes[u]);
    }
    saveViewerSettings(); // save settings for viewer 
    exit();
  }
}

void saveDMXUniverse(byte[][] data, int univ_nr){
  String data_to_save[] = new String[data.length];
  for (int i = 0; i < data.length; i++){
    data_to_save[i] = "";
    for (int j = 0; j < 512; j++){
      data_to_save[i]+= str(data[i][j])+" ";
     }
  }
  saveStrings(path_to_viewer+"data/dmxData_uni_"+univ_nr+".txt", data_to_save);
}
