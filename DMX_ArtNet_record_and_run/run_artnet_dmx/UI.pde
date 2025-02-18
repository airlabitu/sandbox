void staticScreenInfo(){
  background(0);
  textSize(18);
  fill(255);
  String settings_text = 
    "Framerate: " + framerate + "\n"
    +"ArtNet output IP: " + ip_address + "\n"
    +"Total frames: " + nr_of_frames + "\n"
    +"DMX universes:\n[";
    for (int i = 0; i < dmx_universes.length; i++) settings_text += " " + dmx_universes[i];
  settings_text += " ]\n"
  + "Loop: " + loop;  
  text(settings_text, 10, 30);
  fill(100);
  text("change settings from 'run_settings.xml'", 10, 180);
  textSize(12);
  fill(255);
  for (int i = 0; i < dmx_universes.length; i++) text("Uni "+dmx_universes[i], 10, 220+i*10+10);
}

void showDMXData(int u){
  for (int i = 0; i < 512; i++){
    stroke(int(all_DMX_frames[u][current_frame][i]));
    line(40+i,220+10*u,40+i,220+10+10*u);
  }
}
