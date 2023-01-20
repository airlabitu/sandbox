import java.io.FilenameFilter;

String[] filenames;
String fullPath; // use forward slashes
boolean folderSelected = false;
boolean imagesLoaded = false;
PImage [] images;
 
void setup() {
  size(1024, 1024);
  selectFolder("Select a folder to process:", "folderSelected");
}

void draw(){
  if (folderSelected){
    println(fullPath);
    filenames = loadFilenames(fullPath);
    filenames = sort(filenames);
    println(filenames);
    folderSelected = false;
    images = new PImage [filenames.length];
    for (int i = 0; i < images.length; i++){
      images[i] = loadImage(fullPath+"/"+filenames[i]);
    }
    imagesLoaded = true;
  }
  if (imagesLoaded) image(images[frameCount%images.length], 0,0, width, height);
}
 
String[] loadFilenames(String path) {
  File folder = new File(path);
  FilenameFilter filenameFilter = new FilenameFilter() {
    public boolean accept(File dir, String name) {
      return name.toLowerCase().endsWith(".png"); // change this to any extension you want
    }
  };
  return folder.list(filenameFilter);
}

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    fullPath = selection.getAbsolutePath();
    folderSelected = true;
  }
}
