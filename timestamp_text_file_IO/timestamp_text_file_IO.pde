import java.time.LocalDateTime; // import the LocalDateTime class

LocalDateTime lastTimeStamp;
LocalDateTime currentTimeStamp;
String [] timeStampToSave = new String[1]; // create output array for current time 

void setup(){
  //String [] test = {LocalDateTime.now().toString()};
  //saveStrings("timestamp.txt", test);
  String [] temp = loadStrings("timestamp.txt");
  lastTimeStamp = LocalDateTime.parse(temp[0]);
  println("time loaded", lastTimeStamp);
  if (lastTimeStamp.plusSeconds(10).isBefore(LocalDateTime.now())){
    println("turn ON screens screens");
    delay(10000);
    currentTimeStamp = LocalDateTime.now(); // update current time
    saveTimeToFile(currentTimeStamp); // save current time to file
    lastTimeStamp = currentTimeStamp; // update lastTime
    println("time saved after screen power ON", LocalDateTime.now());
  }
  else {
    println("not time to power ON screens");
  }
}

void draw(){
  if (lastTimeStamp.plusSeconds(5).isBefore(LocalDateTime.now())){
    currentTimeStamp = LocalDateTime.now(); // update current time
    println("it's time to save", currentTimeStamp);
    saveTimeToFile(currentTimeStamp); // save the current time to file
    lastTimeStamp = currentTimeStamp; // update lastTime
  }
}

void saveTimeToFile(LocalDateTime timeStamp_){  
    timeStampToSave[0] = timeStamp_.toString(); // Save timestamp into string array
    saveStrings("timestamp.txt", timeStampToSave); // save tiemstamp to file
}
