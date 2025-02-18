import ch.bildspur.artnet.*;

int frames_to_record = 500; // specify the number of samples to record

int [] dmx_universes; // edit to match source output "MadMapper" etc.

byte[][][] dmxData = new byte[dmx_universes.length][frames_to_record][512];

String ip_address = "127.0.0.1"; // set IP used by source "MadMapper" etc. 

int framerate = 44;
boolean display = true;
int index = 0;

ArtNetClient artnet;

void setup()
{
  size(512, 250);
  frameRate(framerate); 

  // create artnet client
  artnet = new ArtNetClient();
  artnet.start(ip_address);
  loadSettings();
}

void draw()
{
  if (index < frames_to_record){
    
    for (int u = 0; u < dmx_universes.length; u++){
        dmxData[u][index] = artnet.readDmxData(0, dmx_universes[u]);
        /*
        println("U", universes[u]);
        for (int i = 0; i < dmxData[u][index].length; i++){
          print(dmxData[u][index][i], " ");
        }
        println();
        */
    } 
    index++;
  }
  else {
    // add all wanted universes here
    for (int u = 0; u < dmx_universes.length; u++){
      saveDMXUniverse(dmxData[u], dmx_universes[u]);
    }
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
  saveStrings("dmxData_uni_"+univ_nr+".txt", data_to_save);
}
