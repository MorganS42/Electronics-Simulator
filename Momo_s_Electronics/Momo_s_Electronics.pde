import java.io.FilenameFilter;

ArrayList<Wire> wires = new ArrayList<Wire>(); 
ArrayList<LED> leds = new ArrayList<LED>(); 
ArrayList<Switch> swts = new ArrayList<Switch>(); 


static final FilenameFilter FILTER = new FilenameFilter() {
  @ Override boolean accept(File path, String name) {
    name = name.toLowerCase();
    return name.endsWith(".txt");
  }
};
File f = dataFile("Electronics");
String[] files = f.list(FILTER);


tb tools;

boolean click=false;

boolean press=false;

float cs=32;

float tx;
float ty;

float txx;
float tyy;

boolean first=true;

boolean dl=false;

boolean dm=true; //dark mode

int gid=0;

int load=0;

int save=0;

float wds=110;

boolean sdd=false;
boolean ldd=false;

ArrayList<PrintWriter> saves = new ArrayList<PrintWriter>();

void setup() {
  //size(1800,1000);
  fullScreen();
  //frameRate(10);
  strokeWeight(cs/8);  
  
  /*for(int i=0; i<3; i++) {
    if(i!=load) {
      saves.add(createWriter(i+".txt"));
    }
  }*/
  
  int mi = 8; //max i
  
  float bs=wds; //box size
  
  tools = new tb(bs,height/2-bs*5.5,bs,12);
  ca(mi,700,350);
  
  for(int i=0; i<6; i++) {
    //sd(120+i*cs*9,300,3);
  }
  
  //btd(300,height-100);
  
  println(files.length);
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
  
  for(Switch swt : swts) {
    swt.d();
  }
  
  for(LED led : leds) {
    led.d();
    led.u();
  }
  
  tools.d();
  
  if(tools.sel==11) {
    wires.clear();
    swts.clear();
    leds.clear();
    tools.sel=0;
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
        
        for(Switch swt : swts) {
          if(mouseX>swt.x-swt.s/2 && mouseX<swt.x+swt.s/2 && mouseY>swt.y-swt.s/2 && mouseY<swt.y+swt.s/2) {
            swt.on=!swt.on;
          }
        }
      }
    }
    
    if(key=='q') {
      for(Wire wire : wires) {
        if(wire.x1<wire.x2) {
          wire.x1++;
          wire.x2--;
        }
        else {
          wire.x1--;
          wire.x2++;
        }
        if(wire.y1<wire.y2) {
          wire.y2--;
          wire.y1++;
        }
        else {
          wire.y1--;
          wire.y2++;
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
    else if(!((mouseX>-5 && mouseX<wds*4+5 && mouseY>-5 && mouseY<wds+5) || (sdd && mouseX>0 && mouseX<wds*1.5 && mouseY>0 && mouseY<(wds+wds/12)*(save+2)) || (ldd && mouseX>wds*2 && mouseX<wds*3.5 && mouseY>0 && mouseY<(wds+wds/12)*(save+1)))) {
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
            
            for(Switch swt : swts) {
              if(mouseX>swt.x-swt.s/2 && mouseX<swt.x+swt.s/2 && mouseY>swt.y-swt.s/2 && mouseY<swt.y+swt.s/2) {
                xx=swt.x;
                yy=swt.y;
              }
            }
            
            if(tools.sel==4) { 
              and(xx,yy,2);  
              first=true;
              dl=false;
            }
            else if(tools.sel==3) {
              swts.add(new Switch(xx,yy,cs*2));
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
            else if(tools.sel==8) {
              sd(xx,yy,3);
              first=true;
              dl=false;
            }
            else if(tools.sel==9) {
              btd(xx,yy);
              first=true;
              dl=false;
            }
            else if(tools.sel==10) {
              
              for(int i=0; i<wires.size(); i++) {
                if(pow(mouseX-wires.get(i).x1,2)+pow(mouseY-wires.get(i).y1,2)<pow(wires.get(i).s,2)) {
                  wires.remove(i);
                }
                else if(pow(mouseX-wires.get(i).x2,2)+pow(mouseY-wires.get(i).y2,2)<pow(wires.get(i).s,2)) {
                  wires.remove(i);
                }
              }
              
              for(int i=0; i<swts.size(); i++) {
                if(mouseX>swts.get(i).x-swts.get(i).s/2 && mouseX<swts.get(i).x+swts.get(i).s/2 && mouseY>swts.get(i).y-swts.get(i).s/2 && mouseY<swts.get(i).y+swts.get(i).s/2) {
                  swts.remove(i);
                }
              }
              
              for(int i=0; i<leds.size(); i++) {
                if(pow(mouseX-leds.get(i).x,2)+pow(mouseY-leds.get(i).y,2)<pow(leds.get(i).s,2)) {
                  leds.remove(i);
                }
              }
              
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
              for(Switch swt : swts) {
                if(mouseX>swt.x-swt.s/2 && mouseX<swt.x+swt.s/2 && mouseY>swt.y-swt.s/2 && mouseY<swt.y+swt.s/2) {
                  tx=swt.x;
                  ty=swt.y;
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
  
  sd();
}

void sd() {
  strokeWeight(wds/12);
  stroke(100);
  rect(0,0,wds*2,wds);  
  rect(wds*2,0,wds*2,wds);  
  textSize(wds/1.3);
  text("Save",wds/6,wds/1.2);
  text("Load",wds*2,wds/1.2);
  
  if(mouseX>wds*2 && mouseX<wds*4 && mouseY>0 && mouseY<wds) {
    ldd=true;  
  }
  
  if(ldd) {
    for(int i=0; i<save; i++) {
      if(mouseX>wds*2 && mouseX<wds*3.5 && mouseY>(wds+wds/12)*(i+1) && mouseY<(wds+wds/12)*(i+2)) {
        stroke(0,255,0);  
        if(mousePressed) {
          fill(0,255,0);
          
          BufferedReader reader = createReader(i+".txt");
          String line = null;
          try {
            while ((line = reader.readLine()) != null) {
              String[] pieces = split(line, ' ');
              switch(pieces[0]) {
                case "w":
                  wires.add(new Wire(float(pieces[1]),float(pieces[2]),float(pieces[3]),float(pieces[4]),float(pieces[5]),boolean(pieces[6]),int(pieces[7])));
                break;
              }
            }
            reader.close();
          } 
          catch (IOException e) {
            e.printStackTrace();
          }  
        }
        else {
          fill(0);  
        }
      }
      else {
        stroke(100);  
        fill(0);
      }

      rect(wds*2,(wds+wds/12)*(i+1),wds*1.5,wds);   
      strokeWeight(0);
      rect(wds*2+3,(wds+wds/12)*(i+1)+3,wds*1.5-3,wds-3);
      fill(100);
      strokeWeight(wds/12);
      
      fill(255);
      textSize(wds/3);
      text("Load up",wds*2+wds/6,(wds+wds/12)*(i+1.4));
      text(i+".txt",wds*2+wds/6,(wds+wds/12)*(i+1.8));
    }  
  }
  
  if(mouseX>0 && mouseX<wds*2 && mouseY>0 && mouseY<wds) {
    sdd=true;   
  }
  
  if(sdd) {
    for(int i=0; i<save; i++) {
      if(mouseX>0 && mouseX<wds*1.5 && mouseY>(wds+wds/12)*(i+1) && mouseY<(wds+wds/12)*(i+2)) {
        stroke(0,255,0);  
        if(mousePressed) {
          fill(0,255,0);
          
          if(!(saves.size()>i)) {
            saves.add(createWriter(i+".txt"));
          }
          for(Wire wire : wires) {
            saves.get(i).println("w "+wire.x1+" "+wire.y1+" "+wire.x2+" "+wire.y2+" "+wire.s+" "+wire.i+" "+wire.id);  
          }
          for(LED led : leds) {
            saves.get(i).println("l "+led.x+" "+led.y+" "+led.s);  
          }
          for(Switch swt : swts) {
            saves.get(i).println("s "+swt.x+" "+swt.y+" "+swt.s+" "+swt.on);  
          }
          
          saves.get(i).flush();
          saves.get(i).close();
        }
        else {
          fill(0);  
        }
      }
      else {
        stroke(100);  
        fill(0);
      }
      
      rect(0,(wds+wds/12)*(i+1),wds*1.5,wds);   
      strokeWeight(0);
      rect(3,(wds+wds/12)*(i+1)+3,wds*1.5-3,wds-3);
      fill(100);
      strokeWeight(wds/12);
      
      fill(255);
      textSize(wds/3);
      text("Save to",wds/6,(wds+wds/12)*(i+1.4));
      text(i+".txt",wds/6,(wds+wds/12)*(i+1.8));
    }
    
    
    if(mouseX>0 && mouseX<wds*1.5 && mouseY>(wds+wds/12)*(save+1) && mouseY<(wds+wds/12)*(save+2)) {
      stroke(0,255,0); 
      if(mousePressed) {
        fill(0,255,0); 
        save++;
      }
      else {
        fill(0);  
      }
    }
    else {
      stroke(100);  
      fill(0);
    }
    rect(0,(wds+wds/12.2)*(save+1),wds*1.5,wds); 
    strokeWeight(0);
    rect(3,(wds+wds/12.2)*(save+1)+3,wds*1.5-3,wds-3);
    fill(100);
    strokeWeight(wds/12);
    
    fill(255);
    textSize(wds/3);
    text("Save to",wds/6,(wds+wds/12.2)*(save+1.4));
    text("New File",wds/6,(wds+wds/12.2)*(save+1.8));
    
    if(!(mouseX>0 && mouseX<wds*1.5 && mouseY>0 && mouseY<(wds+wds/12)*(save+2))) {
      sdd=false;  
    }
    
    if(!(mouseX>wds*2 && mouseX<wds*3.5 && mouseY>0 && mouseY<(wds+wds/12)*(save+1))) {
      ldd=false;  
    }
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
    
    //saves.get(save).println(x1+" "+y1+" "+x2+" "+y2+" "+s+" "+i+" "+id);
  }
  
  void d() {
    fill(100);
    if(on) {
      stroke(0,255,0);  
      if(i) {
        stroke(0,100,0);  
        if(dm) {
          stroke(0,120,0);  
          fill(0,120,0);  
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
          if(x1==wire.x2 && y1==wire.y2 && wire.on) {
            ton=false;  
          }
        }
      }
      
      for(Switch swt : swts) {
        if(x1>swt.x-swt.s/2 && x1<swt.x+swt.s/2 && y1>swt.y-swt.s/2 && y1<swt.y+swt.s/2 && swt.on) {
          ton=false;
        }
      }
    }
    
    else {
      ton=false;
      for(Wire wire : wires) {
        if(!(id==wire.id)) {
          if(x1==wire.x2 && y1==wire.y2 && wire.on) {
            ton=true;  
          }
        }
      }
      
      for(Switch swt : swts) {
        if(x1>swt.x-swt.s/2 && x1<swt.x+swt.s/2 && y1>swt.y-swt.s/2 && y1<swt.y+swt.s/2 && swt.on) {
          ton=true;
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

void and(float xx, float yy, int n) {
  for(int i=0; i<n; i++) {
    wires.add(new Wire(xx+cs*1.2*i,yy,xx+cs*1.2*i,yy-cs*1.5,cs,false,gid));
    gid++;
    
    wires.add(new Wire(xx+cs*1.2*i,yy-cs*1.5,xx+cs*1.2*i,yy-cs*3,cs,true,gid));
    gid++;
    
    wires.add(new Wire(xx+cs*1.2*i,yy-cs*3,xx+cs*0.6,yy-cs*4.5,cs,false,gid));
    gid++;
  }
  
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

void ca(int mi, float tx, float ty) {
  for(int i=0; i<mi; i++) {
    fa(i*cs*9+cs*5 +tx,height/2 +ty);  
    wires.add(new Wire(i*cs*9+cs*5+cs*4 +tx,height/2-cs*13 +ty,cs*9+i*cs*9+cs*5+cs*2.4 +tx,height/2-cs*3 +ty,cs,false,gid));
    gid++;
    
    wires.add(new Wire(i*cs*9+cs*5-cs*2.25 +tx,height/2-cs*18 +ty,width-(i*cs*9+cs*5),cs*5 +ty,cs,false,gid));
    gid++;
    
    wires.add(new Wire(width-(i*cs*9+cs*5),cs*5 +ty,width-(i*cs*9+cs*5),cs*3,cs,false,gid));
    gid++;
    leds.add(new LED(width-(i*cs*9+cs*5),cs*3,cs*1.5));
    
    wires.add(new Wire(-(i*cs*2)+cs*mi*2 +tx,height/2+cs*8 +ty,i*cs*9+cs*5 +tx,height/2 +ty,cs,false,gid));
    gid++;
    
    wires.add(new Wire(-(i*cs*2)+cs*mi*2 +tx,height/2+height/10+cs*8 +ty,-(i*cs*2)+cs*mi*2 +tx,height/2+cs*8 +ty,cs,false,gid));
    gid++;
    
    swts.add(new Switch(-(i*cs*2)+cs*mi*2 +tx,height/2+height/10+cs*8 +ty,cs*2));
    
    wires.add(new Wire(width-(i*cs*2)-cs*2,height/2+cs*8 +ty,i*cs*9+cs*6.2 +tx,height/2 +ty,cs,false,gid));
    gid++;
    
    wires.add(new Wire(width-(i*cs*2)-cs*2,height/2+height/10+cs*8 +ty,width-(i*cs*2)-cs*2,height/2+cs*8 +ty,cs,false,gid));
    gid++;
    
    swts.add(new Switch(width-(i*cs*2)-cs*2,height/2+height/10+cs*8 +ty,cs*2));
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
    strokeWeight(wds/20);
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
          text("W",x+s/6,y+i*(s+wds/20-0.5)+s/1.2);
        break;
        case 1:
          textSize(s/1.2);
          text("I",x+s/6,y+i*(s+wds/20-0.5)+s/1.2);
        break;
        case 2:
          textSize(s/1.2);
          text("L",x+s/6,y+i*(s+wds/20-0.5)+s/1.2);
        break;
        case 3:
          textSize(s/1.2);
          text("S",x+s/6,y+i*(s+wds/20-0.5)+s/1.2);
        break;
        case 4:
          textSize(s/1.2);
          text("A",x+s/6,y+i*(s+wds/20-0.5)+s/1.2);
        break;
        case 5:
          textSize(s/1.2);
          text("X",x+s/6,y+i*(s+wds/20-0.5)+s/1.2);
        break;
        case 6:
          textSize(s/1.6);
          text("FA",x+s/6,y+i*(s+wds/20-0.5)+s/1.2);
        break;
        case 7:
          textSize(s/1.6);
          text("FS",x+s/6,y+i*(s+wds/20-0.5)+s/1.2);
        break;
        case 8:
          textSize(s/2);
          text("7SD",x,y+i*(s+wds/20-0.5)+s/1.2);
        break;
        case 9:
          textSize(s/2);
          text("BtD",x+s/12,y+i*(s+wds/20-0.5)+s/1.2);
        break;
        case 10:
          stroke(255,0,0);
          strokeWeight(10);
          line(x+10,y+i*(s+wds/20-0.5)+10,x+s-10,y+i*(s+wds/20-0.5)+s-10);
          line(x+s-10,y+i*(s+wds/20-0.5)+10,x+10,y+i*(s+wds/20-0.5)+s-10);
          
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
          strokeWeight(wds/20);
          
        break;
        case 11:
          textSize(s/1.2);
          text("C",x+s/6,y+i*(s+wds/20-0.5)+s/1.2);
        break;
      }
      noFill();
      rect(x,y+i*(s+wds/20-0.5),s,s);
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
  and(xx+cs*4,yy-cs*4.5,2);
  
  wires.add(new Wire(xx,yy-cs*12,xx+cs*4,yy-cs*12,cs,true,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*1.2,yy-cs*12,xx+cs*5.2,yy-cs*12,cs,false,gid));
  gid++;
  
  xor(xx,yy-cs*12);
  and(xx+cs*4,yy-cs*12,2);
          
  wires.add(new Wire(xx-cs*2.25,yy-cs*10.5,xx,yy-cs*12,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx-cs*4.25,yy-cs*10.5,xx+cs*1.2,yy-cs*12,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*7,yy-cs*9,xx+cs*8,yy-cs*13,cs,false,gid));
  gid++;
  
  wires.add(new Wire(xx+cs*7,yy-cs*16.5,xx+cs*8,yy-cs*13,cs,false,gid));
  gid++;  
}

void sd(float xx, float yy, int d) {
  for(int i=1; i<d; i++) {
    wires.add(new Wire(xx+i*cs*1.5,yy,xx+cs*1.5+i*cs*1.5,yy,cs,false,gid));
    gid++;        
    leds.add(new LED(xx+i*cs*1.5,yy,cs*1.5)); 
    
    wires.add(new Wire(xx,yy-i*cs*1.5,xx,yy-cs*1.5-i*cs*1.5,cs,false,gid));
    gid++;        
    leds.add(new LED(xx,yy-i*cs*1.5,cs*1.5)); 
    
    wires.add(new Wire(xx+cs*(d+1)*1.5,yy-i*cs*1.5,xx+cs*(d+1)*1.5,yy-cs*1.5-i*cs*1.5,cs,false,gid));
    gid++;        
    leds.add(new LED(xx+cs*(d+1)*1.5,yy-i*cs*1.5,cs*1.5)); 
    
    wires.add(new Wire(xx+cs*(d+1)*1.5,yy-i*cs*1.5-cs*(d+1)*1.5,xx+cs*(d+1)*1.5,yy-cs*1.5-i*cs*1.5-cs*(d+1)*1.5,cs,false,gid));
    gid++;        
    leds.add(new LED(xx+cs*(d+1)*1.5,yy-i*cs*1.5-cs*(d+1)*1.5,cs*1.5)); 
    
    wires.add(new Wire(xx,yy-i*cs*1.5-cs*(d+1)*1.5,xx,yy-cs*1.5-i*cs*1.5-cs*(d+1)*1.5,cs,false,gid));
    gid++;        
    leds.add(new LED(xx,yy-i*cs*1.5-cs*(d+1)*1.5,cs*1.5)); 
    
    wires.add(new Wire(xx+i*cs*1.5,yy-cs*(d+1)*1.5,xx+cs*1.5+i*cs*1.5,yy-cs*(d+1)*1.5,cs,false,gid));
    gid++;        
    leds.add(new LED(xx+i*cs*1.5,yy-cs*(d+1)*1.5,cs*1.5)); 
    
    wires.add(new Wire(xx+i*cs*1.5,yy-cs*(d+d+2)*1.5,xx+cs*1.5+i*cs*1.5,yy-cs*(d+d+2)*1.5,cs,false,gid));
    gid++;        
    leds.add(new LED(xx+i*cs*1.5,yy-cs*(d+d+2)*1.5,cs*1.5)); 
  }
  leds.add(new LED(xx+cs*d*1.5,yy,cs*1.5));
  leds.add(new LED(xx+cs*d*1.5,yy-cs*(d+1)*1.5,cs*1.5));
  leds.add(new LED(xx+cs*d*1.5,yy-cs*(d+d+2)*1.5,cs*1.5));
  
  leds.add(new LED(xx,yy-cs*d*1.5,cs*1.5));
  leds.add(new LED(xx+cs*(d+1)*1.5,yy-cs*d*1.5,cs*1.5));
  
  leds.add(new LED(xx,yy-cs*(d+d+1)*1.5,cs*1.5));
  leds.add(new LED(xx+cs*(d+1)*1.5,yy-cs*(d+d+1)*1.5,cs*1.5));
}

void btd(float xx, float yy) {
  //cs=cs/2;
  
  float a1=xx;
  float b1=xx+cs*2;
  float b2=xx+cs*3;
  float c1=xx+cs*4;
  float c2=xx+cs*5;
  float d1=xx+cs*6;
  float d2=xx+cs*7;
  
  float yyy=yy-cs*5;
  
  wires.add(new Wire(xx,yy,xx,yy-cs*3,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*2,yy,xx+cs*2,yy-cs*3,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*4,yy,xx+cs*4,yy-cs*3,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*6,yy,xx+cs*6,yy-cs*3,cs,false,gid));  
  gid++;
 
  //wires.add(new Wire(xx,yy-cs*3,xx+cs*1,yy-cs*5,cs,true,gid));  
  //gid++;
  wires.add(new Wire(xx+cs*2,yy-cs*3,b2,yyy,cs,true,gid));  
  gid++;
  wires.add(new Wire(xx+cs*4,yy-cs*3,c2,yyy,cs,true,gid));  
  gid++;
  wires.add(new Wire(xx+cs*6,yy-cs*3,d2,yyy,cs,true,gid));  
  gid++;
  
  wires.add(new Wire(xx,yy-cs*3,a1,yyy,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*2,yy-cs*3,b1,yyy,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*4,yy-cs*3,c1,yyy,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*6,yy-cs*3,d1,yyy,cs,false,gid));  
  gid++;
  
  
  and(xx,yy-cs*7,2);
  and(xx+cs*4,yy-cs*7,2);
  and(xx+cs*8,yy-cs*7,2);
  and(xx+cs*12,yy-cs*7,2);
  and(xx+cs*16,yy-cs*7,2);
  and(xx+cs*20,yy-cs*7,2);
  and(xx+cs*24,yy-cs*7,2);
  and(xx+cs*28,yy-cs*7,2);
  and(xx+cs*32,yy-cs*7,2);
  
  wires.add(new Wire(b1,yyy,xx,yy-cs*7,cs,false,gid));  
  gid++;
  wires.add(new Wire(d1,yyy,xx+cs*1.2,yy-cs*7,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(b2,yyy,xx+cs*4,yy-cs*7,cs,false,gid));  
  gid++;
  wires.add(new Wire(d2,yyy,xx+cs*5.2,yy-cs*7,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(c1,yyy,xx+cs*8,yy-cs*7,cs,false,gid));  
  gid++;
  wires.add(new Wire(d1,yyy,xx+cs*9.2,yy-cs*7,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(c2,yyy,xx+cs*12,yy-cs*7,cs,false,gid));  
  gid++;
  wires.add(new Wire(d2,yyy,xx+cs*13.2,yy-cs*7,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(c1,yyy,xx+cs*16,yy-cs*7,cs,false,gid));  
  gid++;
  wires.add(new Wire(d2,yyy,xx+cs*17.2,yy-cs*7,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(b2,yyy,xx+cs*20,yy-cs*7,cs,false,gid));  
  gid++;
  wires.add(new Wire(c1,yyy,xx+cs*21.2,yy-cs*7,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(d1,yyy,xx+cs*24,yy-cs*7,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*31,yy-cs*11.5,xx+cs*25.2,yy-cs*7,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(b1,yyy,xx+cs*28,yy-cs*7,cs,false,gid));  
  gid++;
  wires.add(new Wire(c2,yyy,xx+cs*29.2,yy-cs*7,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(b1,yyy,xx+cs*32,yy-cs*7,cs,false,gid));  
  gid++;
  wires.add(new Wire(d2,yyy,xx+cs*33.2,yy-cs*7,cs,false,gid));  
  gid++;
  
  
  wires.add(new Wire(xx+cs*3,yy-cs*11.5,xx,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*7,yy-cs*11.5,xx,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(a1,yyy,xx,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(c1,yyy,xx,yy-cs*15,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(xx+cs*11,yy-cs*11.5,xx+cs*2,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*15,yy-cs*11.5,xx+cs*2,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(b2,yyy,xx+cs*2,yy-cs*15,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(b1,yyy,xx+cs*4,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(c2,yyy,xx+cs*4,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(d1,yyy,xx+cs*4,yy-cs*15,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(a1,yyy,xx+cs*6,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*7,yy-cs*11.5,xx+cs*6,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*19,yy-cs*11.5,xx+cs*6,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*23,yy-cs*11.5,xx+cs*6,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*27,yy-cs*11.5,xx+cs*6,yy-cs*15,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(xx+cs*19,yy-cs*11.5,xx+cs*8,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*7,yy-cs*11.5,xx+cs*8,yy-cs*15,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(xx+cs*15,yy-cs*11.5,xx+cs*10,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*35,yy-cs*11.5,xx+cs*10,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*31,yy-cs*11.5,xx+cs*10,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(a1,yyy,xx+cs*10,yy-cs*15,cs,false,gid));  
  gid++;
  
  wires.add(new Wire(xx+cs*19,yy-cs*11.5,xx+cs*12,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*31,yy-cs*11.5,xx+cs*12,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(a1,yyy,xx+cs*12,yy-cs*15,cs,false,gid));  
  gid++;
  wires.add(new Wire(xx+cs*23,yy-cs*11.5,xx+cs*12,yy-cs*15,cs,false,gid));  
  gid++;
  
  //cs=cs*2;
}
