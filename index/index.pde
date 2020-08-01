Button btn = new Button();
Routes route = new Routes();
Table table;
String last = "";

void setup(){
  size(760, 360);
  table = loadTable("data/level.csv", "header");
  //flo.add(new PVector(100, 320));
  loadData();
  frameRate(60);
}

int it = 2;
void draw(){
  //opening animation
  if(getLatest()){
    textAlign(LEFT);
    createUser();
  }else{
    textAlign(CENTER);
    route.update(it);
  }
}

String typed = "";
void createUser(){
  background(#02EDF7);
  fill(255);
  rect(width/2-150, height/2-60, 300, 120);
  rect(width/2-140, height/2, 280, 50);
  fill(0);
  textSize(40);
  text(typed, width/2-133, height/2+40);
  if(keyPressed&&typing){
    if(key==ENTER){
      createNewUser(typed);
      String[] tmp = {typed};
      saveStrings("data/latest.txt", tmp);
      typed = "";
    }else if(key==BACKSPACE){
      typed = typed.substring(0, typed.length()-1);
    }
    else typed+= key;
    typing = false;
  }
}

boolean typing = true;
void keyReleased(){
  typing = true;
}

boolean clicking = true;
void mouseReleased(){
  clicking = true;
}

boolean getLatest(){
  String[] name = loadStrings("data/latest.txt");
  if(name.length==0)
    return true;
  last = name[0];
  return false;
}
