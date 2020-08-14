PImage mapI;

void setup(){
  size(760, 360);
  mapI = loadImage("Untitled.png");
  locked.add(4);
  level.initMap();
}

void draw(){
  image(mapI, pMap.x, pMap.y, 2280, 1080);
  unLocked();
  Level();
  Button();
}

Level level = new Level();
void Level(){
  for(int i=0;i<level.pLev.size();i++){
    PVector tmp = level.pLev.get(i); 
    if(level.solv.get(i)) fill(0, 200, 0);
    else if(i!=0){
      if(!level.solv.get(i-1))fill(160);
      else fill(200, 200, 0);
    }else fill(200, 200, 0);
    ellipse(pMap.x+tmp.x, pMap.y+tmp.y, 30, 30);
  }
}

void Button(){
  fill(100);
  rect(694, 294, 60, 60);
  if(selected!=-1){
    if(selected!=0){
      if(level.solv.get(selected-1))rect(628, 294, 60, 60);  
    }else rect(628, 294, 60, 60);
  }
}

PVector pMap = new PVector(-760, -360);
ArrayList<Integer> locked = new ArrayList<Integer>();
void unLocked(){
  for(TableRow o: level.mapTab.matchRows("0", "lock")){
    int i = o.getInt("box");
    fill(0, 200);
    rect(pMap.x+760*(i%3), pMap.y+360*(i/3), 760, 360);
  }
}

int x = 0, y = 0;
void mouseDragged(){
  int tmpX = abs(mouseX-x);
  if(tmpX>10)x = mouseX;
  if(x<mouseX&&pMap.x<0)pMap.x+=tmpX;
  else if(x>mouseX&&pMap.x+width*2>0)pMap.x-=tmpX;
  x = mouseX;
  
  int tmpY = abs(mouseY-y);
  if(tmpY>10)y = mouseY;
  if(y<mouseY&&pMap.y<0)pMap.y+=tmpY;
  else if(y>mouseY&&pMap.y+height*2>0)pMap.y-=tmpY;
  y = mouseY;
}

int selected = -1;
void mouseClicked(){
  int x = mouseX;
  int y = mouseY;
  if(694<x && 754>x && 294<y && 354>y)exit();
  else if(selected!=-1){
    if(selected!=0){
      if(level.solv.get(selected-1)){
        if(628<x && 688>x && 294<y && 354>y){
          level.solv.set(selected, true);
        }
      } 
    }else {
      if(628<x && 688>x && 294<y && 354>y){
        level.solv.set(selected, true);
      }
    }
    if(level.solv.get(level.solv.size()-1))
      level.openArea();
  }
  for(int i=0;i<level.pLev.size();i++){
    PVector tmp = level.pLev.get(i); 
    if(overObject(30, pMap.x+tmp.x, pMap.y+tmp.y, mouseX, mouseY)){
      fill(255, 0, 0);
      ellipse(pMap.x+tmp.x, pMap.y+tmp.y, 30, 30);
      selected = i;
      break;
    }else selected = -1;
  }
}

boolean overObject(int d, float lx, float ly, float x, float y){
  float disX = lx - x;
  float disY = ly - y;
  if(sqrt(sq(disX)+sq(disY))<d/2)
    return true;
  return false;
}

class Level{
  ArrayList<PVector> pLev = new ArrayList<PVector>();
  ArrayList<Boolean> solv = new ArrayList<Boolean>(); 
  Table mapTab;
  Table levTab;
  
  void initLevel(){
    levTab = loadTable("levelDat.csv", "header");
    for(TableRow o: mapTab.matchRows("1","lock")){
      int lev = o.getInt("id_area");
      addLevel(lev);
    }
  }
  
  void initMap(){
    mapTab = loadTable("mapDat.csv", "header");
    initLevel();
  }
  
  void openArea(){
    int index = (pLev.size()-1)/9+1;
    if(index > 4)return;
    mapTab.setInt(index, "lock", 1);
    addLevel(index+1);
  }
  
  void addLevel(int lev){
    println(lev);
    for(TableRow u: levTab.matchRows(str(lev), "id_area")){
      int x = u.getInt("x");
      int y = u.getInt("y");
      pLev.add(new PVector(x, y));
      boolean s = u.getInt("lock")==0?false:true; 
      solv.add(s);
    }
  }
}
