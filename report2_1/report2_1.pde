PImage pic0;
PImage pic0diff;
PImage pic1;

void setup(){
  size(660, 500);
  frameRate(30);
  pic0 = loadImage("watch.jpg");
  pic0.loadPixels();
  pic1 = loadImage("doll.jpg");
  pic1.loadPixels();
  loadPixels();
  
  pic0diff = createImage(pic0.width, pic0.height, RGB);

  outputDifference();
}

void outputDifference(){
  float[] diff = new float[3];
  for (int x = 0; x < pic0.width; x++) {
    for (int y = 0; y < pic0.height; y++ ) {
      // Calculate the 1D location from a 2D grid
      int loc = x + y*pic0.width;
      // Get the R,G,B values from image    
      diff[0] = abs(red(pic0.pixels[loc]) - red(pic1.pixels[loc]));
      diff[1] = abs(green(pic0.pixels[loc]) - green(pic1.pixels[loc]));
      diff[2] = abs(blue(pic0.pixels[loc]) - blue(pic1.pixels[loc]));     
      pic0diff.pixels[loc] = color(diff[0], diff[1], diff[2]);
      //pic1.pixels[loc] = color(cr+cg+cb);
    }
  } 
}

void draw(){
  /* pic0 */
  image(pic0, 0, 0, pic0.width/2, pic0.height/2);
  /* pic1 */
  image(pic1, 0, pic0.height/2, pic1.width/2, pic1.height/2);
  /* pic0diff */
  //image(pic0diff, pic0.width/4, pic0.height/2, pic0diff.width/2, pic0diff.height/2);
  save("./data/report2_1.jpg");
  //pic0diff.save("./data/pic0diff.jpg");
}
