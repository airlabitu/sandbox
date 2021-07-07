import ddf.minim.*;

// need to import this so we can use Mixer and Mixer.Info objects
import javax.sound.sampled.*;

Minim minim;
AudioOutput out;
Mixer.Info[] mixerInfo;
AudioPlayer groove;

void setup()
{
  minim = new Minim(this);
  mixerInfo = AudioSystem.getMixerInfo();
  
  for(int i = 0; i < mixerInfo.length; i++)
  {
    println("["+i+"]", mixerInfo[i].getName());
  } 
  
  Mixer mixer = AudioSystem.getMixer(mixerInfo[2]);  
  minim.setOutputMixer(mixer);
  
  groove = minim.loadFile("groove.mp3", 2048);
  groove.loop();
  
}

void draw(){}
