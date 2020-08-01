class Routes{
  Game _0 = new Game();
  Journey _1 = new Journey();
  Menu _2 = new Menu();
  Room _3 = new Room();
  
  void update(int x){
    switch(x){
      case 0:_0.sketch();break;
      case 1:_1.sketch();break;
      case 2:_2.sketch();break;
      case 3:_3.sketch();break;
      default:break;
    }
  }
}
