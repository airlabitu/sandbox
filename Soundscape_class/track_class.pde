class Track{
  
  float vol;
  float volMin, volMax;
  float targetVol;
  float speed;
  boolean isPlaying;
  
  String name;
  int number;
  
  
  Track(String name_, int number_){
    //state = 3;
    speed=1.3098;
    isPlaying = false;
    vol = 0.0;
    targetVol = vol;
    volMin = 0.0;
    volMax = 100.0;
    name = name_;
    number = number_;
  }
  
  void setVolMinMax(int _min, int _max){
    volMin = _min;
    volMax = _max;
  }
  
  void start(){
    targetVol = volMax;
    println(name, "starting");
    isPlaying = true;
  }
  
  void stop(){
    targetVol = volMin;
    println(name, "stopping");
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
    //
  }
  
}
