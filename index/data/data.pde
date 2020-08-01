void setup(){
  createTable();
}

void createTable(){
  Table table = new Table();  
  table.addColumn("id_user", Table.INT);
  table.addColumn("username", Table.STRING);
  
  
  //for(String o: line){
  //  TableRow row = table.addRow();
    
  //}
  saveTable(table, "user.csv");
}

//user
  //table.addColumn("id_user", Table.INT);
  //table.addColumn("username", Table.STRING);

//data
//  table.addColumn("id_data", Table.INT);
//  table.addColumn("coins", Table.INT);
//  table.addColumn("honey", Table.INT);
//  table.addColumn("id_user", Table.INT);

//map
  //table.addColumn("id_level", Table.INT);
  //table.addColumn("islock", Table.INT);
  //table.addColumn("xPos", Table.INT);
  //table.addColumn("yPos", Table.INT);
  //table.addColumn("score", Table.INT);
  //table.addColumn("id_user", Table.INT);
  
//item
//level
//achiev
