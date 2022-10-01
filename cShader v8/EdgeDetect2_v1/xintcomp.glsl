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

//out vec4 gl_FragData[2];

void main(void) {
  float base = 256;
  float x = 1.0 / resolution.x;
  float y = 1.0 / resolution.y;
  vec2 tx = vertTexCoord.st;
  
  vec4 xa = texture2D(txa, vertTexCoord.st);
  vec4 xb = texture2D( txb, tx );
  vec4 ya = texture2D( tya, vertTexCoord.xy );
  vec4 yb = texture2D( tyb, vertTexCoord.xy );
  
  float b1 = base*base*255;
  float b2 = base*255;
  float b3 = 255;
  
  float yc = (ya.r*b1 + ya.g*b2 + ya.b*b3); 
  float yd = (yb.r*b1 + yb.g*b2 + yb.b*b3)/10000000; 
  
  float yy = (yc+yd);
  float yyi = floor(yy);
  
  float xc = (xa.r*b1 + xa.g*b2 + xa.b*b3); 
  float xd = (xb.r*b1 + xb.g*b2 + xb.b*b3)/10000000; 
  
  float num = (xc+xd+yy);
  float numi = floor(num);
  
  float rni = floor(mod (numi/(base*base),base))/255;
  float gni = floor(mod ((numi/base),base))/255;
  float bni = floor(mod (numi,base))/255;
  //float axi = floor(mod (xx,base));
  
  //gl_FragColor = vec4(xa.r,xa.g,xa.b,1.0);
  //gl_FragColor = vec4(xa.r,xa.g,xa.b,1.0);
  gl_FragColor = vec4(rni,gni,bni,1.0);
  //gl_FragColor = vec4(0.0,0.0,0.0,0.0);

};
