PImage home, ui;
PImage hive, shop, j, badge, coin, dia;

void setup(){
  size(760, 360);
  home = loadImage("home.png");
  ui = loadImage("Untitled.png");
  hive = ui.get(33, 217, 280, 275);
  shop = ui.get(341, 288, 208, 207);
  j = ui.get(338, 92, 121, 129);
  dia = coin = ui.get(495, 99, 262, 55);
  badge = ui.get(484, 171, 283, 99);
  initPrice();
}

ArrayList<Diamond> diamond = new ArrayList<Diamond>();
void initPrice(){
  diamond.add(new Diamond("Pemula", 5000, 5, 5, 0, 0));
  diamond.add(new Diamond("Profesional", 10000, 10, 10, 0, 0));
  diamond.add(new Diamond("Grandmaster", 24000, 24, 24, 0, 0));
  diamond.add(new Diamond("Jenius", 42000, 36, 24, 0, 0));  
}

void draw(){
  image(home, 0, 0, 760, 360);
  image(shop, 600, 70, 104, 103.5);
  GUI();
  beeHive();
}

int countDate(Dates o){
  int ye = year();
  int y = (ye%4==0?366:365)*(o.year-ye)*86400;
  int mo = month();
  int mt = (mo==2?(ye%4==0?29:28):(mo%2==(mo<8?1:0)?31:30))*(o.month-mo)*86400;
  int d = 86400*(o.day-day());
  int h = 3600*(o.hour-hour());
  int m = 60*(o.minute-minute());
  int s = o.second-second();
  return y+mt+d+h+m+s;
}

Dates hiveCD;
void beeHive(){
  image(hive, 95, 130, 140, 137.5);
  if(pickPrice!=-1){
    int cd = countDate(hiveCD);
    if(cd<0){
      diaNom+=diamond.get(pickPrice).obtained;
      pickPrice = -1;
    }else{
      int h = cd/3600;
      int m = (cd%3600)/60;
      int s = (cd%3600)%60;
      textSize(30);
      fill(0);
      text(co(h)+":"+co(m)+":"+co(s), 95, 130);
    }
  }

  if(hiveClick){
    fill(0, 200);
    rect(0, 0, width, height);
    if(pickPrice==-1){
      fill(180);
      rect(width/2-200, height/2-150, 400, 300);
      for(int i=0;i<diamond.size();i++){
        Diamond o = diamond.get(i);
        fill(127, 127, 0);
        rect(width/2-180, height/2+53*i-100, 360, 50);
        fill(255);
        textSize(30);
        text(o.type, width/2-180, height/2+53*i-75);
        String p = str(o.price); 
        text(p, width/2+180-textWidth(p), height/2+53*i-65);
        textSize(20);
        text(o.obtained+" - "+co(o.h)+":"+co(o.m)+":"+co(o.s), width/2-180, height/2+53*i-55);
      }
    }else{
      fill(180);
      rect(width/2-100, height/2-50, 200, 100);
      textSize(12);
      textAlign(CENTER);
      fill(0);
      text("apakah kamu yakin\nmempercepat dengan\nmengurangi 50000 koin ?", width/2, height/2-20);
      textAlign(LEFT);
      fill(255, 0, 0);
      rect(width/2+7.5, height/2+30, 80, 30);
      fill(0, 255, 0);
      rect(width/2-87.5, height/2+30, 80, 30);
    }
  }
}

void GUI(){
  image(j, 470, 100, 60.5, 64.5);
  image(badge, 0, 0, 141.5, 48.5);
  treasure();
  
  fill(200);
  rect(width-54, height-54, 50, 50); //exit
  rect(width-108, height-54, 50, 50); //tips
  rect(width-162, height-54, 50, 50); //setting
}

int diaNom = 99999, coNom = 99999;
void treasure(){
  textSize(16);
  fill(0);
  image(coin, 659, 4, 91, 27.5);
  text(str(coNom), 664, 24);
  image(dia, 563, 4, 91, 27.5);
  text(str(diaNom), 568, 24);
}

String co(int c){
  if(c/10>0)return str(c);
  return "0"+c;
}

void setOrder(int i){
  Diamond o = diamond.get(i);
  if(buy(0, o.price)){
    int d = o.h/24;
    int h = o.h%24;
    hiveCD = new Dates(year(), month(), day()+d, hour()+h, minute()+o.m, second()+o.s);
    pickPrice = i;
    hiveClick = false;
  }
}

boolean buy(int x, int y){
  if((x==0?coNom:diaNom)<y)return false;
  if(x==0)coNom -= y;
  else diaNom -= y;
  return true;
}

boolean hiveClick = false;
int pickPrice = -1;
void mouseClicked(){
  int x = mouseX;
  int y = mouseY;
  if(hiveClick){
    if(pickPrice!=-1){
      if(width/2+7.5<x && x<width/2+87.5 && height/2+30<y && y<height/2+60)hiveClick = false;
      else if(width/2-87.5<x && x<width/2-7.5 && height/2+30<y && y<height/2+60){
        hiveClick = false;
        if(buy(0, 50000))hiveCD = new Dates(year(), month(), day(), hour(), minute(), second()+5);
      }
    }else{
      if(width/2-200<x && x<width/2+200 && height/2-150<y && y<height/2+150){
        for(int i=0;i<diamond.size();i++){
          if(width/2-180<x && x<width/2+180 && height/2+53*i-100<y && y<height/2+53*i-50){
            fill(255, 127, 0);
            rect(width/2-180, height/2+53*i-100, 360, 50);
            setOrder(i);
          }
        }
      }else hiveClick = false;
    } 
  }else{
    if(95<x && x<215 && 130<y && y<267.5){ //beehive
      PImage tmp = hive.get();
      tmp.filter(INVERT);
      image(tmp, 95, 130, 140, 137.5);
      hiveClick = true;
    }
  }
}

class Diamond{
  int h, m, s; //time
  int price;
  int obtained;
  String type;
  
  Diamond(String t, int p, int o, int h, int m, int s){
    type = t;
    price = p;
    obtained = o;
    this.h = h;
    this.m = m;
    this.s = s;
  }
}

class Dates{
  int year, month, day, hour, minute, second;
  Dates(int y, int mt, int d, int h, int m, int s){
    year = y;
    month = mt;
    day = d;
    hour = h;
    minute = m;
    second = s;
  }
}
