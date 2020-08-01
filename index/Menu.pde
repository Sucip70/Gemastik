

class Menu{
  static final int page = 2;
  Home home = new Home();
  Shop shop = new Shop();
  Teleport tele = new Teleport();
  
  void sketch(){
    background(#36ED2D);
    backgroundImage();
    home.create();
    shop.create();
    tele.create();
  }
  
  void backgroundImage(){
    image(homeI, 0, 0, 760, 360);
  }
}

class Home{
  int x=150, y=200;
  int d = 100;
  color c = #FFB005;
  
  void create(){
    //design();
    btn.Pressed(Room.page, d, x, y, mouseX, mouseY);
  }
  
  void design(){
    fill(c);
    rect(x-d/2, y-d/2, d, d);
    rect(x-d/2-2, y-d/2-2, d+4, 20);
    fill(0);
    arc(x, y, 20, 20, 0, PI);
  }
}

class Shop{
  int x=640, y=120;
  color c = #0000FF;
  int d = 100;
  void create(){
    fill(c, 0);
    ellipse(x, y, d, d);
    btn.Pressed(Menu.page, d, x, y, mouseX, mouseY);
  }
}

class Teleport{
  int x=500, y=120;
  color c = #00FFFF;
  int d = 100;
  void create(){
    fill(c, 0);
    ellipse(x, y, d, d);
    btn.Pressed(Journey.page, d, x, y, mouseX, mouseY);
  }
}
