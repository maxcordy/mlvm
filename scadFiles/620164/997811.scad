//variables
height = 100; // [100:200]
diameter = 24; // [24:50]
hole_diameter = 6; // [0:12] 
hole_depth = 35; // [0:100] 

//calculations
sz= height/100;
sxy= diameter/24;

//model
difference(){
	scale([sxy,sxy,sz]) translate([-13.67549,-13.67549,0]) import("Handle_nohole2.stl");
	cylinder(h=hole_depth,r1=hole_diameter/2,r2=hole_diameter/2,$fn=100);
	cylinder(h=hole_diameter/6,r1=hole_diameter/2/3*4,r2=hole_diameter/2,$fn=100);
}