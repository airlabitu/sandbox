import ch.bildspur.artnet.*;

ArtNetClient artnet;

int [] universes = {1,2,3,4}; // edit to match setting in saveDMX Processing sketch...

String [][] dmxData;

int index = 0;
int nr_of_samples;

//String [][] single_frame;

byte [][][] all_DMX_frames;

boolean display_data = true;
boolean loop_data = false;


void setup(){
  
  
  //single_frame = new String [universes.length][512];
  
  nr_of_samples = loadStrings("dmxData_uni"+universes[0]+".txt").length;
  
  all_DMX_frames = new byte [universes.length][nr_of_samples][512]; // [univeses][samples/indexes][pixel data]
  
  
  
  //println(nr_of_samples, universes.length);
  
  dmxData = new String [universes.length][nr_of_samples];
  
  for (int u = 0; u < universes.length; u++){
    dmxData[u] = loadStrings("dmxData_uni"+universes[u]+".txt");
  }
  
  // save full dataset into 3D byte array
  for (int u = 0; u < universes.length; u++){ // universe
    for(int s = 0; s < nr_of_samples; s++){ // samples
      all_DMX_frames[u][s] = dmxToByte(split(dmxData[u][s], " "));
    }
  }
  
  /*
  if (index < nr_of_samples){
    for (int u = 0; u < universes.length; u++){
      single_frame[u] = split(dmxData[u][index], " ");
    }
  */
  size(512,40);
  artnet = new ArtNetClient(null);
  artnet.start();
}

void draw(){
  if (index < nr_of_samples){
    /*
    for (int u = 0; u < universes.length; u++){
      single_frame[u] = split(dmxData[u][index], " ");
    }
    */
    /*
    for (int u = 0; u < universes.length; u++){
      for (int i = 0; i < 512; i++){
        stroke(int(single_frame[u][i]));
        line(i,10*u,i,10+10*u);
      }
    }
    */
    for (int u = 0; u < universes.length; u++){
      artnet.unicastDmx("192.168.1.20", 0, universes[u], all_DMX_frames[u][index]);
      if (display_data){
        for (int i = 0; i < 512; i++){
          stroke(int(all_DMX_frames[u][index][i]));
          line(i,10*u,i,10+10*u);
        }
      }
    }
    
    /*
    for (int u = 0; u < universes.length; u++){
      artnet.unicastDmx("192.168.1.20", 0, universes[u], dmxToByte(single_frame[u]));
    }
    */
    
    
    
  }
  index++;
  if (loop_data && index > nr_of_samples) index = 0;
  
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
