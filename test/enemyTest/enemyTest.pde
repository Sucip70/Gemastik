Frog frog = new Frog();
Skunk skunk = new Skunk();

void setup(){
  size(760, 360); //1520x720 android size
  
}

void draw(){
  background(100);
  frog.create();
  //skunk.create();
}

class Frog{
  PVector gravity = new PVector(0, 0.1);
  PVector velocity = new PVector(0, 0.1);
  PVector pos = new PVector(100, 100); //set on Game's class 
  boolean frogJump = false;
  float toungeV = 0;
  float toungeG = 2.5;
  float toungeL = 1;
  float targetX, targetY;
  
  void create(){
    ellipse(pos.x, pos.y, 100, 100);
    jump();
    shoot();
  }
  
  void jump(){
    pos.add(velocity);
    velocity.add(gravity);
    if(pos.y>height){
      if((frameCount/60)%6==0)
        velocity.y = -7;
      pos.y = height;
      if(pos.x<mouseX)frogJump=false;
      else frogJump=true;
    }else if(pos.y<height){
      if(frogJump)pos.x-=1.5;
      else pos.x+=1.5;
    }
  }
  
  void shoot(){
    pushMatrix();
      if(frameCount%180==0){
        targetX = mouseX;
        targetY = mouseY;
        toungeV = 40;
      }
      toungeL += toungeV;
      toungeV -= toungeG;
      if(toungeL<1){
        toungeV = 0;
        toungeL = 1;
      }
      float a1 = atan2(targetY - pos.y, targetX - pos.x);
      float tx = targetX - cos(a1)*toungeL;
      float ty = targetY - sin(a1)*toungeL;
      float a2 = atan2(ty - pos.y, tx - pos.x);
      translate(pos.x, pos.y);
      rotate(a2);
      line(0, 0, toungeL, 0);
    popMatrix();
  }
}


class Skunk{
  PVector pos = new PVector(width/2, height+180);
  float v = 4;
  float tmpV = 4;
  float f = -1;
  ArrayList<PVector> stinky = new ArrayList<PVector>();
  int time = 0;
  int timeS = 0;
  
  void create(){
    pushMatrix();
      pos.x+=v;
      translate(pos.x, pos.y);
      scale(f, 1);
      ellipse(50, 0, 160, 160);
      ellipse(-50, 10, 140, 140);
    popMatrix();
    if(pos.x<0||pos.x>width){
      v *= -1;
      f *= -1;
    }
    
    for(PVector o:stinky){
      fill(#96FF05);
      rect(o.x, 0, height, height);      
      if(frameCount%60==0)
        o.y--;
      if(o.y==0)stinky.remove(0);
    }
    if(time>0){
      if(frameCount%60==0)
        time--;
      if(time==0)v = tmpV;
      return;
    }
    if(dist(pos.x, 0, mouseX, 0)<5){
      time = 5;
      timeS = time*2;
      tmpV = v;
      v = 0;
      stinky.add(new PVector(pos.x, 10));
    }
  }  
}
