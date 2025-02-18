XML xml;

void loadSettings() {
  xml = loadXML("record_settings.xml");
   
  // framerate
  XML data = xml.getChild("framerate");
  framerate = data.getIntContent();
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

void saveViewerSettings(){
  XML viewer_xml_settings = loadXML(path_to_viewer+"run_settings.xml");
  viewer_xml_settings.getChild("framerate").setContent(""+framerate);
  XML child_to_remove = viewer_xml_settings.getChild("universes");
  viewer_xml_settings.removeChild(child_to_remove);
  viewer_xml_settings.addChild(xml.getChild("universes"));
  saveXML(viewer_xml_settings, path_to_viewer+"run_settings.xml");
}
