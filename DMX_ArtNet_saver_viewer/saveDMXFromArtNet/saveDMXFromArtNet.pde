import ch.bildspur.artnet.*;

int samples_to_record = 300;

int nr_of_universes = 2;

byte[][] dmxData_uni_1 = new byte[samples_to_record][512];
byte[][] dmxData_uni_2 = new byte[samples_to_record][512];
byte[][] dmxData_uni_3 = new byte[samples_to_record][512];

int index = 0;

ArtNetClient artnet;

void setup()
{
  size(500, 250);
  textAlign(CENTER, CENTER);
  textSize(20);

  // create artnet client
  artnet = new ArtNetClient();
  artnet.start("127.0.0.1");
}

void draw()
{
  // read rgb color from the first 3 bytes
  if (index < samples_to_record){
    
    if (nr_of_universes > 0){
      byte[] data_uni_1 = artnet.readDmxData(0, 1);
      dmxData_uni_1[index] = data_uni_1;
    }
    if (nr_of_universes > 1){
      byte[] data_uni_2 = artnet.readDmxData(0, 2);
      dmxData_uni_2[index] = data_uni_2;
    }
    if (nr_of_universes > 2){
      byte[] data_uni_3 = artnet.readDmxData(0, 3);
      dmxData_uni_3[index] = data_uni_3;
    }
    
    index++;
  }
  else {
    // add all wanted universes here
    saveDMXUniverse(dmxData_uni_1, 1);
    saveDMXUniverse(dmxData_uni_2, 2);
    saveDMXUniverse(dmxData_uni_2, 3);
    exit();
  }

  // set background
  background(0);


}

void saveDMXUniverse(byte[][] data, int univ_nr){
  String s[] = new String[data.length];
  for (int i = 0; i < data.length; i++){
    s[i] = "";
    for (int j = 0; j < 512; j++){
      s[i]+= str(data[i][j])+" ";
     }
  }
  saveStrings("dmxData_uni"+univ_nr+".txt", s);
}
