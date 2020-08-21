class Track{
  
  
  float vol;
  int state; // 0: fade-in, 1: playing, 2: fade-out, 3: stopped
  String name;
  int number;
  MidiBus midi;
  
  
  Track(String name_, int number_, MidiBus midi_){
    state = 3;
    vol = 0.0;
    name = name_;
    number = number_;
    midi = midi_;
  }
  
  boolean start(){
    if (state == 0 || state == 1) return false;
    state = 0;
    println(name, "started");
    //vol = 0.0;
    return true;
  }
  
  boolean stop(){
    if (state == 2 || state == 3) return false;
    state = 2;
    //vol = 0.0;
    return true;
  }
  
  void update(){
  
    switch (state){
    
      case 0: // fade in
        if (vol < 100) vol+=1.0;
        else state = 1;
        break;
      
      case 1: // playing
        //
        break;
      
      case 2: // fade out
        if (vol > 0) vol -= 1.0;
        else state = 3;
        break;
        
      case 3: // stopped
        //
        break;
      
    }
    //println(name, " | ", state, " | ", vol);
    midi.sendControllerChange(0, number, int(vol));
  }
  
}
