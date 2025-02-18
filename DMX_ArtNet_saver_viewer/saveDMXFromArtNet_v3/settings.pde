XML xml;

void loadSettings() {
  
  xml = loadXML("settings.xml");
    
  // framerate
  XML data = xml.getChild("framerate");
  framerate = data.getIntContent();
  //println(data.getContent(), framerate);
  
  // display
  data = xml.getChild("display");
  display = boolean(data.getContent());
  //println(data.getContent(), display);
  
  // frames-to-record
  data = xml.getChild("frames-to-record");
  frames_to_record = data.getIntContent();
  //println(data.getContent(), frames_to_record);
  
  // ip address
  data = xml.getChild("ip-address");
  ip_address = data.getContent();
  println(data.getContent(), ip_address);
  
  // DMX universes
  XML [] universes = xml.getChild("universes").getChildren("value");
  dmx_universes = new int [universes.length];
  for (int i = 0; i < universes.length; i++){
    dmx_universes[i] = universes[i].getIntContent();
    println(i, universes[i].getContent(), dmx_universes[i]);
  }
}
