#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform float v[10];
uniform sampler2D texture;
uniform sampler2D txa;
uniform sampler2D txb;
uniform sampler2D tya;
uniform sampler2D tyb;
uniform float mult;
uniform float type;
uniform float thresh;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec2 resolution;
uniform float w;
uniform int [1000]s;
uniform float [10]ops;
uniform float [1000]vars;


void main(void) {
  float base = 256;
  float x = 1.0 / resolution.x;
  float y = 1.0 / resolution.y;
  
  vec4 xa = texture2D( txa, vertTexCoord.xy );
  vec4 xb = texture2D( txb, vertTexCoord.xy );
  vec4 ya = texture2D( tya, vertTexCoord.xy );
  vec4 yb = texture2D( tyb, vertTexCoord.xy );
  
  float xc = xa.r + xa.g + xa.b + xa.a; 
  float xd = xb.r + xb.g + xb.b + xb.a; 
  
  float yc = ya.r*base*base*base + ya.g*base*base + ya.b*base + ya.a; 
  float yd = (yb.r*base*base*base + yb.g*base*base + yb.b*base + yb.a)/10000000;
  
  float xx = (xc+xd)*0.001;
  float yy = (yc+yd)*0.001;
  
  float xint = floor(xc+xd);
  float xf = floor(xc+xd);
  
  float yint = floor(xc+xd);
  float yf = floor(xc+xd);
  
  float b1 = base*base*base;
  float b2 = base*base;
  
  float rxi = floor(mod (xx/b1,base));
  float gxi = floor(mod (xx/b2,base));
  float bxi = floor(mod (xx/base,base));
  float axi = floor(mod (xx,base));
  
  //float rxf = floor(xx/(b1)%base);
  //float gxf = floor(xx/(b2)%base);
  //float bxf = floor((xx/base)%base);
  //float axf = floor(xx)%base;
  
  //float rxi = floor(yy/(b1)%base);
  //float gxi = floor(yy/(b2)%base);
  //float bxi = floor((yy/base)%base);
  //float a1xi = floor(yy)%base;
  
  //float rxf = floor(yy/(b1)%base);
  //float gxf = floor(yy/(b2)%base);
  //float bxf = floor((yy/base)%base);
  //float a1xf = floor(yy)%base;
  
  //gl_FragColor = vec4(rxi,gxi,bxi,0.0);
  gl_FragColor = vec4(0.0);

};
