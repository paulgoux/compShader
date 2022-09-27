#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform float v[10];
uniform sampler2D texture;
void main(void) {
  gl_FragColor = vec4(0.0);

};
