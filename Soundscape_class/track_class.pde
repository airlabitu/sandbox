class Track{
  
  
  float vol;
  float volMin, volMax;
  float targetVol;
  float speed;
  boolean isPlaying;
  
  //int state; // 0: fade-in, 1: playing, 2: fade-out, 3: stopped
  String name;
  int number;
  MidiBus midi;
  
  
  Track(String name_, int number_, MidiBus midi_){
    //state = 3;
    speed=1.3098;
    isPlaying = false;
    vol = 0.0;
    targetVol = vol;
    volMin = 0.0;
    volMax = 100.0;
    name = name_;
    number = number_;
    midi = midi_;
  }
  
  void setVolMinMax(int _min, int _max){
    volMin = _min;
    volMax = _max;
  }
  
  void start(){
    targetVol = volMax;
    //if (state == 0 || state == 1) return false;
    //state = 0;
    println(name, "starting");
    //vol = 0.0;
    //return true;
    isPlaying = true;
  }
  
  void stop(){
    targetVol = volMin;
    //if (state == 2 || state == 3) return false;
    //state = 2;
    //vol = 0.0;
    //return true;
    println(number, "stopping");
  }
  
  void update(){
  
    
    
    if (targetVol > vol) {
      vol+=speed;
      if (targetVol < vol) vol = targetVol; // correct if overshoot
      
    }
    else if (targetVol < vol) {
      vol-=speed;
      if (targetVol > vol) vol = targetVol; // correct if overshoot
      if (vol == targetVol) isPlaying = false;
    }
    
    // correct if outside boundrys
    if (vol < volMin) vol = volMin;
    if (vol > volMax) vol = volMax;
    
    //if(isPlaying) println(targetVol, vol, volMin, volMax, isPlaying);
    
    /*
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
    */
    //println(name, " | ", state, " | ", vol);
    //midi.sendControllerChange(0, number, int(vol));
  }
  
}
