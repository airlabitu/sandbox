XML xml;

void loadSettings() {
  xml = loadXML("settings.xml");
   
  // framerate
  XML data = xml.getChild("framerate");
  framerate = data.getIntContent();
  // display
  data = xml.getChild("display");
  display = boolean(data.getContent());
  // frames-to-record
  data = xml.getChild("frames-to-record");
  frames_to_record = data.getIntContent();
  // ip address
  data = xml.getChild("ip-address");
  ip_address = data.getContent();
  // DMX universes
  XML [] universes = xml.getChild("universes").getChildren("value");
  dmx_universes = new int [universes.length];
  for (int i = 0; i < universes.length; i++){
    dmx_universes[i] = universes[i].getIntContent();
  }
}
