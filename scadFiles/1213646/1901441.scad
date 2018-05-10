// Box builder with angled sliding lid.
// Has potential recess for label and fingernail grip to open.


// preview[view:north west, tilt:top diagonal]

// Width of Box
Box_x = 43;
// Length of Box
Box_y = 43;
// Height of Box
Box_z = 22; 
Wall_thickness = 2;  //[2:0.5:10]
Floor_thickness = 1;
Lid_thickness = 2;   //[2:0.5:10]
// Add inset for a Label
Lid_inset = "yes"; // [yes,no]
// Fingernail recess to ease opening lid
Grip_recess = "yes"; // [yes,no]

// Amount of play in the lid to fit well.
Looseness = 0.2;  //[0:0.1:1]
//
Show_assembled = "no"; // [yes,no]

/* [Hidden] */
//Lid scale (effective overhang)
lid_scale = 0.97;
fingernail_width = 0.5;

Delta = 0.1;     // to get good overlaps for real objects
roundness = 32;  // for curve res.
epsilon = 0.001; // for minkowski lid height :(

// Lid
module lid(extra_x=Looseness, extra_z=Delta) {
	translate([0,Wall_thickness/2+Delta,-Lid_thickness/2-epsilon/2])
	linear_extrude(height=Lid_thickness+extra_z*2, scale=[lid_scale,1])
		square(size=[Box_x+extra_x*2,Box_y], center=true);
}

// undercut ridge on top of box to hold lid
module lid_ridge(x,y) {
	difference() {
		// the surround
		minkowski(){
			cube(size=[x,y,Lid_thickness], center=true);
			cylinder(h=epsilon, r=Wall_thickness, $fn=roundness); // increases lid height by 2*epsilon
		}
		// minus the lid
		lid(Looseness, epsilon);
	}
}

// helper hole to open lid.
module fingernail_helper() {
	cube(size=[Box_x/3, fingernail_width,Lid_thickness/2], center=true);
}


// box
module box() {
	x = Box_x-Wall_thickness;
	y = Box_y-Wall_thickness;
	linear_extrude(height=Box_z-Lid_thickness, convexity=4)
	difference() {
		offset(r=Wall_thickness, $fn=roundness) 
			square(size=[x, y], center=true);
		square(size=[x, y], center=true);
	}
	// floor
	translate([0,0,Floor_thickness/2])
		cube(size=[x+Delta, y+Delta,Floor_thickness],center=true);
	// Top ridge of lid
	translate([0,0,Box_z-Lid_thickness/2])
		lid_ridge(x,y);
}


//-------------------
// Build the box
box();
// Build the Lid
tz = (Show_assembled == "yes") ? Box_z-Lid_thickness/2 : Lid_thickness/2;
tx = (Show_assembled == "no") ? Box_x+Wall_thickness  : 0;
ty = (Show_assembled == "yes") ? Box_y/3  : 0;
lid_color = (Show_assembled == "yes") ? [0.7,0.7,0] : 0;
color(lid_color)
translate([tx,ty,tz])
	difference() {
		lid(0,0);
		// subtract fingernail recess
		if (Grip_recess=="yes") {
			translate([0,-Box_y/2.7,Lid_thickness/3])
				fingernail_helper();
		}
		// subtract inset
		if (Lid_inset=="yes") {
			translate([0,0,Lid_thickness/2])
				cube(size=[Box_x/2, Box_y/2,Lid_thickness/4], center=true);
		}
	}
