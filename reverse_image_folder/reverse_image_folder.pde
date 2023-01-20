PImage [] input = new PImage[90];

for (int i = 0; i <= 89; i++){
  println("loading", i+"_pic.png");
  input[i] = loadImage(i+"_pic.png");
}

println();

for (int i = 0; i <= 89; i++){
  println("saving", i+"_pic.png", "as", 89-i+"_pic.png");
  input[i].save(89-i+"_pic.png");//= loadImage(i+"_pic.png");
}
