PImage a, b, c;
PImage aa, keep, tmpKeep;
ArrayList<barData> userBar = new ArrayList<barData>();

void setup(){
  size(760, 360);
  a = loadImage("Untitled.png");
  c = loadImage("beehive.png");
  b = loadImage("Untitled2.png");
  addData();
  aa = b.get(27, 89, 758, 287);
  tmpKeep = keep = b.get(869, 306, 130, 130);
}

void addData(){
  userBar.add(new barData("1111111", b.get()));
  userBar.add(new barData("222111", b.get()));
  userBar.add(new barData("11333111", b.get()));
  userBar.add(new barData("11114411", b.get()));
  userBar.add(new barData("155511", b.get()));
  userBar.add(new barData("11666111", b.get()));
  userBar.add(new barData("177711", b.get()));
  userBar.add(new barData("1888111", b.get()));
  userBar.add(new barData("999111", b.get()));
}

void draw(){
  textAlign(LEFT);
  textSize(26);
  image(c, 0, 0, 760, 360);
  image(aa, width/2-192, 132, 384, 143.5);
  addBar();
  image(a, width/2-240, 0, 480, 360);
  displaySelection();
  keepUser();
  button();
}

void button(){
  btnAdd();
  btnPlaySelected();
  btnExit();
  if(input)textField();
}

void btnAdd(){
  fill(255, 255, 0);
  rect(438, 280, 40, 40);
}

void btnPlaySelected(){
  fill(0, 255, 0);
  rect(481, 280, 40, 40);
}

void btnExit(){
  fill(255, 0, 0);
  rect(524, 280, 40, 40);
}

boolean input = false;
String textInput = "jdscbi";
int inputStatus = -1;
void textField(){
  fill(0, 100);
  rect(0, 0, 760, 360);
  fill(255);
  rect(width/2-100, height/2-15, 200, 30);
  textSize(20);
  fill(0);
  text(textInput, width/2-90, height/2+7);
  float tw = textWidth(textInput)+width/2-90;
  if(frameCount/7%2==0)
    line(tw, height/2-10, tw, height/2+10);
}

void keyPressed(){
  if(input){
    if(keyCode==BACKSPACE){
      if(textInput.length()!=0)
        textInput = textInput.substring(0, textInput.length()-1);
    }
    else if(keyCode==ENTER){
      if(textInput.length()!=0){
        if(inputStatus==-1){
          userBar.add(new barData(textInput, b.get()));
        }else{
          userBar.set(inputStatus, new barData(textInput, b.get()));
        }
      }  
      textInput = "";
      input = false;
    }
    else if(textInput.length()<8)textInput+=key;
  }
}

boolean isKeep = false;
void keepUser(){
  textAlign(LEFT);
  image(keep, 200, 290, 65, 65);
  textSize(11);
  fill(0);
  text("keep login with this account", 227, 306);
  for(barData o: userBar)
    if(o.selected)return;
  keep = tmpKeep.get();
}

void displaySelection(){
  textAlign(CENTER);
  textSize(36);
  for(barData o: userBar){
    if(o.selected)
      text(o.nama, width/2, 93);
  }
}

void addBar(){
  int i=0;
  for(barData o: userBar){
    float posY = scroll.y+i*51;
    i++;
    if(posY>290||posY<70)continue;
    image(o.barImage, scroll.x, posY, 384, 50);   
    fill(0);
    text(o.nama, scroll.x+50, posY+10, 284, 50);
    image(o.emblem, scroll.x+4.75, posY+4.75, 40.5, 40.5);
    deleteUser(posY, i);
  }
}

void deleteUser(float posY, int i){
  fill(255, 0, 0);
  float x = scroll.x+345;
  float y = posY+10;
  rect(x, y, 30, 30);
}

PVector scroll = new PVector(188, 132);
int direction = 0;
void mouseDragged(){
  if(input)return;
  if(mouseY<direction&&275.5<scroll.y+51*(userBar.size()))scroll.y-=2;
  else if(mouseY>direction&&scroll.y<132)scroll.y+=2;
  direction = mouseY;
}

void mouseClicked(){
  float x = mouseX;
  float y = mouseY;
  if(input){
    if(width/2-100<x && width/2+100>x && height/2-15<y && height/2+15>y){
    }else input = false;
  }else if(x>188 && y>132 && x<572 && y<275.5){ //bar selection
    for(int i=0;i<userBar.size();i++){
      float posY = scroll.y+i*51;
      if(scroll.x<x && scroll.x+384>x && posY<y && posY+50>y){
        clearSelection();
        userBar.get(i).selected = true;
        userBar.get(i).select();
      }
      if(scroll.x+345<x && scroll.x+375>x && posY+10<y && posY+40>y)
        userBar.remove(i);
    }
  }
  else if(200<x && 265>x && 290<y && 355>y) //keep account
    if(!isKeep)keep.filter(INVERT);
    else keep.filter(INVERT, 0);
  else if(250<x && 510>x && 50<y && 105>y){
    for(int i=0;i<userBar.size();i++){
      if(userBar.get(i).selected==true){
        textInput = userBar.get(i).nama;
        inputStatus = i;
        input = true;
        break;
      }
    }
  }
  else if(438<x && 478>x && 280<y && 320>y)input=true;
  else if(481<x && 521>x && 280<y && 320>y); //play
  else if(524<x && 564>x && 280<y && 320>y); //exit/cancel
}

void clearSelection(){
  for(int i=0;i<userBar.size();i++){
    userBar.get(i).selected = false;
    userBar.get(i).select();
  }
}

class barData{
  String nama;
  PImage barImage, tmpBar, emblem;
  boolean selected = false;
  
  barData(String n, PImage b){
    nama = n;
    barImage = tmpBar = b.get(28, 386, 757, 100);
    emblem = b.get(798, 97, 81, 81);
  }
  
  void select(){
    if(selected)barImage.filter(INVERT);
    else barImage = tmpBar.get();
  }
}
