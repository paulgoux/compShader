
cShader cs;
void setup() {
  size(400, 400, P2D);
  String op = "/*/";
  cs = new cShader(500000,3,op);
  cs.lodRandom2();
  //smooth(8);
};

int k = 0;
float con = 0;

void draw() {
  background(255);
  //cs.runDV();//with debug info
  //cs.runDF();//with debug info
  //cs.runVF();//without
  //cs.lodRandom2();//od rndom vribles
  //for(int i=0;i<cs.num.length;i+=2){
  //  point(cs.num[i],cs.num[i+1]);
  //}
  //println("frmerte",frameRate);
  strokeWeight(20);
  fill(0);
  text(frameRate, 50, 50);
};
