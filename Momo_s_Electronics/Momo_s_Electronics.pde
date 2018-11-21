ArrayList<Wire> wires = new ArrayList<Wire>(); 
ArrayList<LED> leds = new ArrayList<LED>(); 
ArrayList<Switch> swts = new ArrayList<Switch>(); 

tb tools;

boolean click=false;

boolean press=false;

float cs=30;

float tx;
float ty;

float txx;
float tyy;

boolean first=true;

boolean dl=false;

boolean dm=true; //dark mode

int gid=0;

void setup() {
  //size(2400,1600);
  fullScreen();
  //frameRate(10);
  strokeWeight(cs/8);  
  
  int mi = 8; //max i
  
  tools = new tb(50,height/2-200,50,8);
  //ca(mi);
}

void draw() {  
  if(dm) {
    background(0);  
  }
  else {
    background(255);  
  }
  strokeWeight(cs/8);
  for(Wire wire : wires) {
    wire.d();
    wire.u();
  }
  
  for(LED led : leds) {
    led.d();
    led.u();
  }
  
  tools.d();
  
  if(keyPressed) {
    if(key==' ') {
      if(!press) {
        press=true;
        for(Wire wire : wires) {
          if(pow(mouseX-wire.x1,2)+pow(mouseY-wire.y1,2)<pow(wire.s,2)) {
            wire.on=!wire.on;
          }
          if(pow(mouseX-wire.x2,2)+pow(mouseY-wire.y2,2)<pow(wire.s,2)) {
            wire.on=!wire.on;
          }
        } 
      }
    }
  }
  else {
    press=false;  
  }
    
  if(dl) {
    stroke(255,0,0);
    line(tx,ty,mouseX,mouseY);  
  }
  if(mousePressed) {
    if(mouseX<tools.x+tools.s && mouseX>tools.x && mouseY<tools.y+(tools.s+cs/8)*tools.n && mouseY>tools.y) {
      tools.sel=round((mouseY-tools.y-tools.s/2)/(tools.s+cs/8));  
    }
    else {
      if(!click) {
        click=true;
        dl=true;
        if(mouseButton==LEFT) {
          if(first) {
            first=false;
            
            float xx=mouseX;
            float yy=mouseY;
            
            for(Wire wire : wires) {
              if(pow(mouseX-wire.x1,2)+pow(mouseY-wire.y1,2)<pow(wire.s,2)) {
                xx=wire.x1;
                yy=wire.y1;
              }
              if(pow(mouseX-wire.x2,2)+pow(mouseY-wire.y2,2)<pow(wire.s,2)) {
                xx=wire.x2;
                yy=wire.y2;
              }
            }
            
            if(tools.sel==4) { 
              and(xx,yy);  
              first=true;
              dl=false;
            }
            else if(tools.sel==5) {
              xor(xx,yy);
              first=true;
              dl=false;
            }
            else if(tools.sel==6) {
              fa(xx,yy);
              first=true;
              dl=false;
            }
            else if(tools.sel==7) {
              fs(xx,yy);
              first=true;
              dl=false;
            }
            else {
              tx=mouseX;
              ty=mouseY;
              for(Wire wire : wires) {
                if(pow(mouseX-wire.x1,2)+pow(mouseY-wire.y1,2)<pow(wire.s,2)) {
                  tx=wire.x1;
                  ty=wire.y1;
                }
                else if(pow(mouseX-wire.x2,2)+pow(mouseY-wire.y2,2)<pow(wire.s,2)) {
                  tx=wire.x2;
                  ty=wire.y2;  
                }
              }
              if(tools.sel==2) {
                leds.add(new LED(tx,ty,cs*1.5));
              }
            }
          }
          else {
            txx=mouseX;
            tyy=mouseY;
              for(Wire wire : wires) {
                if(pow(mouseX-wire.x1,2)+pow(mouseY-wire.y1,2)<pow(wire.s,2)) {
                  txx=wire.x1;
                  tyy=wire.y1;
                }
                else if(pow(mouseX-wire.x2,2)+pow(mouseY-wire.y2,2)<pow(wire.s,2)) {
                  txx=wire.x2;
                  tyy=wire.y2;  
                }
              }
            if(dl) {
              if(tools.sel==1) {
                wires.add(new Wire(tx,ty,txx,tyy,cs,true,gid));
                gid++;
              }
              else {
                wires.add(new Wire(tx,ty,txx,tyy,cs,false,gid));
                gid++;
              }
              if(tools.sel==2) {
                leds.add(new LED(txx,tyy,cs*1.5));
              }
            }
            tx=txx;
            ty=tyy;
          }          
        }
        else if(mouseButton==RIGHT) {
          first=true;
          dl=false;
        }
      }
    }
  }
  else {
    click=false;  
  }
}

