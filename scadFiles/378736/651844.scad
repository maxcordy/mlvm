//Parameterised N sided box
// Glyn Cowles July 2014
//Parts to print
parts = "both";//[both,box,lid]
//Thickness of sides
thickness=1;//[1:10] 
//Outside diameter of box
diam=50;//[10:200]   
//Height of box
boxh=25;//[5:150]   
//Height of lid
lidh=10;//[3:20]
//Looseness factor of lid
looseness=10;//[0:20]
//Number of sides
sides=4;//[3:60]

$fn=sides;
loose=looseness/10; // ie looseness = 5 loose =0.5mm

assemble(); 

//-----------------------------------------------------------------------
module tube(d,h,th) {
rad=d/2;
difference() {
cylinder(h=h,r=rad);
cylinder(h=h,r=rad-th);
}
}
//-----------------------------------------------------------------------
module box() {
union(){
	tube(diam,boxh,thickness);
	tube(diam,thickness,diam);
}
}
//-----------------------------------------------------------------------

module lid(){
union() {
	tube(diam+thickness*2+loose,lidh,thickness);
	tube(diam+thickness*2+loose,thickness,diam+thickness*2+loose);
 }
}
//-----------------------------------------------------------------------
module assemble() {
if (parts=="box" || parts=="both")  box(); 
if (parts=="lid" || parts=="both") translate([diam+10,0,0]) lid();
};



