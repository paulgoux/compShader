PGraphics c;
float[]num, x, y;
int max = 1000;
PShader s,s1,s2,s3;
PImage imgxa,imgxb,imgya,imgyb;
PGraphics c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
int n = 123456789;
int m;
int z = 0;
int cwidth = 400;
int cheight = 200;
color col = color(0, 0, 0);
color cc = color(5,99,98,97);
color cc1 = color(5,99,98,97);
int[]t = new int[4];
int cmax = 255;
String []text;
String ss = "{";
String []Conv;
int []conv;
cShader cs;


void setup() {
  size(400, 400, P2D);
  text = new String[10000000];
  max = cwidth*cheight;
  surface.setLocation(1440/2-20, 0);
  x = new float[max];
  y = new float[max];
  num = new float[max];
  //initVectors();
  //numToF();
  String op = "*-";
  cs = new cShader(50000,2,op);
  
  //cs.createshader(1,
  //String[]text = new String[10000000];
  
  //println(text);
  cs.lodRandom2();
  //smooth(8);
};

int k = 0;
float con = 0;

void draw() {
  background(255);
  //cs.runDV();//with debug info
  //cs.runDF();//with debug info
  cs.runVF();//without
  //cs.lodRandom2();//od rndom vribles
  //for(int i=0;i<cs.num.length;i+=2){
  //  point(cs.num[i],cs.num[i+1]);
  //}
  //println("frmerte",frameRate);
  strokeWeight(20);
  fill(0);
  text(frameRate, 50, 50);
};
