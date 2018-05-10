// Printout a wedge or Riser for Skateboard trucks.
// Choose New and or Old School hole spacing.
// Neon22 at Thingiverse CC-BY-SA
// - 

// Settings:
// height is based on the inner truck mounting hole.
// Can show height of axle if the X,Y offset from base and the inner truck hole are known.

// This dovetails with the inkscape extension to build Skateboards and Longboards.
// - 
// Also the other thingiverse file to build a Drill guide for drilling trucks
// - 


// Truck Bolt Sizes:
//  - Truck bolts traditionally 3/16". So hole min is 3/16" = 4.7625mm
//    holes go up to 13/64 (5.16mm) for looser and 7/32 (5.56mm)for very loose.
//  - in Metric countries M5 is usual replacement.


// preview[view:north east, tilt:top diagonal]

/* [Parameters] */
// Holes. 3/16in=4.76mm
Hole_dia = 5.0;   // [2:0.1:6]
// Double is most flexible
Hole_pattern = "Double"; //["Double", "New and Old", "New", "Old"]

// Border factors in mm
Border_width = 6;  //[3:10]
// Corner rounding
Rounding = 4;      //[2:20]
// Height at Truck's inner mounting hole
Height_inner_mounthole = 6; //[4:50]
// Angle of Wedge
Wedge_angle = 5;  //[-35:0.5:35]
// Density
Weight = "Braced";  // [Solid, Lightweight,Braced]

/* [Optional Info] */
//Show Axle height and Bolt lengths. (All in mm)
Show_more = true; //[true, false]
// X Distance from inner mount hole to axle. (Calc axle height)
Axle_offset = 25;  // [5:58]
// Axle height above base of Truck. (Calc axle height)
Axle_height = 67;  // [20:100]
// Deck thickness. (Calc Bolt lengths)
Deck_thickness = 12; //[6:0.5:22]
// Truck thickness. (Calc Bolt lengths)
Truck_thickness = 3; //[0:0.5:5]

/* [Hidden] */
Truck_width = 41.28;  // in mm
New_school = 53.98;
Old_school = 63.5;

// Global helpers
thin = 0.001;
Delta = 0.1;
cyl_res = 80;

// calculated
overall_length = Old_school + Rounding + Border_width*2;
overall_width = Truck_width + Rounding + Border_width*2;
height_oldschool = Height_inner_mounthole + Old_school*sin(Wedge_angle);
too_steep = Height_inner_mounthole - (Rounding + Border_width)*sin(Wedge_angle);
too_negative = Height_inner_mounthole + overall_length*sin(Wedge_angle);
a_height = Axle_height + Axle_offset*sin(Wedge_angle);
bolt_length = height_oldschool + Deck_thickness + Truck_thickness + 5;


//--------------------------
// Modules

// The shape of the base plate (rounded rect)
module rounded_plate(width, length, rounding) {
	linear_extrude(height=thin) {
		minkowski() {
			circle(d=rounding, $fn=cyl_res);
			square(size=[width, length]);
		}
	}
}

// The Bordered Wedge shape
module border()  {
	b_width = Truck_width+Border_width*2;
	b_length = Old_school+Border_width*2;
	hull() {
		translate([-Border_width,-Border_width,0])
			rounded_plate(b_width, b_length, Rounding);
		translate([0,-Height_inner_mounthole*sin(Wedge_angle/2),Height_inner_mounthole*cos(Wedge_angle/2)]) // lift up
		rotate([Wedge_angle,0,0])
			translate([-Border_width,-Border_width,0]) // rotate around hole center
			rounded_plate(b_width, b_length, Rounding);
	}
}


// Single angled hole
module hole(my_height) {
	rotate([Wedge_angle/2,0,0])
	translate([0,0,-Hole_dia]) // drop it for clearance
		cylinder(h=my_height, d=Hole_dia, $fn=cyl_res);
}

