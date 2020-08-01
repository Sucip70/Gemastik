class Journey{
  static final int page = 1;
  Level level = new Level();
  
  void sketch(){
    background(#FFFF00);
    mapImages();
    btn.Back(Menu.page);
    level.pos();
    //if(mousePressed)
    //  println(mouseX+" "+mouseY);
  }
  
  void mapImages(){
    image(mapI, -720, -360, 2160, 1080);
  }
  
}

class Level{
  void pos(){
    for(TableRow row: table.rows()){
      int x = row.getInt("x");
      int y = row.getInt("y");
      int l = row.getInt("level");
      
      design(x, y, l);
      
      int tmp = it;
      btn.Pressed(Game.page, 50, x, y, mouseX, mouseY);
      if(tmp!=it) selectedLevel = l;   
    }
  }
  
  void design(int x, int y, int l){
    fill(#DDFF90);
    ellipse(x, y, 50, 50);
    fill(0);
    textSize(20);
    textAlign(CENTER);
    text(str(l), x-25, y-10, 50, 50); 
  }
}
