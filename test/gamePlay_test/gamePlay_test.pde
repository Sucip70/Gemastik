PImage com, hny, flower;
PImage pause, btn, h1, h2, Task, box;
PImage hynComb, nectar;

void setup(){
  size(760, 360); //1520x720 piksel
  com = loadImage("Untitled3.png");
  pause = com.get(747, 283, 131, 131);
  btn = com.get(752, 163, 586, 98);
  h1 = com.get(752, 91, 386, 57);
  h2 = com.get(754, 23, 384, 47);
  Task = com.get(1160, 23, 177, 78);
  box = com.get(32, 19, 689, 597);
  hny = loadImage("Untitled4.png");
  hynComb = hny.get(46, 71, 440, 475);
  nectar = hny.get(490, 174, 94, 167);
  flower = loadImage("flower.png");
  initGame();
}

void initGame(){
  pComb.clear();
  pFlower.clear();
  maxF = 5;f = 0;
  for(int i=0;i<maxF;i++){
    int tmp = (int)random(0, 19);
    if(!pComb.contains(tmp))
      pComb.add(tmp);
    else i--;
  }
  initFlower();
  diaE = 50;b = -5;vB = 0.2;
  blood = 500;
  full = false;
  suck = false;
  pausing = false;
  timeSet = 0;
  timePick = 40;
  sFlo = -1;
}

void draw(){
  background(#71FBFF);
  solution();
  Sprite();
  GUI();
}

void solution(){
  if(f==5) {background(0, 255, 0);noLoop();}
  if(blood<=0) {background(255, 0, 0);noLoop();}
}

void GUI(){
  blood();
  image(pause, -10, -16, 65, 65);
  task();
  if(pausing){
    pauseGame();
    noLoop();
  }
}

boolean pausing;
String[] tBtn = {"Lanjutkan","Pengaturan","Keluar"};
void pauseGame(){
  fill(0, 200);
  rect(0, 0, width, height);
  image(box, width/2-172.25, height/2-149.25, 344.5, 298.5);
  
  textSize(30);
  textAlign(CENTER);
  fill(255);
  for(int i=0;i<3;i++){
    image(btn, width/2-146.5, height/2-80+66*i, 293, 59);
    text(tBtn[i], width/2, height/2-40+66*i);
    
  }
}

int maxF, f;
void task(){
  image(Task, width-88.5, 0, 88.5, 39);
  fill(255);
  textSize(20);
  text(str(f)+"/"+str(maxF), width-60, 25);
}

void Sprite(){
  honeyBee();
  enemy();
  setFlower();
  player(mouseX, mouseY);
}

float diaE, b, vB;
void enemy(){
  fill(#FF4815);
  ellipse(50, 150, diaE, diaE);
  if(overObject(100, 50, 150, mouseX, mouseY))
    if(blood>=0)blood-=(diaE/20);
  diaE += b;
  b += vB;
  if(diaE>120)b=-5;
}

float blood;
void blood(){
  image(h1, 50, 5, 193, 28.5);//187
  image(h2, map(blood, 0, 500, 0, 187)-137, 8, 192, 23.5);
  fill(0);
  textSize(12);
  text(str((int)blood)+"/500", 123, 23.5);
}

boolean full;
float timeSet;
void player(int x, int y){
  if(full){
    fill(#FFCD00, 127);
    if(overObject(200, width/2, 138.75, mouseX, mouseY)){
      noFill();
      strokeWeight(4);
      stroke(200);
      ellipse(width/2, 138.75, 255, 255);
      stroke(0, 255, 0);
      arc(width/2, 138.75, 255, 255, 0, timeSet);
      strokeWeight(1);
      stroke(0);
      if(timeSet<TWO_PI)
        timeSet+=0.05;
      else{
        pComb.remove(0);
        f++;
        full = false;
      }
    }else timeSet = 0;
  }else noFill();
  ellipse(x, y, 40, 40);
}

ArrayList<Integer> pComb = new ArrayList<Integer>();
void honeyBee(){
  int ii=0;
  image(hynComb, width/2-110, 20, 220, 237.5);
  for(int i=-2;i<3;i++){
    for(int j=0;j<5-abs(i);j++){
      ii++;
      if(pComb.contains(ii-1))continue;
      image(nectar, width/2-104+40.5*(2+i), 25+24*abs(i)+46*j, 47, 83.5);
    }
  }
}

void initFlower(){
  for(int i=0;i<maxF;i++)
    pFlower.add(random(0, width)); 
}

ArrayList<Float> pFlower = new ArrayList<Float>();
void setFlower(){
  for(int i=0;i<pFlower.size();i++){
    float px = pFlower.get(i);
    image(flower, px, 320, 34, 50);
    if(overObject(40, mouseX, mouseY, px+17, 320)){
      if(suck&&i==sFlo&&!full){
        pickUp(px+17);
      }else
      if(!suck){
        sFlo = i;
        suck = true;
      }
    }else if(i==sFlo){
      suck = false;
      timePick=40;
      sFlo = -1;
    }
  }
}

boolean suck;
int sFlo;
float timePick;
void pickUp(float x){
  strokeWeight(4);
  stroke(20);
  line(x-20, 310, x+20, 310);
  stroke(0, 255, 0);
  line(x-20, 310, x-20+timePick, 310);
  strokeWeight(1);
  stroke(0);
  if(timePick>0)
    timePick-=0.5;
  else {
    suck = false;
    timePick=40;
    pFlower.remove(sFlo);
    sFlo = -1;
    full = true;
  }
}

boolean overObject(int d, float lx, float ly, float x, float y){
  float disX = lx - x;
  float disY = ly - y;
  if(sqrt(sq(disX)+sq(disY))<d/2)
    return true;
  return false;
}

void keyPressed(){
  if(key==ENTER){initGame();loop();}
}

void mouseClicked(){
  if(overObject(65, 22.5, 16.5, mouseX, mouseY))
    pausing = true;
  else if(pausing){
    float w0 = width/2-146.5;
    float w1 = width/2+146.5;
    float h0 = height/2-80;
    float h1 = height/2-21;
    float x = mouseX, y = mouseY;
    if(x>w0 && x<w1 && y>h0 && y<h1){
      pausing = false;
      loop();
    }
    if(x>w0 && x<w1 && y>h0+66 && y<h1+66)println(tBtn[1]);
    if(x>w0 && x<w1 && y>h0+132 && y<h1+132)exit();
  }
}
