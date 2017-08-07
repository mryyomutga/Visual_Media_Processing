import java.util.*;
import gab.opencv.*;
OpenCV opencv;
ArrayList<Contour> contours;
ArrayList<PVector> position1 = new ArrayList<PVector>();

PImage pic0;
PImage pic0bin;
PImage pic1;
PImage pic1bin;

void setup(){
  size(660, 500);
  
  frameRate(30);
  pic0 = loadImage("watch.jpg");
  pic0.loadPixels();
  loadPixels();
  pic1 = loadImage("doll.jpg");
  pic1.loadPixels();
  loadPixels();
  
  int p_width = pic0.width;
  int p_height = pic0.height;
  
  pic0bin = createImage(pic0.width, pic0.height, RGB);
  pic1bin = createImage(pic1.width, pic1.height, RGB);
  
  /* create images */
  for (int x = 0; x < pic0.width; x++) {
    for (int y = 0; y < pic0.height; y++ ) {
      // Calculate the 1D location from a 2D grid
      int loc = x + y*pic0.width;
      float r0,g0,b0;
      float r1,g1,b1;
      // Get the R,G,B values from image
      r0 = red(pic0.pixels[loc]);
      g0 = green(pic0.pixels[loc]);
      b0 = blue(pic0.pixels[loc]);
      
      r1 = red(pic1.pixels[loc]);
      g1 = green(pic1.pixels[loc]);
      b1 = blue(pic1.pixels[loc]);
      /* gray scale */
      float gray0 = 0.299*r0 + 0.587*g0 + 0.114*b0;
      float gray1 = 0.299*r1 + 0.587*g1 + 0.114*b1;
      
      /* Binarization */
      if(gray0 < 128){
        gray0 = 0;
      }else{
        gray0 = 255;
      }
      if(gray1 < 128){
        gray1 = 0;
      }
      else{
        gray1 = 255;
      }
      pic0bin.pixels[loc] = color(gray0);
      pic1bin.pixels[loc] = color(gray1);
    }
  }

}

void draw(){
  /* pic0 */
  image(pic0, 0, 0, pic0.width/2, pic0.height/2);
  /* pic1 */
  image(pic1, 0, pic0.height/2, pic1.width/2, pic1.height/2);
  /* pic0bin */
  image(pic0bin, pic0.width/2,10,pic0.width/2, pic0.height/2);
  /* pic1bin */
  image(pic1bin, pic1.width/2,pic1.height/2+10, pic1.width/2, pic1.height/2);
 
  opencv = new OpenCV(this, pic0bin);
  contours = opencv.findContours(); 
  pushMatrix();
  translate(pic0.width/2,10);
  scale(0.5);  
  for(Contour contour: contours){
    position1 = contour.getPoints();
    contour.draw();
    pushMatrix();
      float[] point = position1.get(0).array();
      textSize(25);
      fill(0, 255, 255);
      text("" + (int)contour.area(), point[0], point[1]);
      println("(" + point[0] +"," + point[1] + ")");
      noFill();
    popMatrix();
    println(contour.area());
  }
  popMatrix();
 
  opencv = new OpenCV(this, pic1bin);
  contours = opencv.findContours();  
  pushMatrix();
  translate(pic1.width/2,pic1.height/2+10);
  scale(0.5);
  for(Contour contour: contours){
    position1 = contour.getPoints();
    contour.draw();
    pushMatrix();
      float[] point = position1.get(0).array();
      textSize(25);
      fill(0, 255, 255);
      text((int)contour.area(), point[0], point[1]);
      println("(" + point[0] +"," + point[1] + ")");
      noFill();
    popMatrix();
    println(contour.area());
  }
  popMatrix();

  save("./data/bin.jpg");
  pic0bin.save("./data/pic0bin.jpg");
  pic1bin.save("./data/pic1bin.jpg");
}

