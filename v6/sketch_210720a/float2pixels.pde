
color float2Pixelsa(float k){
  color c = 0;
  
  float base = 256;
  float b1 = base*base*base;
  float b2 = base*base;
  float b3 = base;
  
  int i1 = (int)k;
  
  float r = floor(i1/(b1)%base);
  float g = floor(i1/(b2)%base);
  float b = floor((i1/base)%base);
  float a1 = floor(i1)%base;
  
  color col = color(r, g, b, a1);
  //println("colora",col,r,g,b,a1,i1);
  return col;
};

color float2Pixelsb(float k){
  color c = 0;
  
  float base = 256;
  float b1 = base*base*base;
  float b2 = base*base;
  float b3 = base;
  
  float a = abs(k - int(k))*10000000;
  
  float r = floor(a/(b1)%base);
  float g = floor(a/(b2)%base);
  float b = floor((a/base)%base);
  float a1 = floor(a)%base;
  
  color col = color(r, g, b, a1);
  //println("colorb",col,a,k, int(k)-k);
  return col;
};
