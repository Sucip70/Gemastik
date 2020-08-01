class Button{
  void Back(int g){
    int w = 100, h = 50, x = 0, y = 0;
    rect(x, y, w, h);
    if(mouseX>=x && mouseX<=x+w &&
       mouseY>=y && mouseY<=y+h &&
       mousePressed&&clicking){
       it = g;
       clicking=false;
    }
  }
  
  void Pressed(int g, int d, int lx, int ly, int x, int y){
    if(mousePressed&&clicking&&overObject(d, lx, ly, x, y)){
      it = g;
      clicking = false;
    }
  }
}

boolean overObject( int d, int lx, int ly, int x, int y){
  float disX = lx - x;
  float disY = ly - y;
  if(sqrt(sq(disX)+sq(disY))<d/2)
    return true;
  return false;
}
