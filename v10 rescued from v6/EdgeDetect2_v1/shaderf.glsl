#ifdef GL_ES
precision highp float;
precision highp int;
#endif
#define PROCESSING_TEXTURE_SHADER
uniform float v[10];
uniform sampler2D texture;
uniform sampler2D va0;
uniform sampler2D vb0;
uniform sampler2D va1;
uniform sampler2D vb1;
uniform float mult = 1.0;
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
float x = 1.0 / resolution.x;
float y = 1.0 / resolution.y;
vec2 tx = vertTexCoord.st;
vec4 via0 = texture2D(va0 , vertTexCoord.st);
vec4 vib0 = texture2D(vb0 , vertTexCoord.st);
vec4 via1 = texture2D(va1 , vertTexCoord.st);
vec4 vib1 = texture2D(vb1 , vertTexCoord.st);
float base = 256;
float b1 = base*base*255;
float b2 = base*255;
float b3 = 255;
float tva0 = (via0.r*b1 + via0.g*b2 + via0.b*b3);
float tva1 = (via1.r*b1 + via1.g*b2 + via1.b*b3);
float tvb0 = (vib0.r*b1 + vib0.g*b2 + vib0.b*b3 )/100000;
float tvb1 = (vib1.r*b1 + vib1.g*b2 + vib1.b*b3 )/100000;
float tvf0 = (tvb0+tva0);
float tvf1 = (tvb1+tva1);
float num = ((tvf0)/(tvf1))*1.0;
float numf = abs(num - floor(num))*10000 ;
float rni = floor(mod (numf/(base*base), base))/255;
 rni = 0.0;
if(num<0.0)rni = 1.0;
float gni = floor(mod ((numf/base), base))/255;
float bni = floor(mod (numf, base))/255;
gl_FragColor = vec4(rni, gni, bni, 1.0);
}
