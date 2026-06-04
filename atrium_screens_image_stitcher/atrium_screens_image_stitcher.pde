// Processing sketch: tile a 1920x1080 image three times horizontally to 5760x1080
PImage img;
void setup() {
  // Set output size to 5760x1080 (3 * 1920 by 1080)
  size(5760, 1080);
  // Load your 1920x1080 source image from the "data" folder
  // Replace "input.jpg" with your filename (jpg/png)
  img = loadImage("input.jpg");
  // Optional: verify input dimensions (will still draw regardless)
  if (img.width != 1920 || img.height != 1080) {
    println("Warning: input image is " + img.width + "x" + img.height + ", expected 1920x1080.");
  }
  // Draw the image three times side-by-side
  image(img, 0,    0);
  image(img, 1920, 0);
  image(img, 3840, 0);
  // Save the result
  save("tiled_5760x1080.png");
  // Stop after saving
  noLoop();
}
void draw() {
  // Not used
}
