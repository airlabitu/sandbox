import ch.bildspur.artnet.*;

ArtNetClient artnet;

final int [] universes = {1,2,3,4}; // edit to match setting in saveDMX Processing sketch...

String [][] dmxData;

int current_frame = 0;

int nr_of_frames;

byte [][][] all_DMX_frames;

boolean display_data = true;
boolean loop_data = false;


void setup(){
  
  nr_of_frames = loadStrings("dmxData_uni_"+universes[0]+".txt").length;
  
  all_DMX_frames = new byte [universes.length][nr_of_frames][512]; // [univese][frame][pixel data]
    
  dmxData = new String [universes.length][nr_of_frames];
  
  for (int u = 0; u < universes.length; u++){
    dmxData[u] = loadStrings("dmxData_uni_"+universes[u]+".txt");
  }
  
  // save full dataset into 3D byte array
  for (int u = 0; u < universes.length; u++){ // universe
    for(int f = 0; f < nr_of_frames; f++){ // samples
      all_DMX_frames[u][f] = dmxToByte(split(dmxData[u][f], " "));
    }
  }
  size(512,40);
  artnet = new ArtNetClient(null);
  artnet.start();
}

void draw(){
  if (current_frame < nr_of_frames){
    for (int u = 0; u < universes.length; u++){
      artnet.unicastDmx("192.168.1.20", 0, universes[u], all_DMX_frames[u][current_frame]);
      if (display_data){
        for (int i = 0; i < 512; i++){
          stroke(int(all_DMX_frames[u][current_frame][i]));
          line(i,10*u,i,10+10*u);
        }
      }
    }  
  }
  current_frame++;
  if (loop_data && current_frame > nr_of_frames) current_frame = 0;
  
}


byte[] dmxToByte(String[] sa){
  byte[]  byteArray = new byte[512];
  for (int i = 0; i < 512; i++){
    byteArray[i] = byte(int(sa[i]));
  }
  return byteArray;
}

void keyReleased(){
  if (key == 'd') display_data = !display_data;
  if (key == 'l') loop_data = !loop_data;
}