class Wire {
  float x1;
  float y1;
  float x2;
  float y2;
  float s;
  boolean i;
  boolean on=false;
  int id;
  Wire(float x, float y, float xx, float yy, float size, boolean in, int idd) {
    x1=x;
    y1=y;
    x2=xx;
    y2=yy;
    s=size;
    i=in;
    id=idd;
  }
  
  void d() {
    fill(100);
    if(on) {
      stroke(0,255,0);  
      if(i) {
        stroke(0,100,0);  
        if(dm) {
          stroke(0,180,0);  
          fill(0,180,0);  
        }
      }
      else if(dm) {
        fill(0,255,0);  
      }
    }
    else {
      stroke(0);  
      if(i) {
        stroke(0,0,180);
        if(dm) {
          stroke(0,0,240);    
          fill(0,0,240);    
        }
      }
      else if(dm) {
        stroke(100);    
        fill(0);    
      }
    }
    line(x1,y1,x2,y2);
    ellipse(x1,y1,s,s);
    ellipse(x2,y2,s,s);
  }
  
  void u() {
    boolean ton;
    
    if(i) {
      ton = true;
      for(Wire wire : wires) {
        if(!(id==wire.id)) {  
          if(x1==wire.x1 && y1==wire.y1) {
            if(wire.on==true) {
              //ton=false;  
            }
          }
          if(x1==wire.x2 && y1==wire.y2) {
            if(wire.on==true) {
              ton=false;  
            }
          }
        }
      }
    }
    
    else {
      ton=false;
      for(Wire wire : wires) {
        if(!(id==wire.id)) {
          if(x1==wire.x1 && y1==wire.y1 && wire.on) {
            //ton=wire.on; 
          }
          if(x1==wire.x2 && y1==wire.y2 && wire.on) {
            ton=wire.on;  
          }
        }
      }
    }
    on=ton;
  }
}

void xor(float xx, float yy) {
  wires.add(new Wire(xx,yy,xx,yy-cs*1.5,cs,false,gid));
  gid++;
  wires.add(new Wire(xx+cs*1.2,yy,xx+cs*1.2,yy-cs*1.5,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx,yy-cs*1.5,xx-cs*3,yy,cs,false,gid));
  gid++;
  wires.add(new Wire(xx+cs*1.2,yy-cs*1.5,xx-cs*3,yy,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx,yy-cs*1.5,xx,yy-cs*3,cs,true,gid));
  gid++;
  wires.add(new Wire(xx+cs*1.2,yy-cs*1.5,xx+cs*1.2,yy-cs*3,cs,true,gid));
  gid++;
  
  wires.add(new Wire(xx,yy-cs*3,xx+cs*0.6,yy-cs*4.5,cs,false,gid));
  gid++;
  wires.add(new Wire(xx+cs*1.2,yy-cs*3,xx+cs*0.6,yy-cs*4.5,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*0.6,yy-cs*4.5,xx-cs*1.5,yy,cs,false,gid));
  gid++;
  wires.add(new Wire(xx+cs*0.6,yy-cs*4.5,xx+cs*1.8,yy-cs*4.5,cs,true,gid));
  gid++;
  wires.add(new Wire(xx+cs*1.8,yy-cs*4.5,xx+cs*3,yy-cs*4.5,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx-cs*1.5,yy,xx-cs*1.5,yy-cs*1.5,cs,true,gid));
  gid++;
  wires.add(new Wire(xx-cs*3,yy,xx-cs*3,yy-cs*1.5,cs,true,gid));
  gid++;
  
  wires.add(new Wire(xx-cs*1.5,yy-cs*1.5,xx-cs*2.25,yy-cs*3,cs,false,gid));
  gid++;
  wires.add(new Wire(xx-cs*3,yy-cs*1.5,xx-cs*2.25,yy-cs*3,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx-cs*2.25,yy-cs*3,xx-cs*2.25,yy-cs*4.5,cs,true,gid));
  gid++;
  wires.add(new Wire(xx-cs*2.25,yy-cs*4.5,xx-cs*2.25,yy-cs*6,cs,false,gid));
  gid++;  
}

