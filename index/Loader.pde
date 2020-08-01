Table user, data;
PImage mapI, homeI;

void loadData(){
  user = loadTable("data/user.csv", "header");
  //if(user.getRowCount()==0)
  //  return;  
  loadImages();
}

void loadImages(){
  mapI = loadImage("assets/images/map/map_paint.png");
  homeI = loadImage("assets/images/home.png");
}


void loadUser(int id_data){
  Table tmp = loadTable("data/user.csv", "header");
  data = tmp;
  data.clearRows();
  for (TableRow row : tmp.matchRows(str(id_data), "id_data")) {
    data.addRow(row);
  }
}

void createNewUser(String name){
  int lastId = 0;
  int n = user.getRowCount();
  if(n!=0)
    lastId = user.getInt(n-1, "id_user");
  TableRow tmp = user.addRow();
  tmp.setInt("id_user", ++lastId);
  tmp.setString("username", name);
  saveTable(user, "data/user.csv");
}
