import processing.video.*;
import boofcv.processing.*;
import java.util.*;

Capture cam;
SimpleFiducial detector;

void setup() {
  initializeCamera(640, 480);
  surface.setSize(cam.width, cam.height);
  detector = Boof.fiducialSquareBinaryRobust(0.1);
  detector.guessCrappyIntrinsic(cam.width,cam.height);
}

void draw() {
  if (cam.available() == true) {
    cam.read();

    List<FiducialFound> found = detector.detect(cam);

    image(cam, 0, 0);

    for( FiducialFound fiducial : found ) {
      
     
      float angle;
      int x, y;
      int id;
      
      // get ID
      id = (int)fiducial.getId();
      
      // getting fiducials center coordinate
      x = (int)fiducial.getImageLocation().getX();
      y = (int)fiducial.getImageLocation().getY();
      
      // calculating angle
      if (fiducial.getFiducialToCamera().getR().getData()[1] < 0){
        angle = map((float)fiducial.getFiducialToCamera().getR().getData()[0], 1, -1, 0, 180);
      }
      else {
        angle = map((float)fiducial.getFiducialToCamera().getR().getData()[0], -1, 1, 180, 360);
      }
      
      // visualize
      fill(255, 0, 255);
      textSize(20);
      ellipse(x, y, 10, 10);
      text("angle: " + (int)angle +"\nid: " + id, x+40, y);
    }
  }
}

void initializeCamera( int desiredWidth, int desiredHeight ) {
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    cam = new Capture(this, desiredWidth, desiredHeight);
    cam.start();
  }
}
