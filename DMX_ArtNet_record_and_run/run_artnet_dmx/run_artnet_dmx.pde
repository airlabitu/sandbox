import ch.bildspur.artnet.*;

ArtNetClient artnet;

String [][] dmxData;
int current_frame = 0;
int nr_of_frames;
byte [][][] all_DMX_frames;

// xml settings variables
boolean display; // enables screen info
boolean loop; // loops DMX data
int framerate; // framerate to run this app. Set by the saver app
String ip_address; // ArtNet node (controller) ip
int [] dmx_universes; // used DMX universes. Set by the saver app

void settings(){
  loadSettings();
  
  println("FrameRate:", framerate);
  println("IP:", ip_address);
  println("Display", display);
  println("Loop", loop);
  print("DMX universes:");
  for (int i = 0; i < dmx_universes.length; i++) print(" ", dmx_universes[i]);
  println();
  
  if (display) size(40+512, 220+10*dmx_universes.length+10);
  
  // initialize data dependant variables and arrays
  nr_of_frames = loadStrings("dmxData_uni_"+dmx_universes[0]+".txt").length;
  all_DMX_frames = new byte [dmx_universes.length][nr_of_frames][512];
  dmxData = new String [dmx_universes.length][nr_of_frames];
  
  // load all universes DMX data
  for (int u = 0; u < dmx_universes.length; u++){
    dmxData[u] = loadStrings("dmxData_uni_"+dmx_universes[u]+".txt"); 
  }
  
  // save full dataset into 3D byte array
  for (int u = 0; u < dmx_universes.length; u++){ // universe
    for(int f = 0; f < nr_of_frames; f++){ // samples
      all_DMX_frames[u][f] = dmxToByte(split(dmxData[u][f], " "));
    }
  }
  artnet = new ArtNetClient(null);
  artnet.start();
}

void setup(){
  frameRate(framerate);
  if (display) staticScreenInfo();
}

void draw(){
  if (current_frame < nr_of_frames){
    for (int u = 0; u < dmx_universes.length; u++){
      artnet.unicastDmx("192.168.1.20", 0, dmx_universes[u], all_DMX_frames[u][current_frame]);
      if (display) showDMXData(u); // draw dynamic DMX data
    }  
  }
  current_frame++;
  if (loop && current_frame > nr_of_frames) current_frame = 0;
}

byte[] dmxToByte(String[] sa){
  byte[]  byteArray = new byte[512];
  for (int i = 0; i < 512; i++){
    byteArray[i] = byte(int(sa[i]));
  }
  return byteArray;
}
