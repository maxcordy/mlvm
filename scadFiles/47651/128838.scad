$fn = 64*1;

diameter = 20; //[5:50]
height = 2; //[1:25]
number_of_holes = 4; //[1:5]
hole_diameter = 2; //[1:10]
hole_offset = 2; //[0:10]
lip_ratio = 60; //[0:100]
edge_ratio = 90; //[0:100]

main();

module main(){
	difference(){
		cylinder(h = height, r = diameter/2); 
		if (number_of_holes == 1) {
			oneHole();
		} else if (number_of_holes == 2) {
			twoHoles();
		} else if (number_of_holes == 3) {
			threeHoles();
		} else if (number_of_holes == 4){
			fourHoles();
		} else {
			fiveHoles();
		}
		translate(v=[0,0,height*lip_ratio*.01])
		cylinder(h = 25, r = diameter/2*edge_ratio*.01);
	}
}

module oneHole() {
	cylinder(h=25, r = hole_diameter/2);
}

module twoHoles() {
	translate(v=[hole_offset, 0, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-hole_offset, 0, 0])
	cylinder(h = 25, r = hole_diameter/2);	
}

module threeHoles() {
	translate(v=[0, hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[.87*hole_offset, -.5*hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-.87*hole_offset, -.5*hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);	
}

module fourHoles() {
	translate(v=[hole_offset, hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-hole_offset, hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);	
	translate(v=[hole_offset, -hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-hole_offset,-hole_offset,0])
	cylinder(h = 25, r = hole_diameter/2);
}

module fiveHoles() {
	translate(v=[0, hole_offset, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[hole_offset*.95, hole_offset*.31, 0])
	cylinder(h = 25, r = hole_diameter/2);	
	translate(v=[hole_offset*.59, -hole_offset*.81, 0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-hole_offset*.59,-hole_offset*.81,0])
	cylinder(h = 25, r = hole_diameter/2);
	translate(v=[-hole_offset*.95,hole_offset*.31,0])
	cylinder(h = 25, r = hole_diameter/2);
}