ArrayList<Wire> wires = new ArrayList<Wire>(); 

boolean click=false;

boolean press=false;

float cs=20;

float tx;
float ty;

float txx;
float tyy;

boolean first=true;

boolean dl=false;

int gid=0;

void setup() {
  fullScreen();
  //frameRate(10);
  strokeWeight(cs/8);  
}

void draw() {
  background(255);
  for(Wire wire : wires) {
    wire.d();
    wire.u();
  }
  
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
    
    
    if(key=='z') {
      if(!press) {
        press=true;
        
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
        
        and(xx,yy);
      }
    }
    
    
    if(key=='x') {
      if(!press) {
        press=true;
        
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
        
        xor(xx,yy);
      }
    }
    
    
    if(key=='c') {
      if(!press) {
        press=true;
        
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
    }
    
    if(key=='v') {
      if(!press) {
        press=true;
        
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
    if(!click) {
      click=true;
      if(mouseButton==LEFT) {
        if(first) {
          first=false;
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
            if(key=='i') {
              wires.add(new Wire(tx,ty,txx,tyy,cs,true,gid));
              gid++;
            }
            else {
              wires.add(new Wire(tx,ty,txx,tyy,cs,false,gid));
              gid++;
            }
          }
          tx=txx;
          ty=tyy;
        }
        dl=true;
      }
      else if(mouseButton==RIGHT) {
        first=true;
        dl=false;
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
    
    if(on) {
      stroke(0,255,0);  
      if(i) {
        stroke(0,100,0);  
      }
    }
    else {
      stroke(0);  
      if(i) {
        stroke(0,0,180);  
      }
    }
    line(x1,y1,x2,y2);
    fill(100);
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
