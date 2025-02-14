import ch.bildspur.artnet.*;

ArtNetClient artnet;

int [] universes = {1,2,3,4}; // edit to match setting in saveDMX Processing sketch...

String [][] dmxData;

/*
String[] dmxData_uni_1;
String[] dmxData_uni_2;
String[] dmxData_uni_3;
String[] dmxData_uni_4;
*/

int index = 0;
int nr_of_samples;

String [][] single_frame;
/*
String[] single_frame_uni_1;
String[] single_frame_uni_2;
String[] single_frame_uni_3;
String[] single_frame_uni_4;
*/
void setup(){
  
  single_frame = new String [universes.length][512];
  
  /*
  single_frame_uni_1 = new String[512];
  single_frame_uni_2 = new String[512];
  single_frame_uni_3 = new String[512];
  single_frame_uni_4 = new String[512];
  */
  
  nr_of_samples = loadStrings("dmxData_uni"+universes[0]+".txt").length;
  println(nr_of_samples, universes.length);
  
  dmxData = new String [universes.length][nr_of_samples];
  
  for (int u = 0; u < universes.length; u++){
    dmxData[u] = loadStrings("dmxData_uni"+universes[u]+".txt");
  }
  /*
  dmxData_uni_1 = loadStrings("dmxData_uni1.txt");
  dmxData_uni_2 = loadStrings("dmxData_uni2.txt");
  dmxData_uni_3 = loadStrings("dmxData_uni3.txt");
  dmxData_uni_4 = loadStrings("dmxData_uni4.txt");
  */
  //nr_of_samples = dmxData_uni_1.length;
  size(512,40);
  artnet = new ArtNetClient(null);
  artnet.start();
}

void draw(){
  if (index < nr_of_samples){
    
    for (int u = 0; u < universes.length; u++){
      single_frame[u] = split(dmxData[u][index], " ");
    }
    /*
    single_frame_uni_1 = split(dmxData_uni_1[index], " ");
    single_frame_uni_2 = split(dmxData_uni_2[index], " ");
    single_frame_uni_3 = split(dmxData_uni_3[index], " ");
    single_frame_uni_4 = split(dmxData_uni_4[index], " ");
    */
    for (int u = 0; u < universes.length; u++){
      println("line", 10*u,10+10*u);
      for (int i = 0; i < 512; i++){
        
        stroke(int(single_frame[u][i]));
        line(i,10*u,i,10+10*u);
        
        //stroke(int(single_frame[u][i]), 255, 0);
        //line(i,10,i,20);
        //stroke(int(single_frame[u][i]), 0, 255);
        //line(i,20,i,30);
        
        //stroke(int(single_frame[u][i]));
        //line(i,30,i,40);
      }
    }
    for (int u = 0; u < universes.length; u++){
      artnet.unicastDmx("192.168.1.20", 0, universes[u], dmxToByte(single_frame[u]));
    }
    /*
    artnet.unicastDmx("192.168.1.20", 0, 1, dmxToByte(single_frame_uni_1));
    artnet.unicastDmx("192.168.1.20", 0, 2, dmxToByte(single_frame_uni_2));
    artnet.unicastDmx("192.168.1.20", 0, 3, dmxToByte(single_frame_uni_3));
    artnet.unicastDmx("192.168.1.20", 0, 4, dmxToByte(single_frame_uni_4));
    */
  }
  index++;
  
}



byte[] dmxToByte(String[] sa){
  byte[]  byteArray = new byte[512];
  for (int i = 0; i < 512; i++){
    byteArray[i] = byte(int(sa[i]));
  }
  return byteArray;
}