// Place holes referenced from 0,0
module holes() {
	base_height = (Height_inner_mounthole+Hole_dia)*2.1;  // nice clean hole
	translate([0,0,-Delta]) {
		hole(base_height+Hole_dia*sin(Wedge_angle)); 
		translate([Truck_width, 0,0]) hole(base_height+Hole_dia*sin(Wedge_angle));
		// New ?
		if (Hole_pattern != "Old"){
			translate([0,New_school,0]) hole(base_height+New_school*sin(Wedge_angle));
			translate([Truck_width, New_school,0]) hole(base_height+New_school*sin(Wedge_angle));
		}
		// Old ?
		if (Hole_pattern != "New"){
			translate([0,Old_school,0]) hole(base_height+Old_school*sin(Wedge_angle));
			translate([Truck_width, Old_school,0]) hole(base_height+Old_school*sin(Wedge_angle));
		}
		// Double ?
		if (Hole_pattern == "Double")  {
			dist = (Old_school - New_school)*sin(Wedge_angle) + base_height;
			translate([0,Old_school - New_school,0]) hole(dist);
			translate([Truck_width, Old_school - New_school,0]) hole(dist);
		}
	}
}

// Indented to display Wedge Angle
module label() {
	depth = 2.5;
	font_height = 3;
	slide_along = font_height*2.8;
	slide_up = font_height/2.5;
	translate([-Border_width-Rounding/2-depth*0.75,slide_along,slide_up]) // on the surface
	rotate([90,0,90])
		linear_extrude(height=depth, convexity=4)
		rotate([0,180,0])
		text(str(Wedge_angle," deg"), font_height);
}

// Thin out the interior
module density() {
	b_height_y = Old_school*sin(Wedge_angle/2);
	b_height_z = Old_school*cos(Wedge_angle/2);
	b_width = Truck_width-Border_width*2-Hole_dia-Rounding;
	hull() {
		translate([Border_width+Hole_dia/2+Rounding/2,Border_width,-Delta])
			rounded_plate(b_width, Old_school-Border_width*2, Rounding/2);
		translate([Border_width+Hole_dia/2+Rounding/2, -b_height_y, b_height_z])
		rotate([Wedge_angle,0,0])
			rounded_plate(b_width, Old_school-Border_width*2, Rounding/2);
	}
}

// Add Cross-bracing
module bracing() {
	// draw two cross braces
	b_height = min(Height_inner_mounthole, height_oldschool);
	b_thick = 3;
	translate([Truck_width/2,Old_school/2,b_height/2]) {
		rotate([0,0,60])
			cube(size=[Truck_width*1.5, b_thick,b_height],center=true);
		rotate([0,0,-60])
			cube(size=[Truck_width*1.5, b_thick,b_height],center=true);
	}
}

module notations() {
	// Errors,Warnings
	if (too_negative < 0) {
		color("Red")
		translate([-20,80,0])
			text("Increase height when angle is negative",6);
	}
	if (too_steep <=0) {
		color("Red")
		translate([-20,80,0])
			text("Angle too steep for height. Increase height.",6);
	}
	// Information
	color("Cyan") {
		translate([-(Border_width+Rounding)*3,0,0])
		rotate([0,0,90])
			text(str("Width = ",overall_width,"mm (",overall_width/25.4,"in)"),4);
		translate([-(Border_width+Rounding)*3-10,0,0])
		rotate([0,0,90])
			text(str("Length = ",overall_length,"mm (",overall_length/25.4,"in)"),4);
		// hole heights
		translate([(Border_width+Rounding)*2+Truck_width,0,0])
		rotate([0,0,0])
			text(str("Bolt + ",Height_inner_mounthole,"mm (",Height_inner_mounthole/25.4,"in)"),4);
		translate([(Border_width+Rounding)*2+Truck_width,Old_school,0])
		rotate([0,0,0])
			text(str("Bolt + ",height_oldschool,"mm (",height_oldschool/25.4,"in)"),4);
	}
	// Axle information
	if (Show_more) {
		color("Green")
		translate([(Border_width+Rounding)*2+Truck_width,Axle_offset,0])
		rotate([0,0,0])
			text(str("Axle Height = ",a_height,"mm (",a_height/25.4,"in)"),4);
		//
		color("Green")
		translate([-(Border_width+Rounding)*3-20,0,0])
		rotate([0,0,90])
			text(str("Max Bolt = ",bolt_length,"mm (",bolt_length/25.4,"in)"),4);
	}
}

// show some customisation ?
module decoration() {
	
}

// main
module Wedge () {
	difference() {
		border();
		holes();
		if (Wedge_angle != 0) label();
		if (Weight != "Solid") {
			density();
		}
	}
	decoration();
	if (Weight == "Braced") bracing();

}


Wedge();
%notations(); // show in display but not printed
