PGraphics c;
float[]num, x, y;
int max = 1000;
PShader s,s1,s2,s3;
PImage imgxa,imgxb,imgya,imgyb;
PGraphics c1,c2,c3,c4;
int n = 123456789;
int m;
int z = 0;
color col = color(0, 0, 0);
color cc = color(5,99,98,97);
color cc1 = color(5,99,98,97);
int[]t = new int[4];
int cmax = 255;
String []text;
String ss = "{";
String []Conv;
int []conv;
void setup() {
  size(400, 400, P2D);
  text = new String[100];
  max = width*height;
  surface.setLocation(1440/2-20, 0);
  c = createGraphics(width, height, P2D);
  c1 = createGraphics(width, height, P2D);
  c2 = createGraphics(width, height, P2D);
  c3 = createGraphics(width, height, P2D);
  //img = loadImage("b1.jpg");
  imgxa = createImage(width, height, ARGB);
  imgxb = createImage(width, height, ARGB);
  imgya = createImage(width, height, ARGB);
  imgyb = createImage(width, height, ARGB);
  x = new float[max];
  y = new float[max];
  
  //initVectors();
  //numToF();
  numToI();
  s = loadShader("fragxa.glsl");
  s.set("w", width);
  //s1 = loadShader("fragxb.glsl");
  //s2 = loadShader("fragya.glsl");
  //s3 = loadShader("fragyb.glsl");
  
  //cc1 = color(0,1,2);
  //cc = color(cc1,10);
  
  //float r = red(cc);
  //float g = green(cc);
  //float b = blue(cc);
  //float alpha = brightness(cc);
  
  //println("color",r,g,b,alpha);
  //colorMode(RGB,cmax);
};
int k = 0;
float con = 0;
void draw() {
  background(255);
  k ++;
  //if(k==1)generatePowers();
  //cc = color(0,100+k,0,-k);;
  int a1 = (int)map(mouseX,0,width,0,cmax);
  color cc = color(a1);
  fill(cc);
  strokeWeight(0);
  //rect(100,100,width,height);
  //imgxa.loadPixels();
  //imgxa.pixels[0] = cc;
  //imgxa.updatePixels();
  c.beginDraw();
  s.set("txa",imgxa);
  s.set("txb",imgxb);
  c.image(imgxa,0,0);
  c.shader(s);
  
  c.endDraw();
  
  //c1.beginDraw();
  //s3.set("txa",imgxa);
  //s3.set("txb",imgxb);
  //c1.shader(s);
  //c1.image(imgxb,0,0);
  //c.endDraw();
  
  //c2.beginDraw();
  //s3.set("tya",imgya);
  //s3.set("tyb",imgyb);
  //c2.shader(s2);
  //c2.image(c1,0,0);
  //c2.endDraw();
  
  //c3.beginDraw();
  //s3.set("tya",imgya);
  //s3.set("tyb",imgyb);
  //c3.shader(s3);
  //c3.image(c2,0,0);
  //c3.endDraw();
  //if(frameCount%5==0){
    
  //  float r = red(imgxa.pixels[0]);
  //  float g = green(imgxa.pixels[0]);
  //  float b = blue(imgxa.pixels[0]);
  //  float alpha = alpha(imgxa.pixels[0]);
  //  con = r/a1;
  //  println("color cc",r,a1,con);
  //}
  //initVectors();
  image(imgxa,0,0);
  //image(imgxb,0,0);
  fill(0);
  strokeWeight(20);
  text(frameRate, 50, 50);
};
