//include <BASE.scad>;
//include <Side.scad>;
//include <TOPTOP.scad>;
//include <TOP.scad>;

// import ("Base.stl");
// import ("SIDE.stl");
// import ("TOP.stl");
// import ("TOPTOPTOP.stl");
//Number of Layers in the Pagoda

Number_of_Layers = 4;
TopH = 4.5*1;
SideH = 7.5*1;
BaseH = 3.5*1;

module toper(){
    translate([-41, -1.5, 10.5])
    import("TROP.stl");
}
module side(){
    translate([18,.5,0]){
    import("Sider.stl");
}
}

module tippytop(){
    union(){
    translate([-4.5, -27.5, 0]){
    import("Topish.stl");
        translate([4.5,27.5,13.5]){
    cube([1.5,1.5,8], center = true);
}
}
}
}
Layers = Number_of_Layers - 2;
//TOPTOP(1);
//Top(1);
translate([0,0,-10.5]){
toper();
}
import ("SIDE_fixed.stl"); //Side(1);
for (i = [0:Layers]){
    translate([0,0,(i+1)*(TopH + SideH)]){
    side();
    }
   translate([0,0,(0+i)*(TopH + SideH)]){
       toper();
}
}

translate([0,0,Layers * (TopH + SideH) + 2*(SideH + BaseH)]){
    tippytop();
}