void and(float xx, float yy) {
  wires.add(new Wire(xx,yy,xx,yy-cs*1.5,cs,false,gid));
  gid++;
  wires.add(new Wire(xx+cs*1.2,yy,xx+cs*1.2,yy-cs*1.5,cs,false,gid));
  gid++;  
  
  wires.add(new Wire(xx,yy-cs*1.5,xx,yy-cs*3,cs,true,gid));
  gid++;
  wires.add(new Wire(xx+cs*1.2,yy-cs*1.5,xx+cs*1.2,yy-cs*3,cs,true,gid));
  gid++;
  
  wires.add(new Wire(xx,yy-cs*3,xx+cs*0.6,yy-cs*4.5,cs,false,gid));
  gid++;
  wires.add(new Wire(xx+cs*1.2,yy-cs*3,xx+cs*0.6,yy-cs*4.5,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*0.6,yy-cs*4.5,xx+cs*1.8,yy-cs*4.5,cs,true,gid));
  gid++;
  wires.add(new Wire(xx+cs*1.8,yy-cs*4.5,xx+cs*3,yy-cs*4.5,cs,false,gid));
  gid++;
}

void fa(float xx, float yy) {
  wires.add(new Wire(xx,yy,xx,yy-cs*4.5,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*1.2,yy,xx+cs*1.2,yy-cs*4.5,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*2.4,yy-cs*3,xx+cs*1.2,yy-cs*12,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx-cs*2.25,yy-cs*10.5,xx,yy-cs*12,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*3,yy-cs*9,xx+cs*4,yy-cs*13,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*3,yy-cs*16.5,xx+cs*4,yy-cs*13,cs,false,gid));
  gid++;
  
  xor(xx,yy-cs*4.5);
  xor(xx,yy-cs*12);  
}

void ca(int mi) {
  for(int i=0; i<mi; i++) {
    fa(i*cs*9+cs*5,height/2);  
    wires.add(new Wire(i*cs*9+cs*5+cs*4,height/2-cs*13,cs*9+i*cs*9+cs*5+cs*2.4,height/2-cs*3,cs,false,gid));
    gid++;
    
    wires.add(new Wire(i*cs*9+cs*5-cs*2.25,height/2-cs*18,width-(i*cs*9+cs*5),cs*5,cs,false,gid));
    gid++;
    
    wires.add(new Wire(width-(i*cs*9+cs*5),cs*5,width-(i*cs*9+cs*5),cs*3,cs,false,gid));
    gid++;
    leds.add(new LED(width-(i*cs*9+cs*5),cs*3,cs*1.5));
    
    wires.add(new Wire(-(i*cs*2)+cs*mi*2,height/2+cs*8,i*cs*9+cs*5,height/2,cs,false,gid));
    gid++;
    
    wires.add(new Wire(-(i*cs*2)+cs*mi*2,height/2+height/10+cs*8,-(i*cs*2)+cs*mi*2,height/2+cs*8,cs,false,gid));
    gid++;
    
    wires.add(new Wire(width-(i*cs*2)-cs*2,height/2+cs*8,i*cs*9+cs*6.2,height/2,cs,false,gid));
    gid++;
    
    wires.add(new Wire(width-(i*cs*2)-cs*2,height/2+height/10+cs*8,width-(i*cs*2)-cs*2,height/2+cs*8,cs,false,gid));
    gid++;
  }  
}

