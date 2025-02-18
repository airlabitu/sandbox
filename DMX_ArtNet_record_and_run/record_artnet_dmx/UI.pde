boolean recording = false;

void startScreen(){
  background(0);
  stroke(200, 0, 0);
  noFill();
  ellipse(100, 100, 100, 100);
  textSize(18);
  fill(255);
  textAlign(CENTER);
  text("start\nrecording", 100, 90);
  fill(255);
  String settings_text = 
    "Framerate: " + framerate + "\n"
    +"ArtNet input IP: " + ip_address + "\n"
    +"Frames to record: " + frames_to_record + "\n"
    +"DMX universes:\n[";
    for (int i = 0; i < dmx_universes.length; i++) settings_text += " " + dmx_universes[i];
    settings_text += " ]";
  textAlign(LEFT);
  text(settings_text, 180, 60);
  textSize(18);
  fill(100);
  text("change settings from 'record_settings.xml'", 40, 185);
}

void mouseReleased(){
  if (!recording && dist(mouseX, mouseY, 100, 100) < 50){
    fill(200, 0, 0);
    ellipse(100, 100, 100, 100);
    textSize(20);
    fill(0);
    textAlign(CENTER);
    text("recording", 100, 105);
    recording = true;
  }
}
