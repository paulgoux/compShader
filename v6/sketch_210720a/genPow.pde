void numToI(){
  String s = "";
  float base = 256;
  //imgxa.loadPixels();
  float b1 = base*base*base;
  float b2 = base*base;
  float b3 = base;
  for (int i=0;i<100;i++){
    //s = "";
    //int a = abs((int)i);
    //color c = floatToPixelA(i);
    color c = color(i);
    color col = color(red(c),green(c),blue(c),128);
    float r = red(col);
    float g = green(col);
    float b = blue(col);
    //float a = brightness(c);
    //float r = floor(a/(b1)%base);
    //float g = floor(a/(b2)%base);
    //float b = floor((a/base)%base);
    //float a1 = ((a)%base);
    
    //color col = color(r, g, b,a1);
    //imgxa.pixels[i] = col;
    text[i]= ""+col+","+i;
    println("colorp",i,"r",r, "g",g,"b", b,col);
    //if(i==100000-1)
    //println("colorp",i,r, g, b,a1);
  }
  //text = s;
  saveStrings("conv.txt", text);
  //imgxa.updatePixels();
};

void numToF(){
  String s = "";
  float base = 256;
  imgxa.loadPixels();
  imgxb.loadPixels();
  
  for (int i=0;i<imgxa.pixels.length;i++){
    
    float k = i+random(0,width*height)/10;
    
    color c = float2Pixelsa(k);
    color c1 = float2Pixelsb(k);
      
    imgxa.pixels[i] = c;
    imgxb.pixels[i] = c1;
    
    color b = float2Pixelsa(k);
    color b1 = float2Pixelsb(k);
    
    imgya.pixels[i] = b;
    imgyb.pixels[i] = b1;
    //if(i<imgxa.pixels.length-10000)println("colora",c,c1);
  }
  
  imgxa.updatePixels();
  imgxb.updatePixels();
};