class LED {
    float x;
    float y;
    float s;
    boolean on=false;
    LED(float xx, float yy, float size) {
      x=xx;
      y=yy;
      s=size;
    }
    void d() {
      fill(0);
      stroke(0);
      if(dm) {
        stroke(80);  
      }
      strokeWeight(2);
      if(on) {
        fill(255,255,0);
        if(dm) {
          stroke(150,150,0);    
          fill(255,255,64);
        }
      }
      ellipse(x,y,s,s);
      strokeWeight(cs/8);
    }
    void u() {
      boolean ton=false;
      for(Wire wire : wires) {
        if(x==wire.x2 && y==wire.y2 && wire.on) {
          ton=true;  
        }
      }
      on=ton;
    }
}

class Switch {
  float x;
  float y;
  float s;
  boolean on=false;
  Switch(float xx, float yy, float size) {
    x=xx;
    y=yy;
    s=size;
  }
  void d() {
    fill(100);
    if(on) {
      stroke(0,255,0);  
      if(dm) {
        fill(0,255,0);  
      }
    }
    else {
      stroke(0);  
      if(dm) {
        stroke(100);    
        fill(0);    
      }
    }
    rect(x-s/2,y-s/2,s,s);
  }
}

class tb {
  float x;
  float y;
  float s;
  int n;
  int sel=0;
  tb(float xx, float yy, float ss, int size) {
    x=xx;
    y=yy;
    s=ss;
    n=size;
  }
  void d() {
    for(int i=0; i<n; i++) {
      stroke(0);
      if(dm) {
        stroke(150);  
      }
      if(sel==i) {
        stroke(0,200,0);    
      }
      if(dm) {
        fill(255);  
      }
      else {
        fill(0);  
      }
      switch(i) {
        case 0:
          textSize(s/1.2);
          text("W",x+s/6,y+i*(s+cs/8-0.5)+s/1.2);
        break;
        case 1:
          textSize(s/1.2);
          text("I",x+s/6,y+i*(s+cs/8-0.5)+s/1.2);
        break;
        case 2:
          textSize(s/1.2);
          text("L",x+s/6,y+i*(s+cs/8-0.5)+s/1.2);
        break;
        case 3:
          textSize(s/1.2);
          text("S",x+s/6,y+i*(s+cs/8-0.5)+s/1.2);
        break;
        case 4:
          textSize(s/1.2);
          text("A",x+s/6,y+i*(s+cs/8-0.5)+s/1.2);
        break;
        case 5:
          textSize(s/1.2);
          text("X",x+s/6,y+i*(s+cs/8-0.5)+s/1.2);
        break;
        case 6:
          textSize(s/1.6);
          text("FA",x+s/6,y+i*(s+cs/8-0.5)+s/1.2);
        break;
        case 7:
          textSize(s/1.6);
          text("FS",x+s/6,y+i*(s+cs/8-0.5)+s/1.2);
        break;
      }
      noFill();
      rect(x,y+i*(s+cs/8-0.5),s,s);
    }
  }
}

void fs(float xx, float yy) {
  wires.add(new Wire(xx,yy,xx,yy-cs*4.5,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*1.2,yy,xx+cs*1.2,yy-cs*4.5,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx,yy-cs*4.5,xx+cs*4,yy-cs*4.5,cs,true,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*1.2,yy-cs*4.5,xx+cs*5.2,yy-cs*4.5,cs,false,gid));
  gid++;
  
  xor(xx,yy-cs*4.5);
  and(xx+cs*4,yy-cs*4.5);
  
  wires.add(new Wire(xx,yy-cs*12,xx+cs*4,yy-cs*12,cs,true,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*1.2,yy-cs*12,xx+cs*5.2,yy-cs*12,cs,false,gid));
  gid++;
  
  xor(xx,yy-cs*12);
  and(xx+cs*4,yy-cs*12);
          
  wires.add(new Wire(xx-cs*2.25,yy-cs*10.5,xx,yy-cs*12,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx-cs*4.25,yy-cs*10.5,xx+cs*1.2,yy-cs*12,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*7,yy-cs*9,xx+cs*8,yy-cs*13,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*7,yy-cs*16.5,xx+cs*8,yy-cs*13,cs,false,gid));
  gid++;  
}
