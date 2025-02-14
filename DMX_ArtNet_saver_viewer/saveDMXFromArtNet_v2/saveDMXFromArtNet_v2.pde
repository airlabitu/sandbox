import ch.bildspur.artnet.*;

int frames_to_record = 500; // specify the number of samples to record

int [] universes = {1,2,3,4}; // edit to match source output "MadMapper" etc.

byte[][][] dmxData = new byte[universes.length][frames_to_record][512];

final String ip_address = "127.0.0.1"; // set IP used by source "MadMapper" etc. 

int index = 0;

ArtNetClient artnet;

void setup()
{
  size(500, 250);
  frameRate(44); 

  // create artnet client
  artnet = new ArtNetClient();
  artnet.start(ip_address);
}

void draw()
{
  if (index < frames_to_record){
    
    for (int u = 0; u < universes.length; u++){
        dmxData[u][index] = artnet.readDmxData(0, universes[u]);
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
    for (int u = 0; u < universes.length; u++){
      saveDMXUniverse(dmxData[u], universes[u]);
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
