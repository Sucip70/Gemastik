PImage bg, sprite;
PImage[] bee = new PImage[5];

void setup(){
  size(760, 360);
  bg = loadImage("background.png");
  sprite = loadImage("bee.png");
  initBee();
}

void initBee(){
  bee[0] = sprite.get(177, 116, 246, 288);
  bee[1] = sprite.get(551, 116, 237, 288);
  bee[2] = sprite.get(920, 116, 239, 288);
  bee[3] = sprite.get(1286, 116, 243, 288);
  bee[4] = sprite.get(1634, 116, 262, 288);
  
  bee[0].resize(bee[0].width/4, bee[0].height/4);
  bee[1].resize(bee[1].width/4, bee[1].height/4);
  bee[2].resize(bee[2].width/4, bee[2].height/4);
  bee[3].resize(bee[3].width/4, bee[3].height/4);
  bee[4].resize(bee[4].width/4, bee[4].height/4);
}

PVector pBee = new PVector(0, 0);
void draw(){
  back();
  pushMatrix();
    translate(pBee.x+width/2, pBee.y+height/2);
    int tmp = frameCount%15/3;
    scale(m, 1);
    image(bee[tmp], -bee[tmp].width/2, -bee[tmp].height/2);
  popMatrix();
  boost();  
  move();
}

void boost(){
  fill(70, 70, 200, 100);
  ellipse(50, height-50, 100, 100);
}

int m = -1;
float xx = 0;
void mouseDragged(){
  float x = mouseX;
  float y = mouseY;
  if(overObject(bee[0].height, pBee.x+width/2, pBee.y+height/2, x, y)){
    if(xx<x)m = 1;
    else m = -1;
    xx = x;
    if(x>width/8 && x<width-width/8)
      pBee.x = x-width/2;
    if(y>bee[0].height/2 && y<height-bee[0].height/2) 
      pBee.y = y-height/2;
  }
}

int realX = 0;
PVector limitArea = new PVector(-720*3, 720*3);
void move(){
  if(pBee.x+width/2<width/4 || pBee.x+width/2>width-width/4){
    if(m==1){
      pos.x-=6;
      realX-=6;
    }else{
      pos.x+=6;
      realX+=6;
    }
    if(realX<limitArea.x){
      pos.x+=6;
      realX+=6;
    }else if(realX>limitArea.y){
      pos.x-=6;
      realX-=6;    
    }
  }
  if(boosted>0){
    if(m==1){
      pos.x-=36;
      realX-=36;
    }else{
      pos.x+=36;
      realX+=36;
    }
    boosted--;
    if(realX<limitArea.x){
      pos.x+=36;
      realX+=36;
      if(pBee.x+width/2<width-width/4)pBee.x+=36;
    }else if(realX>limitArea.y){
      pos.x-=36;
      realX-=36;    
      if(pBee.x+width/2>width/4)pBee.x-=36;
    }
  }
}

PVector pos = new PVector(0, 0);
void back(){
  image(bg, pos.x, pos.y, 760, 360);
  image(bg, width+pos.x, pos.y, 760, 360);
  
  if(abs(pos.x)>width)pos.x=0;
  if(pos.x>0)pos.x=-width;
}

boolean overObject(int d, float lx, float ly, float x, float y){
  float disX = lx - x;
  float disY = ly - y;
  if(sqrt(sq(disX)+sq(disY))<d/2)
    return true;
  return false;
}

int boosted = 0;
void mouseClicked(){
  if(overObject(100, 50, height-50, mouseX, mouseY))
    boosted = 10;
}
