class writeShader {
  String shader[];
  ArrayList<String[]> ss = new ArrayList<String[]>();
  ArrayList<String> ssf = new ArrayList<String>();
  int count = 0;
  int vars;
  String ops;

  writeShader(int obj,String _ops) {
    vars = obj;
    ops = _ops;
  };

  void create(boolean k) {
    reset();
    String[] shdermm = new String[]{
      "#ifdef GL_ES", 
      "precision mediump float;", 
      "precision mediump int;", 
      "#endif", 

      "#define PROCESSING_TEXTURE_SHADER", 

      "uniform float v[10];", 
      "uniform sampler2D texture;"
    };
    ss.add(shdermm);
    count+= shdermm.length;
    String[] shdervrs = svrs();


    ss.add(shdervrs);
    count+= shdervrs.length;
    String[] shderuniforms = new String[]{
      "uniform float mult = 1.0;", 
      "uniform float type;", 
      "uniform float thresh;", 
      "uniform vec2 texOffset;", 

      "varying vec4 vertColor;", 
      "varying vec4 vertTexCoord;", 

      "uniform vec2 resolution;", 
      "uniform float w;", 
      "uniform int [1000]s;", 
      "uniform float [10]ops;", 
      "uniform float [1000]vars;"
    };
    ss.add(shderuniforms);
    count+= shderuniforms.length;

    String[] shderRes = new String[]{
      "void main(void) {", 
      
      "float x = 1.0 / resolution.x;", 
      "float y = 1.0 / resolution.y;", 
      "vec2 tx = vertTexCoord.st;"
    };

    ss.add(shderRes);
    count+= shderRes.length;
    String[] shderCoord = scoord();

    ss.add(shderCoord);
    count+= shdermm.length;
    String[] shderBse = new String[]{
      "float base = 256;", 
      "float b1 = base*base*255;", 
      "float b2 = base*255;", 
      "float b3 = 255;"
    };

    ss.add(shderBse);
    count+= shderBse.length;
    String[] shderClc = sclc(k);

    ss.add(shderClc);
    count+= shderClc.length;

    String[] shderClc2 = null;
    if(vars>1)shderClc2 = sclc2(k);
    else shderClc2 = sclc3(1.0);
    

    ss.add(shderClc2);
    count += shderClc2.length;
    String [] sk = null;
    if(!k){
      sk = new String[2];
      sk[0] = "float numf = abs(num - floor(num))*1000000 ;";
      //ddition
      //sk[1] = " if(numf/1000.0>1.0)numf = (numf/10.0) ;";
      //sk[1] = "numf = numf/10.0;";
      //sk[1] = "while(numf>1000)numf = numf-1000.0;";
      sk[1] = " numf = numf;";
    }
    else  {
      sk = new String[1];
      sk[0] = "float numf = (num);";
    }
    println(sk[0]);
    ss.add(sk);
    count += sk.length;
    String[] shderWrite = new String[]{

      "float rni = floor(mod (numf/(base*base), base))/255;", 
      "float gni = floor(mod ((numf/base), base))/255;", 
      "float bni = floor(mod (numf, base))/255;", 

      //"gl_FragColor = vec4(0.0, 0.0, 0.5, 1.0);", 
      "gl_FragColor = vec4(rni, gni, bni, 1.0);", 
      "}"
    };

    ss.add(shderWrite);
    count += shderWrite.length;
    int c = 0;
    
    for (int i=0; i<ss.size(); i++) {
      for (int j=0; j<ss.get(i).length; j++) {
        if(ss.get(i)[j]!=null)ssf.add(ss.get(i)[j]);
        //finlString[c] = ss.get(i)[j];
        c++;
        //println("line", ss.get(i)[j]);
      }
    }
    String []finlString = new String[ssf.size()];
    for (int i=0; i<ssf.size(); i++) {
      //println("line",i, ssf.size(),ssf.get(i));
        finlString[i] = ssf.get(i);
        //println("line", ssf.size()ss.get(i)[j]);
    }
    
    
    shader = finlString;
  };

  String[] svrs () {
    String [] ss = new String [vars*2];
    int count = 0;
    for (int i=0; i<ss.length-1; i+=2) {
      ss[i] = "uniform sampler2D "+ "va"+count+";";
      //println("ddto file",ss[i]);
      count++;
    }
    count = 0;
    for (int i=1; i<ss.length; i+=2) {
      ss[i] = "uniform sampler2D "+ "vb"+count+";";
      //println("ddto file",ss[i]);
      count++;
    }

    return ss;
  };

  String[] scoord () {
    String [] ss = new String [vars*2];
    int count = 0;
    for (int i=0; i<ss.length-1; i+=2) {
      ss[i] = "vec4 via"+count+" = texture2D(va"+count+" , vertTexCoord.st);";
      count++;
    }
    count = 0;
    for (int i=1; i<ss.length; i+=2) {
      ss[i] = "vec4 vib"+count+" = texture2D(vb"+count+" , vertTexCoord.st);";
      count++;
    }

    return ss;
  };

  String[] sclc (boolean k) {
    String [] ss = new String [vars*2];
    int count = 0;
      for (int i=0; i<ss.length-1; i+=2) {
        ss[i] = "float tva"+count+" = (via"+count+".r*b1 + via"+count+".g*b2 + via"+count+".b*b3);";
        count ++;
      }
      count = 0;
      if(k)
      for (int i=1; i<ss.length; i+=2) {
        ss[i] = "float tvb"+count+" = (vib"+count+".r*b1 + vib"+count+".g*b2 + vib"+count+".b*b3 )/100000;";
        count ++;
      }
      else
      for (int i=1; i<ss.length; i+=2) {
        ss[i] = "float tvb"+count+" = (vib"+count+".r*b1 + vib"+count+".g*b2 + vib"+count+".b*b3 )/1000000;";
        count ++;
      }
    return ss;
  };

  String[] sclc2 (boolean k) {
    String [] s = new String [1];

    int count = 0;
    String  ss = "float num = (";
    if(k){
    //ss+=0.7;
    //int component
    for(int i=0;i<vars;i++){
      //ss+= "tva"+i;
      //ss += "(tvb"+i+"+tva"+i+")" ;
      //if(i<vars-1)ss+=ops.charAt(i);
      //if (i<vars-1)ss += "tva"+i+ops.charAt(i) ;
      //    else ss += "tva"+i ;
      if (i<vars-1)ss += "(tvb"+i+"+tva"+i+")"+ops.charAt(i) ;
          else ss += "(tvb"+i+"+tva"+i+")" ;
    }
    ss+=")*1.0";
    }else {
    //flot component
    //ss+=0.5;
      //ss+="(";
      for (int j=0; j<vars; j++ ) {
          if (j<vars-1)ss += "tvb"+j+ops.charAt(j) ;
          else ss += "tvb"+j ;
          //if (j<vars-1)ss += "(tvb"+j+"+tva"+j+")"+ops.charAt(j) ;
          //else ss += "(tvb"+j+"+tva"+j+")" ;
          //count ++;
      }
      ss += ")*1.0";
    }
    ss += ";";
    s[0] = ss;
    return s;
  };
  
  String[] sclc3 (float k) {
    String [] s = new String [1];
    String ss = "";
    println("ops",ops.length());
    ss += "float num = (tva0 "+ops.charAt(0)+" tvb0) *mult;";
    ss += ";";
    s[0] = ss;
    return s;
  };
  
  void reset(){
    String shader[];
    ArrayList<String[]> ss = new ArrayList<String[]>();
    ArrayList<String> ssf = new ArrayList<String>();
    int count = 0;
    int vars;
  };
};
