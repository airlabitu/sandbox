// XML xml;

void loadSettings() {
  XML xml = loadXML("run_settings.xml");
  // framerate
  XML data = xml.getChild("framerate");
  framerate = data.getIntContent();
  // ip address
  data = xml.getChild("ip-address");
  ip_address = data.getContent();
  // display
  data = xml.getChild("display");
  display = boolean(data.getContent());
  // loop
  data = xml.getChild("loop");
  loop = boolean(data.getContent());
  // DMX universes
  XML [] universes = xml.getChild("universes").getChildren("value");
  dmx_universes = new int [universes.length];
  for (int i = 0; i < universes.length; i++){
    dmx_universes[i] = universes[i].getIntContent();
  }
}
