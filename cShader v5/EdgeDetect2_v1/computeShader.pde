class cShader {
  int objects, vars;
  float mult;
  String expression;
  PShader s, s1, s2, s3;
  PImage imgxa, imgxb, imgya, imgyb;
  ArrayList<PGraphics> imga = new ArrayList<PGraphics>();
  ArrayList<PGraphics> imgb = new ArrayList<PGraphics>();
  ArrayList<PGraphics> imgss = new ArrayList<PGraphics>();
  ArrayList<PGraphics> canvases = new ArrayList<PGraphics>();
  PGraphics c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15;
  int cwidth = 200;
  int cheight = 200;
  float []num;
  String[] colRef ;
  writeShader ws;
  PShader multShader,addShader,subShader,divShader;
  PShader[] compShader = new PShader[2];
  String []shdrk = {"txa","txb","tya","tyb"};
  boolean intShader;
  String ops;

  cShader(int _objects, float _mult, int obj) {
    objects = _objects;
    mult = _mult;
    vars = obj;
    init();
    //colRef = loadStrings("colRef.txt");
  };

  cShader(int _objects, int _vars) {
    objects = _objects;
    vars = _vars;
    init();
    //colRef = loadStrings("colRef.txt");
  };
  cShader(int _objects, int _vars,String _ops) {
    objects = _objects;
    vars = _vars;
    ops = checkOps(_ops);
    init();
    //colRef = loadStrings("colRef.txt");
  };
  
  cShader(int _objects, int obj,String _ops,boolean n) {
    objects = _objects;
    vars = obj;
    ops = checkOps(_ops);
    init();
    intShader = n;
    //colRef = loadStrings("colRef.txt");
  };
  
  String checkOps(String s){
    String ss = "";
    for(int i=0;i<vars;i++){
      ss+=s.charAt(i);
    }
    return ss;
  };

  void init() {
    int k = 0;
    int m = 1;
    cwidth = round(sqrt(objects))+1;
    cheight = cwidth;
    println("cwidth", cwidth, "cheight", cheight, cheight*cwidth);

    c = createGraphics(cwidth, cheight, P2D);
    c1 = createGraphics(cwidth, cheight, P2D);
    c2 = createGraphics(cwidth, cheight, P2D);
    c3 = createGraphics(cwidth, cheight, P2D);
    c4 = createGraphics(cwidth, cheight, P2D);
    c5 = createGraphics(cwidth, cheight, P2D);
    c6 = createGraphics(cwidth, cheight, P2D);
    c7 = createGraphics(cwidth, cheight, P2D);
    canvases.add(c);
    canvases.add(c1);
    canvases.add(c2);
    //img = loadImage("b1.jpg");
    imgxa = createImage(cwidth, cheight, ARGB);
    imgxb = createImage(cwidth, cheight, ARGB);
    imgya = createImage(cwidth, cheight, ARGB);
    imgyb = createImage(cwidth, cheight, ARGB);
    for ( int i=0; i<vars; i++) {
      //canvases = createGraphics(cwidth, cheight, P2D);
      PGraphics imgs = createGraphics(cwidth, cheight, P2D);
      PGraphics imgsb = createGraphics(cwidth, cheight, P2D);
      imgs.beginDraw();
      imgs.endDraw();
      imga.add(imgs);
      imgsb.beginDraw();
      imgsb.endDraw();
      if(!intShader)imgb.add(imgsb);
      imgss.add(imgs);
      if(!intShader)imgss.add(imgsb);
    }
    println("img size",imga.size());
    s = loadShader("xintcomp.glsl");
    s1 = loadShader("xfloatcomp.glsl");

    num = new float[objects];
    compShader = createShader(vars,ops);
  };

void createMultShader(){
  
};
  

void loadFloats(float [] k, float [] k1) {
  numToF(k, k1);
};

void loadobjects() {
};

void prticle() {
  
  runDV();
  //multiplication();
}

void initialiseVariables(ArrayList<PGraphics> _imga,ArrayList<PGraphics> _imgb){
  for(int i=0;i<_imga.size();i++){
    imga.set(i,_imga.get(i));
    imgb.set(i,_imgb.get(i));
  }
};

void initialiseVariables(PGraphics _imga,PGraphics _imgb,int b){
    imga.set(b,_imga);
    imgb.set(b,_imgb);
};

void initialiseVariables(ArrayList<PImage> _imga){
  
  for(int i=0;i<_imga.size();i++){
    PGraphics cc = createGraphics(cwidth,cheight,P2D);
    cc.beginDraw();
    cc.image(_imga.get(i),0,0);
    cc.endDraw();
    imga.set(i,cc);
  }
  intShader = true;
};

void runVF() {
  for(int i=0;i<vars;i++){
    String vv = "va"+i;
    String vb = "vb"+i;
    //println(vv,i,vb,imgss.size());
    compShader[0].set(vv, imga.get(i));
    compShader[0].set(vb, imgb.get(i));
    compShader[1].set(vv, imga.get(i));
    compShader[1].set(vb, imgb.get(i));
  }
  c1.beginDraw();
  c1.clear();
  c1.background(0, 0, 0, 0);
  
  c1.shader(compShader[0]);
  c1.image(imga.get(0), 0, 0);
  c1.endDraw();

  //x float component
  if(!intShader){
    c2.beginDraw();
    c2.clear();
    c2.background(0, 0, 0, 0);
    c2.shader(compShader[1]);
    c2.image(imgb.get(0), 0, 0);
    c2.endDraw();
    recombineS(c1, c2);
  }
  //recombine(c1, c2);
};

void runVrs() {
  for(int i=0;i<vars;i++){
    String vv = "va"+i;
    String vb = "vb"+i;
    println(vv,i,vb,imgss.size());
    s.set(shdrk[i], imga.get(i));
    s.set(shdrk[i+1], imgb.get(i));
    s1.set(shdrk[i], imga.get(i));
    s1.set(shdrk[i+1], imgb.get(i));
  }
  c1.beginDraw();
  c1.clear();
  c1.background(0, 0, 0, 0);
  
  c1.shader(s);
  c1.image(imga.get(0), 0, 0);
  c1.endDraw();

  //x float component
  c2.beginDraw();
  c2.clear();
  c2.background(0, 0, 0, 0);
  
  c2.shader(s1);
  c2.image(imgb.get(0), 0, 0);
  c2.endDraw();
  recombineS(c1, c2);
};

void run() {
  //x float component
  c1.beginDraw();
  c1.clear();
  c1.background(0, 0, 0, 0);
  s.set("txa", imgxa);
  s.set("txb", imgxb);
  s.set("tya", imgya);
  s.set("tyb", imgyb);
  c1.shader(s);
  c1.image(imgxa, 0, 0);
  c1.endDraw();
  //x float component
  c2.beginDraw();
  c2.clear();
  c2.background(0, 0, 0, 0);
  s1.set("txa", imgxa);
  s1.set("txb", imgxb);
  s1.set("tya", imgya);
  s1.set("tyb", imgyb);
  c2.shader(s1);
  c2.image(imgxb, 0, 0);
  c2.endDraw();

  recombine(c1, c2);
};

void runV() {
  runVrs();
  //debug();
};

void runDV() {
  runVrs();
  debugF();
};

void runDF() {
  runVF();
  debugF();
};


void addition() {
  c1.beginDraw();
  c1.clear();
  c1.background(0, 0, 0, 0);
  
  c1.shader(compShader[0]);
  c1.image(imga.get(0), 0, 0);
  c1.endDraw();
};

void substraction() {
};

PGraphics multiplication(PGraphics c,float mult) {
  if (c4==null)createGraphics(cwidth, cheight, P2D);
  
  multShader.set("mult",mult);
  //multShader.set(",mult);
  c4.beginDraw();
  c4.clear();
  c4.background(0, 0, 0, 0);
  
  c4.shader(multShader);
  c4.image(c, 0, 0);
  c4.endDraw();
  
  return c4;
};

void division() {
};

void recombine() {
  c2.loadPixels();
  c1.loadPixels();
  for (int i=0; i<max; i++) {

    num[i] = c2.pixels[i]+c1.pixels[i];
  }
};

void recombine(PImage a, PImage b) {

  for (int i=0; i<max; i++) {

    num[i] = a.pixels[i]+b.pixels[i];
  }
};

void recombineInt(PGraphics a, PGraphics b) {
  a.loadPixels();
  b.loadPixels();
  float base = 256;
  float b1 = base*base*base;
  float b2 = base*base;
  float b3 = base;
  for (int i=0; i<objects; i++) {
    float r1 = red(a.pixels[i])*b1;
    float g1 = green(a.pixels[i])*b2;
    float b4 = blue(a.pixels[i]);
    float b6 = brightness(a.pixels[i]);
    float a1 = alpha(a.pixels[i]);

    float r2 = red(b.pixels[i])*b1;
    float g2 = green(b.pixels[i])*b2;
    float b5 = blue(b.pixels[i])*b3;
    float a4 = alpha(b.pixels[i]);

    num[i] = r1+g1+b4+r2+g2+b5;
    if (frameCount%10==0&&i==0)println("col", r1, g1, b4, a1);
    if (frameCount%10==0&&i==0)println("col2", r2, g2, b5, a4);
    if (frameCount%10==0&&i==0)println("num", num[i]);
  }
};

void recombine(PGraphics a, PGraphics b) {
  a.loadPixels();
  b.loadPixels();
  float base = 256;
  float b1 = base*base;
  float b2 = base;
  for (int i=0; i<objects; i++) {
    float r1 = red(a.pixels[i])*b1;
    float g1 = green(a.pixels[i])*b2;
    float b4 = blue(a.pixels[i]);
    float b6 = brightness(a.pixels[i]);
    float a1 = alpha(a.pixels[i]);

    float r2 = red(b.pixels[i])*b1;
    float g2 = green(b.pixels[i])*b2;
    float b5 = blue(b.pixels[i]);
    float a4 = alpha(b.pixels[i]);

    float t = r2+g2+b5;
    //if((r2+g2)==0)t=t*pow(10,-3-3);
    //else if(r2==0)t=t*pow(10,-2-3);
    //else if(g2==0)t=t*pow(10,-1-3);


    if (r2==0)t=t*pow(10, -1-2);
    else if (g2==0)t=t*pow(10, -2-2);
    else t=t*pow(10, -3-2);
    //while (t>0) t=t*pow(10,-1);

    num[i] = r1+g1+b4+t;
    if (frameCount%10==0&&i==0)println("col***", num[i],r1, g1, b4, a1);
    if (frameCount%10==0&&i==0)println("col2",num[i], r2, g2, b5, a4);
    if (frameCount%10==0&&i==0)println("num", num[i], t);
  }
};

void recombineS(PGraphics a, PGraphics b) {
  a.loadPixels();
  b.loadPixels();
  for (int i=0; i<objects; i++) {
    //println("recombine",i);
     int r1 = (a.pixels[i])+16777216;

     float t = b.pixels[i]+16777216;
     float r = red(b.pixels[i]);
     float g = green(b.pixels[i]);


    if (r==0)t=t*pow(10, -1-2);
    else if (g==0)t=t*pow(10, -2-2);
    else t=t*pow(10, -3-2);
    //while (t>0) t=t*pow(10,-1);

    num[i] = r1;
    //imga.get(0).pixels[i] = float2PixelsA(r1);
    //imgb.get(0).pixels[i] = float2PixelsB(t);
    if (frameCount%10==0&&i==0)println("col********", num[i],r1);
    if (frameCount%10==0&&i==0)println("col2",num[i]+t, t,b.pixels[i]+16777216-1000,(b.pixels[i]+16777216)/10);
    if (frameCount%10==0&&i==0)println("num", num[i], t);
  }
  //imga.set(0,c1);
  //imgb.set(0,c2);
};

void redeploy() {
  for (int i=0; i<objects; i++) {
    imga.get(i).loadPixels();
    imgb.get(i).loadPixels();
    imga.get(i).pixels[i] = float2Pixelsa(num[i]);
    imgb.get(i).pixels[i] = float2Pixelsb(num[i]);
    imga.get(i).updatePixels();
    imgb.get(i).updatePixels();
  }
};

void debug() {
  if (frameCount%10==0) {

    println("print imgxa", num[0], red(imga.get(0).pixels[0]), green(imga.get(0).pixels[0]), blue(imga.get(0).pixels[0]), alpha(imga.get(0).pixels[0]), brightness(imga.get(0).pixels[0]));
    println("print imgxb", num[0], red(imgb.get(0).pixels[0]), green(imga.get(0).pixels[0]), blue(imgb.get(0).pixels[0]), alpha(imgb.get(0).pixels[0]), brightness(imgb.get(0).pixels[0]));
    println("print imgya", num[0], red(imga.get(1).pixels[0]), green(imga.get(1).pixels[0]), blue(imga.get(1).pixels[0]), alpha(imga.get(1).pixels[0]), brightness(imga.get(1).pixels[0]));
    println("print imgyb", num[0], red(imgb.get(1).pixels[0]), green(imgb.get(1).pixels[0]), blue(imgb.get(1).pixels[0]), alpha(imgb.get(1).pixels[0]), brightness(imgb.get(1).pixels[0]));
    println("print c", num[0], red(c1.pixels[0]), green(c1.pixels[0]), blue(c1.pixels[0]), alpha(c1.pixels[0]), brightness(c1.pixels[0]));
    println("print c2", num[0], red(c2.pixels[0]), green(c2.pixels[0]), blue(c2.pixels[0]), alpha(c2.pixels[0]), brightness(c2.pixels[0]));
  }
};

void debugF() {
  if (frameCount%10==0) {
    for (int i=0; i<vars; i++) {
      println("print imga "+i, num[0], red(imga.get(i).pixels[0]), green(imga.get(i).pixels[0]), blue(imga.get(i).pixels[0]), alpha(imga.get(i).pixels[0]), brightness(imga.get(i).pixels[0]));
      println("print imgb "+i, num[0], red(imgb.get(i).pixels[0]), green(imgb.get(i).pixels[0]), blue(imgb.get(i).pixels[0]), alpha(imgb.get(i).pixels[0]), brightness(imgb.get(i).pixels[0]));
    }
    println("print c", num[0], red(c1.pixels[0]), green(c1.pixels[0]), blue(c1.pixels[0]), alpha(c1.pixels[0]), brightness(c1.pixels[0]));
    println("print c2", num[0], red(c2.pixels[0]), green(c2.pixels[0]), blue(c2.pixels[0]), alpha(c2.pixels[0]), brightness(c2.pixels[0]));
  }
};

void lodRandom() {
  numToR();
}

void lodRandom2() {
  numToR2();
}

void numToInt(float [] cc, float []cc1) {
  String s = "";
  float base = 256;
  imgxa.loadPixels();
  float b1 = base*base*base;
  float b2 = base*base;
  float b3 = base;
  for (int i=0; i<imgxa.pixels.length; i++) {
    s = "";
    int a = abs((int)i);
    color col = float2Pixelsa(cc[i]);
    color col1 = float2Pixelsa(cc1[i]);
    imgxa.pixels[i] = col;
    imgya.pixels[i] = col1;
    //text[i]= " "+col;
    //println("colorp",i,"r",r, "g",g,"b", b,"a",a1);
    //if(i==100000-1)
    //println("colorp",i,r, g, b,a1);
  }
  //text = s;
  //saveStrings("conv.txt", text);
  imgxa.updatePixels();
  imgya.updatePixels();
  c1.updatePixels();
  c2.updatePixels();
};

void numToR() {
  String s = "";
  float base = 256;
  c1.loadPixels();
  c2.loadPixels();
  imgxb.loadPixels();
  imgxa.loadPixels();
  imgyb.loadPixels();
  imgya.loadPixels();
  for (int i=0; i<imgxa.pixels.length; i++) {

    float k = i+random(0, width*height)/10;

    color col = float2Pixelsa(k);
    color col1 = float2Pixelsb(k);

    //imgxa.pixels[i] = col;
    //imgxb.pixels[i] = col1;
    imgxa.pixels[i] = col;
    imgxb.pixels[i] = col1;

    float k2 = i+random(0, width*height)/10;

    color b = float2Pixelsa(k2);
    color b1 = float2Pixelsb(k2);

    //imgya.pixels[i] = b;
    //imgyb.pixels[i] = b1;
    imgya.pixels[i] = b;
    imgyb.pixels[i] = b1;
    c1.pixels[i] = color(0, 0, 0, 0);
    c2.pixels[i] = color(0, 0, 0, 0);
    if (i==0)println("x", red(col), green(col), blue(col), brightness(col), k);
    if (i==0)println("xb", red(col1), green(col1), blue(col1), brightness(col1), k);
    if (i==0)println("y", red(b), green(b), blue(b), brightness(b));
    if (i==0)println("yb", red(b1), green(b1), blue(b1), brightness(b1), k2);
  }
  println("r1", alpha(imgxa.pixels[0]), blue(imgxa.pixels[0]));
  imgxa.updatePixels();
  imgxb.updatePixels();
  imgya.updatePixels();
  imgyb.updatePixels();
  c1.updatePixels();
  c2.updatePixels();
};

void numToR2() {
  String s = "";
  float base = 256;
  c1.loadPixels();
  c2.loadPixels();

  for (int i=0; i<vars; i++) {
    imga.get(i).loadPixels();
    imgb.get(i).loadPixels();

    for (int j=0; j<imgb.get(0).pixels.length; j++) {
      float k = j+random(cwidth, width*height)/10;
      color col = float2PixelsA(k);
      color col1 = float2PixelsB(k);
      imga.get(i).pixels[j]= col;
      imgb.get(i).pixels[j]= col1;
      if (j==0) {
        println("x "+i, red(col), green(col), blue(col), brightness(col), k);
        println("xb "+i, red(col1), green(col1), blue(col1), brightness(col1), k);
        println("col ", col, col1, imga.get(i).pixels[j], imgb.get(i).pixels[j]);
      }
    }
    imga.get(i).updatePixels();
    imgb.get(i).updatePixels();
  }
};

void numToF(float [] cc, float []cc1) {
  String s = "";
  float base = 256;
  c1.loadPixels();
  c2.loadPixels();
  imgxb.loadPixels();
  imgxa.loadPixels();
  imgyb.loadPixels();
  imgya.loadPixels();
  for (int i=0; i<imgxa.pixels.length; i++) {


    color col = float2Pixelsa(cc[i]);
    color col1 = float2Pixelsb(cc[i]);

    //imgxa.pixels[i] = col;
    //imgxb.pixels[i] = col1;
    imgxa.pixels[i] = color(0);
    imgxb.pixels[i] = color(0);

    color b = float2Pixelsa(cc1[i]);
    color b1 = float2Pixelsb(cc1[i]);

    //imgya.pixels[i] = b;
    //imgyb.pixels[i] = b1;
    imgya.pixels[i] = color(0);
    ;
    imgyb.pixels[i] = color(0);
    c1.pixels[i] = color(0, 0, 0, 0);
    c2.pixels[i] = color(0, 0, 0, 0);
    //if(i<imgxa.pixels.length-10000)println("colora",c,c1);
  }
  println("r1", alpha(imgxa.pixels[0]), blue(imgxa.pixels[0]));
  imgxa.updatePixels();
  imgxb.updatePixels();
  imgya.updatePixels();
  imgyb.updatePixels();
  c1.updatePixels();
  c2.updatePixels();
};

color float2Pixelsa(float k) {
  color c = 0;

  float base = 256;
  float b1 = base*base;
  float b2 = base;

  int i1 = (int)k;

  float r = floor(i1/(b1)%base);
  float g = floor(i1/(b2)%base);
  float b = floor(i1%base);
  //float a1 = floor(i1)%base;

  color col = color(r, g, b, 255);
  //println("colora",col,r,g,b,i1);
  return col;
};

color float2Pixelsb(float k) {
  color c = 0;

  float base = 256;
  float b1 = base*base;
  float b2 = base;

  float a = abs(k - int(k))*100000;

  float r = floor(a/(b1)%base);
  float g = floor(a/(b2)%base);
  float b = floor((a)%base);
  //float a1 = floor(a)%base;

  color col = color(r, g, b, 255);
  //println("colorb",col,a,k, int(k)-k);
  return col;
};

color float2PixelsA(float k) {
  color c = 0;
  int i1 = (int)k;
  color col = color(-16777216+i1);
  //println("colora",k,col,r,g,b,i1,red(col),green(col),blue(col));
  return col;
};

color float2PixelsB(float k) {
  color c = 0;

  float a = abs(k - int(k))*100000;
  int kk = (int)a;
  color col = color(-16777216+kk);
  //println("colorb",k,kk,col,r,g,b,red(col),green(col),blue(col));
  return col;
};

PShader[] createShader(int vars,String ops){
  PShader[] shaders = new PShader[2];
  String []shaderi,shaderf;
  String ss[] = new String[0];
    saveStrings("shaderi.glsl", ss);
    saveStrings("shaderf.glsl", ss);
  ws = new writeShader(vars,ops);
  ws.create(true);
  shaderi = ws.shader;
  saveStrings("shaderi.glsl", shaderi);
  ws = new writeShader(vars,ops);
  ws.create(false);
  shaderf = ws.shader;
  //println(ws.shader);
  
  saveStrings("shaderf.glsl", shaderf);
  PShader psi = loadShader("shaderi.glsl");
  PShader psf = loadShader("shaderf.glsl");
  shaders[0] = psi;
  shaders[1] = psf;
  return shaders;
};
};
