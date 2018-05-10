fileName = "2016_Krakov_logo_upraveno.dxf";


//linear_extrude(file = fileName, height=10, layer = "Lines");
difference()
{

union(){
translate([60,0,0])cube([100,50,1],center);
translate([0,-20,0])cube([160,20,1],center);
translate([-100,-50,0])linear_extrude(height= 3) import(fileName);

}
translate([70,0,0])cylinder([7,5,center]);
translate([155,45,0])cylinder([7,5,center]);
translate([25,-10,0])cylinder([7,5,center]);
}

