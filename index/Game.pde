int selectedLevel = 0;
ArrayList<PVector> flo = new ArrayList<PVector>();

class Game{
  static final int page = 0;
  boolean swing = false;
  boolean full = false;
  //load game data
  
  void sketch(){
    background(#FC62FF);
    btn.Back(Journey.page);
    text(str(selectedLevel), width/2, height/2);
    
    setEntity();
    pushMatrix();
      translate(mouseX, mouseY);    
      bee();
    popMatrix();
    winSolution();
  }
  
  void winSolution(){
    if(cap==1){
      fill(255);
      rect(10, 10, width-20, height-20);
    }
  }
  
  //Enemy enemy = new Enemy();
  Skunk skunk = new Skunk();
  Frog frog = new Frog();
  void setEntity(){
    honeyComb();
    //for flower
    for(int i=0;i<flo.size();i++){
      flower(int(flo.get(i).x), int(flo.get(i).y), i);
    }
    //frog.create();
    skunk.create();
    //for enemy
  }
  
  void flower(int x, int y, int index){
    if(!full){  
      if(overObject(50, mouseX, mouseY, x, y)){
        //delete row with id_flower
        flo.remove(index);
        full = true;
        //bee get honeycomb
      }
    }
    fill(#CA62FF);
    ellipse(x, y, 50, 50);
  }
  
  //void enemy(int x, int y){
    
  //}
  
  int cap = 0;
  void honeyComb(){
    if(overObject(300, 600, 100, mouseX, mouseY)&&full){
      cap++;
      full = false;
    }
    ellipse(600, 100, 300, 300);
    fill(0);
    text(cap+"/"+1, 600, 100);
  }
  
  void bee(){
    noStroke();
    int r = 0;
    for(int i=0;i<3;i++){
      fill(0);
      ellipse(-15+r, 0, 30, 40);
      rect(-15+r, -20, 5, 40);
      r+=(5+i);
      
      fill(#F5E905);
      ellipse(-15+r, 0, 30, 40);
      rect(-15+r, -20, 5, 40);
      r+=(5+i);
    }
    fill(#F5E905);
    ellipse(-15+r, 0, 30, 40);
    
    fill(0);
    ellipse(20, -7, 4, 7);
    ellipse(26, -7, 4, 7);
    
    noFill();
    stroke(0);
    arc(23, -4, 8, 10, PI/4, PI/4*3);
    
    fill(255);
    noStroke();
    //swing=!swing;
    if(swing){
      triangle(2, -20, 17, -22, 8, -31);
      triangle(2, -20, -13, -22, -4, -31);
      ellipse(14, -28, 12, 12);
      ellipse(-10, -28, 12, 12);
    }else{
      triangle(2, -20, 12, -25, 2, -30);
      triangle(2, -20, -8, -25, 2, -30);
      ellipse(8, -30, 12, 12);
      ellipse(-4, -30, 12, 12);
    }
    noFill();
    strokeWeight(2);
    stroke(0);
    curve(36, -10, 26, -19, 45, -30, 72, 10);
    curve(50, 0, 20, -19, 32, -40, 112, -20);
  } 
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

class Enemy{
  void bear(){}
  void hornet(){}
  void wasp(){}
  void yellowjacket(){}
  void skunk(){}
  void chipmunk(){}
}
