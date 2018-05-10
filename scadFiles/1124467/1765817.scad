fileName = "2016_Krakov_logo_upraveno.dxf";


//linear_extrude(file = fileName, height=10, layer = "Lines");


union(){

translate([-100,-50,0])linear_extrude(height= 10) import(fileName);

}