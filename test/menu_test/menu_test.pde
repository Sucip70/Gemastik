PImage home, obj, gui;
PImage hive, shop, sign, coin, dimn, xbar;
PImage btn_set, btn_tip, btn_ext;
PImage[] badge = new PImage[3];
PFont font;

void setup(){
  size(760, 360);
  home = loadImage("home.png");
  obj = loadImage("object.png");
  gui = loadImage("icons.png");
  font = createFont("Cubano.ttf", 20);
  textFont(font);
  initPrice();
  initObject();
  imageMode(CENTER);
}

void initObject(){
  hive = obj.get(0, 0, 263, 308);
  shop = obj.get(276, 1, 175, 170);
  sign = obj.get(268, 184, 201, 123);
  badge[0] = gui.get(477, 505, 135, 135);
  badge[1] = gui.get(654, 505, 145, 135);
  badge[2] = gui.get(838, 505, 165, 135);
  btn_ext = gui.get(53, 288, 91, 99);
  btn_set = gui.get(54, 123, 91, 99);
  btn_tip = gui.get(220, 288, 91, 99);
  coin = gui.get(476, 767, 91, 87);
  dimn = gui.get(589, 766, 103, 87);
  xbar = gui.get(50, 535, 307, 60);
  
  home.resize(home.width/2, home.height/2);
  hive.resize(hive.width/2, hive.height/2);
  shop.resize(shop.width/2, shop.height/2);
  sign.resize(sign.width/2, sign.height/2);
  badge[0].resize(badge[0].width/2, badge[0].height/2);
  badge[1].resize(badge[1].width/2, badge[1].height/2);
  badge[2].resize(badge[2].width/2, badge[2].height/2);
  btn_ext.resize(btn_ext.width/2, btn_ext.height/2);
  btn_set.resize(btn_set.width/2, btn_set.height/2);
  btn_tip.resize(btn_tip.width/2, btn_tip.height/2);
  coin.resize(coin.width/2, coin.height/2);
  dimn.resize(dimn.width/2, dimn.height/2);
  xbar.resize(xbar.width/2, xbar.height/2);
}

ArrayList<Diamond> diamond = new ArrayList<Diamond>();
void initPrice(){
  diamond.add(new Diamond("Pemula", 5000, 5, 5, 0, 0));
  diamond.add(new Diamond("Profesional", 10000, 10, 10, 0, 0));
  diamond.add(new Diamond("Grandmaster", 24000, 24, 24, 0, 0));
  diamond.add(new Diamond("Jenius", 42000, 36, 24, 0, 0));  
}

void draw(){
  image(home, width/2, height/2);
  image(shop, 676, 106);
  image(sign, 550, 131);
  image(hive, 216, 162);
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
  fill(255);
  image(xbar.get(45, 0, xbar.width-45, xbar.height), 110, 36);
  image(badge[0], 50, 40);
  text("45/45", 95, 43);
  treasure();
  
  fill(200);
  image(btn_ext, 700, 320);
  image(btn_tip, 640, 320);
  image(btn_set, 580, 320);
}

int diaNom = 99999, coNom = 99999;
void treasure(){
  textSize(18);
  fill(255);
  image(xbar.get(30, 0, xbar.width-30, xbar.height), 500, 36);
  image(coin, 444, 36);
  text(str(coNom), 484, 43);
  image(xbar.get(30, 0, xbar.width-30, xbar.height), 670, 36);
  image(dimn, 614, 36);
  text(str(diaNom), 654, 43);
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
    if(overRect(x, y, 216, 162, hive.width, hive.height)){ //beehive
      clicked(hive.get(), 216, 162, hive.width, hive.height, INVERT);
      hiveClick = true;
    }else
    if(overRect(x, y, 550, 131, sign.width, sign.height)){
      clicked(sign.get(), 550, 131, sign.width, sign.height, INVERT);    
    }else
    if(overRect(x, y, 676, 106, shop.width, shop.height)){
      clicked(shop.get(), 676, 106, shop.width, shop.height, INVERT);    
    }else
    if(overRect(x, y, 700, 320, btn_ext.width, btn_ext.height)){
      clicked(btn_ext.get(), 700, 320, btn_ext.width, btn_ext.height, INVERT);    
    }else
    if(overRect(x, y, 640, 320, btn_tip.width, btn_tip.height)){
      clicked(btn_tip.get(), 640, 320, btn_tip.width, btn_tip.height, INVERT);    
    }else
    if(overRect(x, y, 580, 320, btn_set.width, btn_set.height)){
      clicked(btn_set.get(), 580, 320, btn_set.width, btn_set.height, INVERT);    
    }
  }
}

boolean overRect(float x, float y, float x0, float y0, float w, float h){
  if(x0-w/2<x && x<x0+w/2 && y0-h/2<y && y<y0+h/2)return true;
  return false;
}

void clicked(PImage img, float x, float y, float w, float h, int mode){
  img.filter(mode);
  image(img, x, y, w, h);
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
