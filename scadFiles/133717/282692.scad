//--------------------------------------------------------------------------------------------------
//	HuPO Take-off
//	http://www.thingiverse.com/thing:133717
//	http://thingiverse.com/Benjamin
//
//   Thanks to Greg Frost for his Involute Gears library
//   http://www.thingiverse.com/thing:3575
//--------------------------------------------------------------------------------------------------

// Piece to print or assembly
output="assembly";//[assembly,crank,pto,gear,top,pto_female,jig,face,simple_face,bi_face,reduction]

rod_dia = 8;
// mm of plastic around rod
rod_margin = 5;

/* [Crank] */
//One or two arcs on handle
crank_type = "double"; //[double, single]
//percent of full radius for arc(s) on handle
crank_bulge = 38;//[0:100]
crank_spacing = 150;
crank_thickness = 12;
crank_A_dia = 32;
crank_B_dia = 26;
crank_rod_dia_A = 8;
crank_rod_dia_B = 8;
crank_nut_A = 13;
crank_nut_B = 13;
crank_nut_thickness_A = 6.5;
crank_nut_thickness_B = 6.5;
crank_nut_clearance = 0.25;
crank_precision = 24;
crank_min_ratio = 0.618;

/* [Pto] */
pto_teeth_nb = 6;//[5:9]
pto_height = 36;
pto_dia_max = 24;
pto_dia_min = 16;
pto_tooth_width = 6;
pto_tooth_rounding = 2.5;
pto_bevel_height = 3;
pto_margin = 2.5;
pto_teardrop = "yes";//[yes,no]
pto_hub_dia = 36;
pto_hub_height = 22;
pto_hub_rounding = 5;
pto_hole_width = 13.4;
pto_hole_thickness = 7.2;
pto_keyway_dia = 6;
pto_keyway_from_hub = 18;
pto_base_segment = 36;
// ratio
pto_female_width = 1.15;
// ratio
pto_female_dia = 1.075;

/* [Box] */
face_rod_spacing = 32;
face_height = 64;
face_thickness = 32;
face_teardrop = "yes";//[yes,no]
simple_face_thickness = 24;
top_thickness = 24;
top_rod_spacing = 90;
top_rod_holder_height = 12; 
biface_thickness = 30;

/* [Other] */
clearance = 0.25;
// number of segments to draw a circle
precision = 24;
// outer diameter
bearing_od = 22.4;
// inner diameter
bearing_id = 15;
bearing_thickness = 7;
// mm of plastic around bearing
bearing_margin = 4;
print_bed_visible = "no";//[yes,no]
print_bed_width = 200;
print_bed_height = 200;

/* [Jig] */
jig_thickness = 15;
jig_margin = 3;
jig_around_hole = 3;
jig_drill_dia = 3.4;

/* [Reduction] */
gear_teeth_A = 13;
gear_teeth_B = 31;
gear_circular_pitch = 375;

gear_thickness_A = 12;
gear_thickness_B = 10;
//-----------------------------------------------------------

module void(){}
preview_tab = "";
pi = 3.1415926535897932384626433832795*1;

pto_tooth_depth = (pto_dia_max - pto_dia_min)/2;
c_bulge = max((crank_spacing/2)*crank_bulge/100, 0.1);
//-----------------------------------------------------------
gear_pitch_A = (gear_teeth_A * gear_circular_pitch / 180)/2;
gear_pitch_B = (gear_teeth_B * gear_circular_pitch / 180)/2;
dist_AB = gear_pitch_A + gear_pitch_B;
reduc_spacing = dist_AB;
//-------------------------------------------------------------------------------
module test_gears() {	
	rotate([90, 0, 0])
	gear_A();
	rotate([90, 0, 0])
	translate ([-dist_AB,0,0])
	gear_B();
}
//-------------------------------------------------------------------------------
module gear_A() {
difference() {
	gear (number_of_teeth=gear_teeth_A,
		circular_pitch=gear_circular_pitch,
		gear_thickness=gear_thickness_A,
		rim_thickness=gear_thickness_A,
		rim_width=5,
		hub_thickness=gear_thickness_A,
		hub_diameter = rod_dia + rod_margin*2,
		bore_diameter=rod_dia + clearance,
		backlash=0.25,
		circles=0);	

	translate([0, 0, gear_thickness_A - crank_nut_thickness_A + 0.5])
	crank_nut(crank_nut_A, crank_nut_thickness_A);
}	
}
//-------------------------------------------------------------------------------
module gear_B() {
difference() {
	gear (number_of_teeth=gear_teeth_B,
		circular_pitch=gear_circular_pitch,
		gear_thickness=0.67*gear_thickness_B,
		rim_thickness=gear_thickness_B,
		rim_width=3,
		hub_thickness=gear_thickness_B,
		hub_diameter = crank_nut_A + rod_margin*2,
		bore_diameter=rod_dia + clearance,
		circles=6,
		backlash=0.25);

	translate([0, 0, gear_thickness_B - crank_nut_thickness_A + 0.5])
	crank_nut(crank_nut_A, crank_nut_thickness_A);
}
}

//-------------------------------------------------------------------------------
if (output=="assembly" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")) {
translate([0, 0, face_height/2]) {
		*translate([0, top_rod_spacing/2 +face_thickness/2, 0])
		simple_face();

		translate([0, top_rod_spacing/2, 0])
		bi_face();

		translate([0, -top_rod_spacing/2 -face_thickness/2, 0])
		rotate([0, 0, 180])
		simple_face();

		translate([0, 0, face_height/2])
		top();
	
		translate([0, 0, -0.01])
		rotate([0, 0, 90])
		%bevel_gear_pair ();
	
		translate([0, top_rod_spacing/2 +face_thickness/2 + 30, 0])
		rotate([-90, 0, 0])
		translate([crank_spacing/2 + dist_AB, 0, 0])
		crank(arc=crank_type);

		translate([0, top_rod_spacing/2 + biface_thickness , 0])
		rotate([0, 0, 180])
		test_gears();
	
		translate([0, 0, pto_height/2 + pto_hub_height + face_height/2 + top_thickness + 12])
		pto(pto_height, pto_tooth_width, pto_dia_max, true);
	
		//translate([0, 0, pto_height/2 + pto_hub_height + face_height/2 + top_thickness + 12 + 12 + 36])
		//pto_female();
		
		translate([0, 0, 0])
		rotate([90, 0, 0])
		color("lightgrey")
		cylinder(r = rod_dia/2, h = top_rod_spacing+face_thickness , $fn=precision, center=true);
	
		translate([0, 0, face_height/2 + top_thickness + pto_hub_height/2])
		rotate([0, 0, 0])
		color("lightgrey")
		cylinder(r = rod_dia/2, h = top_rod_spacing+face_thickness , $fn=precision, center=true);
	}
}
//-------------------------------------------------------------------------------
if (preview_tab == "Crank") {
	rotate([0, 0, 45])	crank(arc=crank_type);
} else if (preview_tab == "Pto") {
	translate([0, 0, pto_height/2 + pto_hub_height])
	pto(pto_height, pto_tooth_width, pto_dia_max, true);
} else if (preview_tab == "Jig") {
	jig();
} else if (preview_tab == "Reduction") {
	reduction();
} else if (preview_tab == "Box") {
	translate([0, top_rod_spacing/2 +face_thickness/2, 0])
	simple_face();
	translate([0, -top_rod_spacing/2 -face_thickness/2, 0])
	rotate([0, 0, 180])
	simple_face();
	translate([0, 0, face_height/2])
	top();
} 
//-------------------------------------------------------------------------------

if(output == "crank" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")) {	rotate([0, 0, 45])	crank(arc=crank_type);}
if(output == "top" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")) {	top();}
if(output == "face" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")){	translate([0, face_thickness/2, face_height/2])	face();}
if(output == "simple_face" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")){	translate([0, face_thickness/2, face_height/2])	simple_face();}
if(output == "bi_face" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")) {
	translate([0, 0, rod_dia/2 + rod_margin])
	rotate([90, 0, 0])
	bi_face();
}

if(output == "reduction" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")) {
	reduction();
}
if(output == "gear" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")) 	{	hpto_gear();}
if(output == "jig" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")) 	{	jig();}
if(output == "pto" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")) 	{
	translate([0, 0, pto_height/2 + pto_hub_height])
	pto(pto_height, pto_tooth_width, pto_dia_max, true);
}
if (output == "pto_female" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")) {
	translate([0, 0, pto_height/2 + pto_bevel_height/2 + clearance])
	pto_female();
}
if (output == "connect" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")) { connect(); }

if (output == "plate" && (preview_tab=="Parameters"||preview_tab=="Other"||preview_tab=="")) {
	rotate([0, 0, 45])
	crank(arc=crank_type);

	translate([-0.25*crank_spacing/sqrt(2), 0.5*crank_spacing/sqrt(2), 0])
	rotate([0, 0, 90])
	top();
	
	translate([0.5*crank_spacing/sqrt(2), -0.5*crank_spacing/sqrt(2) + face_rod_spacing/2, face_height/2])
	rotate([0, 0, 90])
	simple_face();

	translate([0.5*crank_spacing/sqrt(2) - face_thickness, -0.5*crank_spacing/sqrt(2) + face_rod_spacing/2, face_height/2])
	rotate([0, 0, 90])
	simple_face();
	
	translate([0, - 1.5*face_thickness, pto_height/2 + pto_hub_height])
	pto(pto_height, pto_tooth_width, pto_dia_max, true);

	//hpto_gear();
}
//-------------------------------------------------------------------------------
module reduction() {
	//translate([0, biface_thickness , 0])
	//rotate([0, 0, 180])
	//test_gears();

	translate([-dist_AB/2 - 2, 0, 0])
	gear_A();
	translate([dist_AB/2 + 2, 0, 0])
	gear_B();
}
//-------------------------------------------------------------------------------
module pto (tooth_height = 36, tooth_width = 6, dia_max = 32, keyway=true) {
difference() {
	union() {
		pto_shaft(tooth_height, tooth_width, dia_max, keyway);
	
		translate([0, 0, -tooth_height/2 + -pto_hub_height/2 -pto_hub_rounding/4 ])
		cylinder(r=pto_hub_dia/2, h=pto_hub_height - pto_hub_rounding/2, $fn=precision, center=true);
	
		translate([0, 0, -tooth_height/2 -pto_hub_rounding/4])
		cylinder(r=(pto_hub_dia-pto_hub_rounding)/2, h=pto_hub_rounding/2+0.01, $fn=precision, center=true);
	
		translate([0, 0, -tooth_height/2 -pto_hub_rounding/2])
		rotate_extrude(convexity = 10, $fn = precision)
		translate([pto_hub_dia/2 - pto_hub_rounding/2, 0, 0])
		rotate([0, 0, 90])
		circle(r = pto_hub_rounding/2, $fn = precision);
	} //union

	translate([0, 0, -pto_hub_height/2])
	cylinder (r=(rod_dia+clearance)/2, h = 1.5*(pto_height+pto_hub_height), $fn=precision, center=true);

	if (pto_teardrop == "yes") {
	translate([-30, 0, -tooth_height/2 -pto_hub_height/2])
	rotate([0, 90, 0])
	hull () {
		cylinder (r=(rod_dia+clearance)/2, h = 60, $fn=precision, center=true);
		translate([-sqrt(2)*(rod_dia-1.5)/2, 0, 0])
		cube([1.5, 1.5, 60], center=true);
		//cylinder (r=0.5, h = 60, $fn=8, center=true);
	}

	} else if (pto_teardrop == "no") {
		translate([-30, 0, -tooth_height/2 -pto_hub_height/2])
		rotate([0, 90, 0])
		cylinder (r=(rod_dia+clearance)/2, h = 60, $fn=precision, center=true);
	}

	rotate([0, 0, 180])
	translate([1.1*pto_hub_dia/4, 0, -tooth_height/2 -pto_hub_height/2 -(pto_hole_width/2)*(1/cos(30) - tan(30)) -1]) {
		cube ([pto_hole_thickness, pto_hole_width, pto_hub_height], center=true);
		
		translate ([0, 0, pto_hub_height/2 - sin(30)*pto_hole_width/2/cos(30)])
		rotate ([0, 90, 0])
		cylinder (r=pto_hole_width/2/cos(30), h = pto_hole_thickness, $fn= 6, center=true );
	}// translate
	}// difference
}
//-------------------------------------------------------------------------------
module pto_shaft(tooth_height=36, tooth_width = 6, dia_max = 32, keyway = true) {
difference() {
	union() {
		cylinder(r=pto_dia_min/2, h=tooth_height, $fn=precision, center=true);

		for (i=[0:pto_teeth_nb-1]) {
			pto_tooth(i, pto_teeth_nb, tooth_height, tooth_width, dia_max);
		}

		intersection() {
			translate([0, 0, tooth_height/2 +pto_bevel_height/2])
			cylinder(r1=dia_max/2, r2=pto_dia_min/2,  h=pto_bevel_height, $fn=precision, center=true);
			translate([0, 0, tooth_height/2 +pto_bevel_height/2])
			for (i=[0:pto_teeth_nb-1]) {
			pto_tooth(i, pto_teeth_nb, pto_bevel_height*1.2, tooth_width, dia_max);
		}
		}

	} //union

	if (keyway == true) {
		translate([0, 0, -tooth_height/2 + pto_keyway_from_hub])
		rotate_extrude(convexity = 10, $fn = precision)
		translate([dia_max/2, 0, 0])
		rotate([0, 0, 90])
		circle(r = (dia_max-pto_dia_min+0.1)/2/cos(30), $fn = 6);
	}
	}// difference
}
//-------------------------------------------------------------------------------
module pto_tooth(num, nb, height, width, dia_max) {
rotate([0, 0, num*(360/nb)]) {
	translate([0, dia_max/4, 0])
	cube([width - pto_tooth_rounding, dia_max/2, height], center=true);
	
	translate([width/2  -pto_tooth_rounding/2, dia_max/2 - pto_tooth_rounding/2, 0])
	cylinder(r=pto_tooth_rounding/2, h=height, $fn=12, center=true);
	translate([-width/2  +pto_tooth_rounding/2, dia_max/2 - pto_tooth_rounding/2, 0])
	cylinder(r=pto_tooth_rounding/2, h=height, $fn=12, center=true);
	
	translate([-width/2  +pto_tooth_rounding/2, +(dia_max - pto_tooth_rounding)/4, 0])
	cube([pto_tooth_rounding, (dia_max - pto_tooth_rounding)/2, height], center=true);
	translate([+width/2  -pto_tooth_rounding/2, +(dia_max - pto_tooth_rounding)/4, 0])
	cube([pto_tooth_rounding, (dia_max - pto_tooth_rounding)/2, height], center=true);
	
	translate([-width/2, +dia_max/2 - pto_tooth_depth - pto_tooth_rounding/sqrt(2), 0])
	rotate([0, 0, 45])
	cube([width, pto_tooth_rounding, height], center=true);
	
	translate([width/2, +dia_max/2 - pto_tooth_depth - pto_tooth_rounding/sqrt(2), 0])
	rotate([0, 0, -45])
	cube([width, pto_tooth_rounding, height], center=true);	
} //rotate
}
//-------------------------------------------------------------------------------
module pto_female () {
	difference() {
		cylinder(r=pto_hub_dia/2, h=pto_height + pto_bevel_height + 2*clearance, $fn=24, center=true);

		pto(1.2*(pto_height + pto_bevel_height), pto_tooth_width*pto_female_width, pto_dia_max*pto_female_dia, false);

		cylinder(r = 1.1*rod_dia/2, h = 1.2*(pto_height + pto_bevel_height) , $fn=precision, center=true);

		translate([pto_dia_max/2, 0, pto_keyway_from_hub -(pto_height + pto_bevel_height + 2*clearance)/2])
		rotate([90, 0, 0])
		scale([0.8, 1.2, 1])
		cylinder(r=0.8*(pto_keyway_dia)/2, h=1.2*(max(pto_dia_max,pto_hub_dia)), center=true, $fn=precision);
	}
}
//-------------------------------------------------------------------------------
module top() {
	translate([0, 0, top_thickness])
	difference() {	
		union() {
			translate([0, 0, -top_rod_holder_height/2 -top_thickness + top_rod_holder_height])
			hull() {
				translate([-face_rod_spacing/2, -top_rod_spacing/2, 0])
				cylinder(r=(rod_dia)/2+rod_margin, h=top_rod_holder_height, center=true, $fn=precision);
				translate([face_rod_spacing/2, top_rod_spacing/2, 0])
				cylinder(r=(rod_dia)/2+rod_margin, h=top_rod_holder_height, center=true, $fn=precision);
			}

			translate([0, 0, -top_rod_holder_height/2 -top_thickness + top_rod_holder_height])
			hull() {
				translate([face_rod_spacing/2, -top_rod_spacing/2,0])
				cylinder(r=(rod_dia)/2+rod_margin, h=top_rod_holder_height, center=true, $fn=precision);
				translate([-face_rod_spacing/2, +top_rod_spacing/2, 0])
				cylinder(r=(rod_dia)/2+rod_margin, h=top_rod_holder_height, center=true, $fn=precision);
			}

			translate([0, 0, -top_thickness/2])
			cylinder(r=bearing_od/2+bearing_margin, h=top_thickness, center=true, $fn=precision);

			translate([0, 0, -top_thickness/2])
			*cube([face_rod_spacing, top_rod_spacing, top_thickness], center=true);

			translate([0, 0, -top_rod_holder_height/2 -top_thickness + top_rod_holder_height])
			hull() {
				translate([-face_rod_spacing/2,-top_rod_spacing/2, 0.25*top_rod_holder_height/2])
				cylinder(r=rod_margin/2, h=1, center=true, $fn=precision);
				translate([0, 0, top_rod_holder_height/2])
				cylinder(r=rod_margin/2, h=top_thickness, center=true, $fn=precision);
			}

			translate([0, 0, -top_rod_holder_height/2 -top_thickness + top_rod_holder_height])
			hull() {
				translate([face_rod_spacing/2,-top_rod_spacing/2, 0.25*top_rod_holder_height/2])
				cylinder(r=rod_margin/2, h=1, center=true, $fn=precision);
				translate([0, 0, top_rod_holder_height/2])
				cylinder(r=rod_margin/2, h=top_thickness, center=true, $fn=precision);
			}
			translate([0, 0, -top_rod_holder_height/2 -top_thickness + top_rod_holder_height])
			hull() {
				translate([-face_rod_spacing/2,top_rod_spacing/2, 0.25*top_rod_holder_height/2])
				cylinder(r=rod_margin/2, h=1, center=true, $fn=precision);
				translate([0, 0, top_rod_holder_height/2])
				cylinder(r=rod_margin/2, h=top_thickness, center=true, $fn=precision);
			}

			translate([0, 0, -top_rod_holder_height/2 -top_thickness + top_rod_holder_height])
			hull() {
				translate([face_rod_spacing/2,top_rod_spacing/2, 0.25*top_rod_holder_height/2])
				cylinder(r=rod_margin/2, h=1, center=true, $fn=precision);
				translate([0, 0, top_rod_holder_height/2])
				cylinder(r=rod_margin/2, h=top_thickness, center=true, $fn=precision);
			}
		} //union

		translate([face_rod_spacing/2, top_rod_spacing/2, -face_thickness/2])
		cylinder(r=(rod_dia)/2 + clearance, h=2*face_thickness, center=true, $fn=precision);
		translate([-face_rod_spacing/2, top_rod_spacing/2, -face_thickness/2])
		cylinder(r=(rod_dia)/2 + clearance, h=2*face_thickness, center=true, $fn=precision);
		translate([face_rod_spacing/2, -top_rod_spacing/2, -face_thickness/2])
		cylinder(r=(rod_dia)/2 + clearance, h=2*face_thickness, center=true, $fn=precision);	
		translate([-face_rod_spacing/2, -top_rod_spacing/2, -face_thickness/2])
		cylinder(r=(rod_dia)/2 + clearance, h=2*face_thickness, center=true, $fn=precision);

		translate([0, 0, 0])
		recess_bearing(bearing_od, bearing_thickness , 1, 0, 24, 0);

		translate([0, 0, -top_thickness])
		rotate([180, 0 ,0])
		recess_bearing(bearing_od, bearing_thickness - 1, 1, 3, 24, 0);

		translate([0, 0, -top_thickness])
		cylinder(r=bearing_id/2, h= face_height*2, $fn=24, center=true);		
	}
}
//-------------------------------------------------------------------------------
module face() {
	difference() {
		hull() {
			translate([0, -face_thickness/2, 0])
			rotate([90, 0, 0])
			cylinder(r=bearing_od/2+bearing_margin, h=face_thickness, center=true, $fn=precision);
			
			translate([-face_rod_spacing/2, -face_thickness/2, 0])
			cylinder(r=(rod_dia)/2+rod_margin, h=face_height, center=true, $fn=precision);
			
			translate([face_rod_spacing/2, -face_thickness/2, 0])
			cylinder(r=(rod_dia)/2+rod_margin, h=face_height, center=true, $fn=precision);
		}
	
		rotate([90, 0, 0])
		cylinder(r=bearing_id/2, h= face_height*2, $fn=24, center=true);
	
		rotate([-90, 0, 0])
		recess_bearing(bearing_od, bearing_thickness, 1, 2, 24, 0);
		translate([0, -face_thickness, 0])
		rotate([90, 0, 0])
		recess_bearing(bearing_od, bearing_thickness, 1, 2, 24, 0);
		
		translate([face_rod_spacing/2, -face_thickness/2, 0])
		cylinder(r=(rod_dia)/2 + clearance, h=2*face_height, center=true, $fn=precision);
			
		translate([-face_rod_spacing/2, -face_thickness/2, 0])
		cylinder(r=(rod_dia)/2 + clearance, h=2*face_height, center=true, $fn=precision);
	}
}
//-------------------------------------------------------------------------------
module bi_face() {
difference() {
union() {
		hull() {			
			translate([-face_rod_spacing/2,0, 0])
			cylinder(r=(rod_dia)/2+rod_margin, h=face_height, center=true, $fn=precision);
			
			translate([face_rod_spacing/2, 0, 0])
			cylinder(r=(rod_dia)/2+rod_margin, h=face_height, center=true, $fn=precision);
		}

		hull() {				
			translate([face_rod_spacing/2, 0,0])
			cylinder(r=(rod_dia)/2+rod_margin, h=face_height, center=true, $fn=precision);

			/*translate([face_rod_spacing/2 + ((rod_dia)/2+rod_margin)/2 , 0, 0])
			cube([(rod_dia)/2+rod_margin, 2*((rod_dia)/2+rod_margin), 2*(bearing_od/2+1.5*bearing_margin)], center= true);*/
			translate([dist_AB, biface_thickness/2 - ((rod_dia)/2+rod_margin), 0])
			rotate([90, 0, 0])
			cylinder(r=bearing_od/2+1.5*bearing_margin, h=biface_thickness, center=true, $fn=precision);
		}


}//union
		rotate([90, 0, 0])
		cylinder(r=rod_dia/2 + 2, h= face_height*2, $fn=24, center=true);
	
		translate([0, rod_dia/2 + rod_margin, 0])
		rotate([-90, 0, 0])
		recess_bearing(bearing_od, bearing_thickness, 2, 2, 12, 0);

		translate([reduc_spacing,  biface_thickness - ((rod_dia)/2+rod_margin), 0])
		rotate([-90, 0, 0])
		recess_bearing(bearing_od, bearing_thickness, 2, 1, 12, 0);

		translate([reduc_spacing,  -((rod_dia)/2+rod_margin), 0])
		rotate([-90, 0, 180])
		recess_bearing(bearing_od, bearing_thickness -1, 0.5, 3, 12, 0);

		translate([reduc_spacing,  15 - ((rod_dia)/2+rod_margin) + bearing_thickness +3.5, 0])
		rotate([90, 0, 0])
		cylinder(r=rod_dia/2 + 2, h=30, $fn=24, center=true);
		
		if (face_teardrop == "yes") {
			translate([face_rod_spacing/2, 0, 0])
				hull () {
					cylinder(r=(rod_dia)/2 + clearance, h=2*face_height, center=true, $fn=precision);
					translate([0, sqrt(2)*(rod_dia-1)/2, 0])
					cube([1, 1, 60], center=true);
				}
			translate([-face_rod_spacing/2, 0, 0])
				hull () {
					cylinder(r=(rod_dia)/2 + clearance, h=2*face_height, center=true, $fn=precision);
					translate([0, sqrt(2)*(rod_dia-1)/2, 0])
					cube([1, 1, 60], center=true);
				}
	
		} else if (face_teardrop == "no") {
			translate([face_rod_spacing/2, 0, 0])
			cylinder(r=(rod_dia)/2 + clearance, h=2*face_height, center=true, $fn=precision);
				
			translate([-face_rod_spacing/2, 0, 0])
			cylinder(r=(rod_dia)/2 + clearance, h=2*face_height, center=true, $fn=precision);
		}


	}

}
//-------------------------------------------------------------------------------
module simple_face() {
	difference() {
		hull() {			
			translate([-face_rod_spacing/2, -face_thickness/2, 0])
			cylinder(r=(rod_dia)/2+rod_margin, h=face_height, center=true, $fn=precision);
			
			translate([face_rod_spacing/2, -face_thickness/2, 0])
			cylinder(r=(rod_dia)/2+rod_margin, h=face_height, center=true, $fn=precision);
		}
		rotate([90, 0, 0])
		cylinder(r=bearing_id/2, h= face_height*2, $fn=24, center=true);
	
		translate([0, -face_thickness/2 + rod_dia/2 + rod_margin, 0])
		rotate([-90, 0, 0])
		recess_bearing(bearing_od, bearing_thickness, 2, 2, 12, 0);
		
		translate([face_rod_spacing/2, -face_thickness/2, 0])
		cylinder(r=(rod_dia)/2 + clearance, h=2*face_height, center=true, $fn=precision);
			
		translate([-face_rod_spacing/2, -face_thickness/2, 0])
		cylinder(r=(rod_dia)/2 + clearance, h=2*face_height, center=true, $fn=precision);
	}
}
//-------------------------------------------------------------------------------
module simple_face_eco() {
intersection() {

	union() {
		translate([0, -face_thickness/2, -face_height/4])
		cylinder(r1 = face_rod_spacing/2 - rod_dia/2 - rod_margin, r2 = bearing_od/2+bearing_margin, h=face_height/2, center=true, $fn=precision);


		translate([0, -face_thickness/2, 0])
		rotate([0, 45, 0])
		cylinder(r=(rod_dia)/2+rod_margin + 1, h=face_height, center=true, $fn=precision);

		translate([0, -face_thickness/2, 0])
		rotate([0, -45, 0])
		cylinder(r=(rod_dia)/2+rod_margin + 1, h=face_height, center=true, $fn=precision);

		translate([0, -face_thickness/2, 0])
		rotate([90, 0, 0])
		cylinder(r=bearing_od/2+bearing_margin, h=face_thickness, center=true, $fn=precision);

		translate([-face_rod_spacing/2, -face_thickness/2, face_height/2])
		cylinder(r=(rod_dia)/2+rod_margin + 1, h=face_height/2, center=true, $fn=precision);
		translate([face_rod_spacing/2, -face_thickness/2, face_height/2])
		cylinder(r=(rod_dia)/2+rod_margin + 1, h=face_height/2, center=true, $fn=precision);
		translate([-face_rod_spacing/2, -face_thickness/2, -face_height/2])
		cylinder(r=(rod_dia)/2+rod_margin + 1, h=face_height/2, center=true, $fn=precision);
		translate([face_rod_spacing/2, -face_thickness/2, -face_height/2])
		cylinder(r=(rod_dia)/2+rod_margin + 1, h=face_height/2, center=true, $fn=precision);

		translate([0, -face_thickness/2, 0])
		cube([face_rod_spacing,rod_margin, 1.1*face_height], center=true);

	}
	difference() {
		hull() {			
			translate([-face_rod_spacing/2, -face_thickness/2, 0])
			cylinder(r=(rod_dia)/2+rod_margin, h=face_height, center=true, $fn=precision);
			
			translate([face_rod_spacing/2, -face_thickness/2, 0])
			cylinder(r=(rod_dia)/2+rod_margin, h=face_height, center=true, $fn=precision);
		}
	
		rotate([90, 0, 0])
		cylinder(r=bearing_id/2, h= face_height*2, $fn=24, center=true);
	
		translate([0, -((rod_dia)/2+rod_margin)/2, 0])
		rotate([-90, 0, 0])
		recess_bearing(bearing_od, bearing_thickness, 2, 2, 24, 0);
		
		translate([face_rod_spacing/2, -face_thickness/2, 0])
		cylinder(r=(rod_dia)/2 + clearance, h=2*face_height, center=true, $fn=precision);
			
		translate([-face_rod_spacing/2, -face_thickness/2, 0])
		cylinder(r=(rod_dia)/2 + clearance, h=2*face_height, center=true, $fn=precision);
	}
}
}
//-------------------------------------------------------------------------------
hyp = sqrt((crank_spacing/2)*(crank_spacing/2)+(c_bulge)*(c_bulge));
crank_ang = atan((crank_spacing/2)/(c_bulge)); 
c_rad = hyp/(2*cos(crank_ang));
crank_open_angle = 2*atan((crank_spacing/2)/c_bulge);
crank_center_y = c_bulge - c_rad;
in_angle = 2*atan((crank_spacing/2)/(c_rad - c_bulge));
crank_div = in_angle/12;
smaller_crank_dia = min(crank_A_dia, crank_B_dia);
//-------------------------------------------------------------------------------
module crank(arc="single") {
if (arc=="single") {
	difference () {
	union() {
		// A, left, x < 0
		translate([-crank_spacing/2, 0,crank_thickness/2])
		cylinder (r=crank_A_dia/2, h=crank_thickness, center=true, $fn = crank_precision);

		// B, right, x > 0
		translate([crank_spacing/2, 0, 0]) 
		translate([0, 0,crank_thickness/2])
		cylinder (r=crank_B_dia/2, h=crank_thickness, center=true, $fn = crank_precision);

		translate([0, crank_center_y, 0]) { 
			rotate([0, 0, 90-in_angle/2])
			for(i=[0:crank_div:in_angle-crank_div]) {
			hull () {
				crank_elem(crank_min_ratio*crank_B_dia/2+
				(crank_min_ratio*(crank_A_dia-crank_B_dia)/2)*i/in_angle,
				c_rad, i, offX=0, offY=-crank_center_y);
				crank_elem(crank_min_ratio*crank_B_dia/2+(crank_min_ratio*(crank_A_dia-crank_B_dia)/2)*(i+crank_div)/in_angle, c_rad, i+crank_div, offX=0, offY=-crank_center_y);
				}
			}
			
			rotate([0, 0, 90-in_angle/2])
			hull () {
				crank_elem(crank_B_dia/2,
				c_rad, 0, offX=0, offY=-crank_center_y);
				crank_elem(crank_min_ratio*crank_B_dia/2+(crank_min_ratio*(crank_A_dia-crank_B_dia)/2)*(0+crank_div)/in_angle, c_rad, 0+crank_div, offX=0, offY=-crank_center_y);
				}

			rotate([0, 0, 90-in_angle/2])
			hull () {
				crank_elem(crank_min_ratio*crank_B_dia/2+
				(crank_min_ratio*(crank_A_dia-crank_B_dia)/2)*(in_angle-crank_div)/in_angle,
				c_rad, (in_angle-crank_div), offX=0, offY=-crank_center_y);
				crank_elem(crank_A_dia/2, c_rad, (in_angle-crank_div)+crank_div, offX=0, offY=-crank_center_y);
				}
			
		} // translate center y

	} // union

	translate([-crank_spacing/2, 0, - 0.1])
	crank_nut(crank_nut_A, crank_nut_thickness_A);

	translate([crank_spacing/2, 0,crank_thickness - crank_nut_thickness_B + 0.1])
	crank_nut(crank_nut_B, crank_nut_thickness_B);

	//rod 
	translate([-crank_spacing/2, 0, crank_thickness/2])
	cylinder(r=(crank_rod_dia_A + clearance)/2 + clearance, h= 1.1*crank_thickness, center=true, $fn=crank_precision);
	translate([crank_spacing/2, 0, crank_thickness/2])
	cylinder(r=(crank_rod_dia_B + clearance)/2 + clearance, h= 1.1*crank_thickness, center=true, $fn=crank_precision);
	} // difference	
} // if single
//---------------------- double ---------------------------------------
if (arc=="double") {
difference () {
	union() {
		// A, left, x < 0
		translate([-crank_spacing/2, 0,crank_thickness/2])
		cylinder (r=crank_A_dia/2, h=crank_thickness, center=true, $fn = crank_precision);

		// B, right, x > 0
		translate([crank_spacing/2, 0, 0]) 
		translate([0, 0,crank_thickness/2])
		cylinder (r=crank_B_dia/2, h=crank_thickness, center=true, $fn = crank_precision);

		translate([-crank_spacing/4, crank_center_y/2, 0]) { 
			rotate([0, 0, 90-in_angle/2])
			for(i=[0:crank_div:in_angle-crank_div]) {
			hull () {
				crank_elem(crank_min_ratio*crank_B_dia/2+
				(crank_min_ratio*(crank_A_dia-crank_B_dia)/2)*i/in_angle,
				c_rad/2, i);
				crank_elem(crank_min_ratio*crank_B_dia/2+(crank_min_ratio*(crank_A_dia-crank_B_dia)/2)*(i+crank_div)/in_angle, c_rad/2, i+crank_div);
				}
			}

			rotate([0, 0, 90-in_angle/2])
			hull () {
				crank_elem(crank_min_ratio*crank_B_dia/2+
				(crank_min_ratio*(crank_A_dia-crank_B_dia)/2)*(in_angle-crank_div)/in_angle,
				c_rad/2, in_angle-1.5*crank_div);
				crank_elem(crank_A_dia/2, c_rad/2, (in_angle-crank_div)+crank_div);
				}			
		}


		translate([crank_spacing/4, -crank_center_y/2, 0]) { 
			rotate([0, 0, 180 + 90-in_angle/2])
			for(i=[0:crank_div:in_angle-crank_div]) {
			hull () {
				crank_elem ((crank_min_ratio*crank_B_dia/2), c_rad/2, i);
				crank_elem ((crank_min_ratio*crank_B_dia/2), c_rad/2, i+crank_div);
				}
			}

			rotate([0, 0, 180 + 90-in_angle/2])
			hull () {
				crank_elem ((crank_min_ratio*crank_B_dia/2), c_rad/2, in_angle-1.5*crank_div);
				crank_elem ((crank_B_dia/2), c_rad/2, in_angle);
				}			
		}

		
	} // union
	translate([-crank_spacing/2, 0, - 0.1])
	crank_nut(crank_nut_A, crank_nut_thickness_A);

	translate([crank_spacing/2, 0,crank_thickness - crank_nut_thickness_B + 0.1])
	crank_nut(crank_nut_B, crank_nut_thickness_B);
	//rod 
	translate([-crank_spacing/2, 0, crank_thickness/2])
	cylinder(r=(crank_rod_dia_A + clearance)/2 + clearance, h= 1.1*crank_thickness, center=true, $fn=crank_precision);
	translate([crank_spacing/2, 0, crank_thickness/2])
	cylinder(r=(crank_rod_dia_B + clearance)/2 + clearance, h= 1.1*crank_thickness, center=true, $fn=crank_precision);
	} // difference
}
//----------------------// double ---------------------------------------
}



//-------------------------------------------------------------------------------
module drawCircle (pX=0, pY=0, pRadius=5, pSegment=32, pColor="lightgrey") {
%translate([pX, pY, 0]){
	color(pColor)
	difference() {
		cylinder(r=pRadius, h = 1, $fn=pSegment, center=true);
		cylinder(r=pRadius-0.5, h = 2, $fn=pSegment, center=true);
	}
	rotate([0, 90, 0])
	cylinder(r=0.5, h=10, center=true);
	
	rotate([90, 0, 0])
	cylinder(r=0.5, h=10, center=true);
	}
}
//-------------------------------------------------------------------------------
module crank_elem (radius=12, arc_radius = 60, angle=30) {
	translate([arc_radius*cos(angle), arc_radius*sin(angle),crank_thickness/2])
	rotate([0, 0, angle])
	cube([radius*2, 1, crank_thickness], center=true);
}
//-------------------------------------------------------------------------------
module crank_nut (width = 13, height = 7, clear = 0.25) {
	translate([0, 0,height/2])
	rotate([0, 0, 90])
	cylinder (r=(width+clear)/cos(30)/2, h=height, center=true, $fn = 6);
}
//-------------------------------------------------------------------------------




//-------------------------------------------------------------------------------
module recess_bearing (pOD=22.4, pH=6.1, pTop=1.5, pBot=2, pTopMargin=40, pBotMargin=30, eps=0.01, fn=36) {
	translate([0, 0, -pH/2 - pTop + 2*eps]) {
		// Bearing
		cylinder(r=pOD/2, h=pH, $fn=fn, center=true);
		// Above
		if (pTop > 0) {
			translate([0, 0, pH/2 + pTop/2 - eps])
			cylinder(r1=pOD/2, r2=(pOD/2)+pTop/tan(45), h=pTop, $fn=fn, center=true);
		}
		if (pTopMargin > 0) {
			translate([0, 0, pH/2 + pTop - 2*eps + pTopMargin/2])
			cylinder(r=(pOD/2)+pTop/tan(45), h=pTopMargin, $fn=fn, center=true);
		}
		
		// Below
		if (pBot > 0) {
			translate([0, 0, -pH/2 - pBot/2 + eps])
			cylinder(r2=pOD/2, r1=(pOD/2)-pBot/tan(45), h=pBot, $fn=fn, center=true);
		}
		if (pBotMargin > 0) {
			translate([0, 0, -pH/2 - pBot + 2*eps - pBotMargin/2])
			cylinder(r=(pOD/2)-pBot/tan(45), h=pBotMargin, $fn=fn, center=true);
		}
	}	
}
//-------------------------------------------------------------------------------
module jig () {
	difference() {	
		union() {			
			translate([0, 0, jig_thickness/2])
			cylinder(r=jig_around_hole + jig_drill_dia/2, h=jig_thickness, center=true, $fn=precision);

			translate([0, 0, jig_margin/2])
			cube([2*jig_around_hole + jig_drill_dia, top_rod_spacing, jig_margin], center=true);

			translate([0, -top_rod_spacing/2, jig_margin/2])
			cube([face_rod_spacing, 2*(jig_around_hole + jig_drill_dia/2), jig_margin], center=true);

			translate([0, top_rod_spacing/2, jig_margin/2])
			cube([face_rod_spacing, 2*(jig_around_hole + jig_drill_dia/2), jig_margin], center=true);

			translate([0, -top_rod_spacing/2, jig_thickness/2])
			cube([face_rod_spacing, jig_margin, jig_thickness], center=true);

			translate([0, top_rod_spacing/2, jig_thickness/2])
			cube([face_rod_spacing, jig_margin, jig_thickness], center=true);

			translate([0, 0, jig_thickness/2])
			cube([jig_margin, top_rod_spacing, jig_thickness], center=true);

			translate([-face_rod_spacing/2, -top_rod_spacing/2, jig_thickness/2])
			cylinder(r=jig_around_hole + jig_drill_dia/2, h=jig_thickness, center=true, $fn=precision);
			translate([face_rod_spacing/2, -top_rod_spacing/2, jig_thickness/2])
			cylinder(r=jig_around_hole + jig_drill_dia/2, h=jig_thickness, center=true, $fn=precision);
			translate([-face_rod_spacing/2, top_rod_spacing/2, jig_thickness/2])
			cylinder(r=jig_around_hole + jig_drill_dia/2, h=jig_thickness, center=true, $fn=precision);
			translate([face_rod_spacing/2, top_rod_spacing/2, jig_thickness/2])
			cylinder(r=jig_around_hole + jig_drill_dia/2, h=jig_thickness, center=true, $fn=precision);
			
		}

		translate([face_rod_spacing/2, top_rod_spacing/2, 0])
		cylinder(r=(jig_drill_dia)/2 , h=2*face_thickness, center=true, $fn=precision);
		translate([-face_rod_spacing/2, top_rod_spacing/2, 0])
		cylinder(r=(jig_drill_dia)/2 , h=2*face_thickness, center=true, $fn=precision);
		translate([face_rod_spacing/2, -top_rod_spacing/2, 0])
		cylinder(r=(jig_drill_dia)/2 , h=2*face_thickness, center=true, $fn=precision);	
		translate([-face_rod_spacing/2, -top_rod_spacing/2, 0])
		cylinder(r=(jig_drill_dia)/2 , h=2*face_thickness, center=true, $fn=precision);

		translate([0, 0, -top_thickness])
		cylinder(r=1.75, h= face_height*2, $fn=24, center=true);		
		}
}
//-------------------------------------------------------------------------------
module connect() {
nb_holes = 10;
hole_dia = 10;
dia = 80;

difference() {
	union() {
		cylinder (r=pto_hub_dia/2, h=2, center=true, $fn=precision);

		translate([0, 0, 15])
		cylinder (r1=pto_hub_dia/2, r2=50, h=30, center=true, $fn=precision);

		translate([0, 0,30 + 2.5])
		cylinder (r=50, h=5, center=true, $fn=precision);
	} // union

		for (i=[0:nb_holes-1]) {
			rotate([0, 0, i*(360/nb_holes)])
			translate([dia/2, 0, 25])
			cylinder(r=hole_dia/2, h=50, $fn=precision, center=true); 
		}

		translate([0, 0, 37])
		cylinder (r1=10, r2 = 60, h=40, center=true, $fn=precision);

		translate([0, 0, 40])
		cylinder (r1=20, r2=140, h=20, center=true, $fn=precision);

		rotate([0, 0, (360/(nb_holes*2))])
		for (i=[0:nb_holes-1]) {
			rotate([0, 0, i*(360/nb_holes)])
			translate([35, 0, 45 - 15])
			cube([36, 4.5, 20], center=true); 
		}
		
	}// difference
}
//-------------------------------------------------------------------------------

if (print_bed_visible == "yes") {
	color ("grey") 
	translate ([0, 0, - 1])
	%cube ([print_bed_width, print_bed_height, 2], center = true);
}



































//-------------------------------------------------------------------------------
//------------- Bevel gears by Greg Frost ---------------------------------------
//-------------------------------------------------------------------------------

bevel_gear_flat = 1;
bevel_gear_back_cone = 1;
pi=3.1415926535897932384626433832795;
//-------------------------------------------------------------------------------

module hpto_gear(
	gear1_teeth = 11,
	gear2_teeth = 11,
	axis_angle = 90,
	outside_circular_pitch=720)
{
	outside_pitch_radius1 = gear1_teeth * outside_circular_pitch / 360;
	outside_pitch_radius2 = gear2_teeth * outside_circular_pitch / 360;
	pitch_apex1=outside_pitch_radius2 * sin (axis_angle) + (outside_pitch_radius2 * cos (axis_angle) + outside_pitch_radius1) / tan (axis_angle);
	cone_distance = sqrt (pow (pitch_apex1, 2) + pow (outside_pitch_radius1, 2));
	pitch_apex2 = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius2, 2));
	pitch_angle1 = asin (outside_pitch_radius1 / cone_distance);
	pitch_angle2 = asin (outside_pitch_radius2 / cone_distance);
	{
		translate([0,0,4])
		difference() {
			intersection() {
				union() {
					bevel_gear (
						number_of_teeth=gear1_teeth,
						cone_distance=cone_distance,
						pressure_angle=30,
						outside_circular_pitch=outside_circular_pitch,
						face_width=12,
						gear_thickness=12
						);
					translate([0, 0, 0])
					cylinder(r=12, h=11, $fn=24, center=true);
				}
				translate([0, 0, 2])
				cylinder(r=25, h=12, $fn=24, center=true);
			} // intersection
			translate([0, 0, 12/2 - 7/2])
			cylinder (r=(13+0.25)/cos(30)/2, h=7, center=true, $fn = 6);
			cylinder (r=8.25/2, h=80, center=true, $fn = 24);
		} // difference
	}
}
//-------------------------------------------------------------------------------
module bevel_gear_pair (
	gear1_teeth = 11,
	gear2_teeth = 11,
	axis_angle = 90,
	outside_circular_pitch=720)

{
	outside_pitch_radius1 = gear1_teeth * outside_circular_pitch / 360;
	outside_pitch_radius2 = gear2_teeth * outside_circular_pitch / 360;
	pitch_apex1=outside_pitch_radius2 * sin (axis_angle) + 
		(outside_pitch_radius2 * cos (axis_angle) + outside_pitch_radius1) / tan (axis_angle);
	cone_distance = sqrt (pow (pitch_apex1, 2) + pow (outside_pitch_radius1, 2));
	pitch_apex2 = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius2, 2));
	pitch_angle1 = asin (outside_pitch_radius1 / cone_distance);
	pitch_angle2 = asin (outside_pitch_radius2 / cone_distance);
	/*echo ("cone_distance", cone_distance);
	echo ("pitch_angle1, pitch_angle2", pitch_angle1, pitch_angle2);
	echo ("pitch_angle1 + pitch_angle2", pitch_angle1 + pitch_angle2);*/
	{
		translate([0,0,pitch_apex1])
		rotate([0, 0, 180])
		rotate([180, 0, 0])
		difference() {
			intersection() {
				union() {
					bevel_gear (
						number_of_teeth=gear1_teeth,
						cone_distance=cone_distance,
						pressure_angle=30,
						outside_circular_pitch=outside_circular_pitch,
						face_width=12,
						gear_thickness=12
						);
					translate([0, 0, 0])
					cylinder(r=12, h=11, $fn=24, center=true);
					
				}
				translate([0, 0, 2])
				cylinder(r=25, h=12, $fn=24, center=true);
	
			} // intersection

			translate([0, 0, 12/2 - 7/2])
			cylinder (r=(13+0.25)/cos(30)/2, h=7, center=true, $fn = 6);

			cylinder (r=8.25/2, h=80, center=true, $fn = 24);
		} // difference

		//echo ("translate pitch_apex2 : ", pitch_apex2);
		rotate([0,-(pitch_angle1+pitch_angle2),0])
		translate([0,0,-pitch_apex2])
		intersection() {
			bevel_gear (
				number_of_teeth=gear2_teeth,
				cone_distance=cone_distance,
				pressure_angle=30,
				outside_circular_pitch=outside_circular_pitch,
				face_width=12,
				gear_thickness=12);
			
			translate([0, 0, 2])
			cylinder(r=25, h=12, $fn=24, center=true);		
		} // intersection
	} // difference
}

//-------------------------------------------------------------------------------
module bevel_gear (
	number_of_teeth=11,
	cone_distance=200,
	face_width=12,
	outside_circular_pitch=500,
	pressure_angle=30,
	clearance = 0.25,
	bore_diameter=8,
	gear_thickness = 12,
	backlash = 0,
	involute_facets=0,
	finish = 1)
{
	/*echo ("bevel_gear",
		"teeth", number_of_teeth,
		"cone distance", cone_distance,
		face_width,
		outside_circular_pitch,
		pressure_angle,
		clearance,
		bore_diameter,
		involute_facets,
		finish);*/

	// Pitch diameter: Diameter of pitch circle at the fat end of the gear.
	outside_pitch_diameter  =  number_of_teeth * outside_circular_pitch / 180;
	outside_pitch_radius = outside_pitch_diameter / 2;

	// The height of the pitch apex.
	pitch_apex = sqrt (pow (cone_distance, 2) - pow (outside_pitch_radius, 2));
	pitch_angle = asin (outside_pitch_radius/cone_distance);

	//echo ("Num Teeth:", number_of_teeth, " Pitch Angle:", pitch_angle);

	finish = (finish != -1) ? finish : (pitch_angle < 45) ? bevel_gear_flat : bevel_gear_back_cone;

	apex_to_apex=cone_distance / cos (pitch_angle);
	back_cone_radius = apex_to_apex * sin (pitch_angle);

	// Calculate and display the pitch angle. This is needed to determine the angle to mount two meshing cone gears.

	// Base Circle for forming the involute teeth shape.
	base_radius = back_cone_radius * cos (pressure_angle);	

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = number_of_teeth / outside_pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1 / pitch_diametrial;
	// Outer Circle
	outer_radius = back_cone_radius + addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;
	dedendum_angle = atan (dedendum / cone_distance);
	root_angle = pitch_angle - dedendum_angle;

	root_cone_full_radius = tan (root_angle)*apex_to_apex;
	back_cone_full_radius=apex_to_apex / tan (pitch_angle);

	back_cone_end_radius = 
		outside_pitch_radius - 
		dedendum * cos (pitch_angle) - 
		gear_thickness / tan (pitch_angle);
	back_cone_descent = dedendum * sin (pitch_angle) + gear_thickness;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = back_cone_radius - dedendum;

	half_tooth_thickness = outside_pitch_radius * sin (360 / (4 * number_of_teeth)) - backlash / 4;
	half_thick_angle = asin (half_tooth_thickness / back_cone_radius);

	face_cone_height = apex_to_apex-face_width / cos (pitch_angle);
	face_cone_full_radius = face_cone_height / tan (pitch_angle);
	face_cone_descent = dedendum * sin (pitch_angle);
	face_cone_end_radius = 
		outside_pitch_radius -
		face_width / sin (pitch_angle) - 
		face_cone_descent / tan (pitch_angle);

	// For the bevel_gear_flat finish option, calculate the height of a cube to select the portion of the gear that includes the full pitch face.
	bevel_gear_flat_height = pitch_apex - (cone_distance - face_width) * cos (pitch_angle);

//	translate([0,0,-pitch_apex])
	difference ()
	{
		intersection ()
		{
			union()
			{
				rotate (half_thick_angle)
				translate ([0,0,pitch_apex-apex_to_apex])
				cylinder ($fn=number_of_teeth*2, r1=root_cone_full_radius,r2=0,h=apex_to_apex);
				for (i = [1:number_of_teeth])
//				for (i = [1:1])
				{
					rotate ([0,0,i*360/number_of_teeth])
					{
						involute_bevel_gear_tooth (
							back_cone_radius = back_cone_radius,
							root_radius = root_radius,
							base_radius = base_radius,
							outer_radius = outer_radius,
							pitch_apex = pitch_apex,
							cone_distance = cone_distance,
							half_thick_angle = half_thick_angle,
							involute_facets = involute_facets);
					}
				}
			}

			if (finish == bevel_gear_back_cone)
			{
				translate ([0,0,-back_cone_descent])
				cylinder (
					$fn=number_of_teeth*2, 
					r1=back_cone_end_radius,
					r2=back_cone_full_radius*2,
					h=apex_to_apex + back_cone_descent);
			}
			else
			{
				translate ([-1.5*outside_pitch_radius,-1.5*outside_pitch_radius,0])
				cube ([3*outside_pitch_radius,
					3*outside_pitch_radius,
					bevel_gear_flat_height]);
			}
		}
		
		if (finish == bevel_gear_back_cone)
		{
			translate ([0,0,-face_cone_descent])
			cylinder (
				r1=face_cone_end_radius,
				r2=face_cone_full_radius * 2,
				h=face_cone_height + face_cone_descent+pitch_apex);
		}

		translate ([0,0,pitch_apex - apex_to_apex])
		cylinder (r=bore_diameter/2,h=apex_to_apex);
	}	
}
//-------------------------------------------------------------------------------
module involute_bevel_gear_tooth (
	back_cone_radius,
	root_radius,
	base_radius,
	outer_radius,
	pitch_apex,
	cone_distance,
	half_thick_angle,
	involute_facets)
{
//	echo ("involute_bevel_gear_tooth",
//		back_cone_radius,
//		root_radius,
//		base_radius,
//		outer_radius,
//		pitch_apex,
//		cone_distance,
//		half_thick_angle);

	min_radius = max (base_radius*2,root_radius*2);

	pitch_point = 
		involute (
			base_radius*2, 
			involute_intersect_angle (base_radius*2, back_cone_radius*2));
	pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
	centre_angle = pitch_angle + half_thick_angle;

	start_angle = involute_intersect_angle (base_radius*2, min_radius);
	stop_angle = involute_intersect_angle (base_radius*2, outer_radius*2);

	res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;

	translate ([0,0,pitch_apex])
	rotate ([0,-atan(back_cone_radius/cone_distance),0])
	translate ([-back_cone_radius*2,0,-cone_distance*2])
	union ()
	{
		for (i=[1:res])
		{
			assign (
				point1=
					involute (base_radius*2,start_angle+(stop_angle - start_angle)*(i-1)/res),
				point2=
					involute (base_radius*2,start_angle+(stop_angle - start_angle)*(i)/res))
			{
				assign (
					side1_point1 = rotate_point (centre_angle, point1),
					side1_point2 = rotate_point (centre_angle, point2),
					side2_point1 = mirror_point (rotate_point (centre_angle, point1)),
					side2_point2 = mirror_point (rotate_point (centre_angle, point2)))
				{
					polyhedron (
						points=[
							[back_cone_radius*2+0.1,0,cone_distance*2],
							[side1_point1[0],side1_point1[1],0],
							[side1_point2[0],side1_point2[1],0],
							[side2_point2[0],side2_point2[1],0],
							[side2_point1[0],side2_point1[1],0],
							[0.1,0,0]],
						triangles=[[0,1,2],[0,2,3],[0,3,4],[0,5,1],[1,5,2],[2,5,3],[3,5,4],[0,4,5]]);
				}
			}
		}
	}
}
//-------------------------------------------------------------------------------
module gear (
	number_of_teeth=15,
	circular_pitch=false, diametral_pitch=false,
	pressure_angle=28,
	clearance = 0.2,
	gear_thickness=5,
	rim_thickness=8,
	rim_width=5,
	hub_thickness=12,
	hub_diameter=15,
	bore_diameter=5,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0)
{
	if (circular_pitch==false && diametral_pitch==false) 
		echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");

	//Convert diametrial pitch to our native circular pitch
	circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  number_of_teeth * circular_pitch / 180;
	pitch_radius = pitch_diameter/2;
	//echo ("Teeth:", number_of_teeth, " Pitch radius:", pitch_radius);

	// Base Circle
	base_radius = pitch_radius*cos(pressure_angle);

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = number_of_teeth / pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1/pitch_diametrial;

	//Outer Circle
	outer_radius = pitch_radius+addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;
	backlash_angle = backlash / pitch_radius * 180 / pi;
	half_thick_angle = (360 / number_of_teeth - backlash_angle) / 4;

	// Variables controlling the rim.
	rim_radius = root_radius - rim_width;

	// Variables controlling the circular holes in the gear.
	circle_orbit_diameter=hub_diameter/2+rim_radius;
	circle_orbit_curcumference=pi*circle_orbit_diameter;

	// Limit the circle size to 90% of the gear face.
	circle_diameter=
		min (
			0.70*circle_orbit_curcumference/circles,
			(rim_radius-hub_diameter/2)*0.9);

	difference ()
	{
		union ()
		{
			difference ()
			{
				linear_extrude (height=rim_thickness, convexity=10, twist=twist)
				gear_shape (
					number_of_teeth,
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);

				if (gear_thickness < rim_thickness)
					translate ([0,0,gear_thickness])
					cylinder (r=rim_radius,h=rim_thickness-gear_thickness+1);
			}
			if (gear_thickness > rim_thickness)
				cylinder (r=rim_radius,h=gear_thickness);
			if (hub_thickness > gear_thickness)
				translate ([0,0,gear_thickness])
				cylinder (r=hub_diameter/2,h=hub_thickness-gear_thickness);
		}
		translate ([0,0,-1])
		cylinder (
			r=bore_diameter/2,
			h=2+max(rim_thickness,hub_thickness,gear_thickness));
		if (circles>0)
		{
			for(i=[0:circles-1])	
				rotate([0,0,i*360/circles])
				translate([circle_orbit_diameter/2,0,-1])
				cylinder(r=circle_diameter/2,h=max(gear_thickness,rim_thickness)+3);
		}
	}
}
//-------------------------------------------------------------------------------
module gear_shape (
	number_of_teeth,
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	union()
	{
		rotate (half_thick_angle) circle ($fn=number_of_teeth*2, r=root_radius);

		for (i = [1:number_of_teeth])
		{
			rotate ([0,0,i*360/number_of_teeth])
			{
				involute_gear_tooth (
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);
			}
		}
	}
}
//-------------------------------------------------------------------------------
module involute_gear_tooth (
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	min_radius = max (base_radius,root_radius);

	pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
	pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
	centre_angle = pitch_angle + half_thick_angle;

	start_angle = involute_intersect_angle (base_radius, min_radius);
	stop_angle = involute_intersect_angle (base_radius, outer_radius);

	res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;

	union ()
	{
		for (i=[1:res])
		assign (
			point1=involute (base_radius,start_angle+(stop_angle - start_angle)*(i-1)/res),
			point2=involute (base_radius,start_angle+(stop_angle - start_angle)*i/res))
		{
			assign (
				side1_point1=rotate_point (centre_angle, point1),
				side1_point2=rotate_point (centre_angle, point2),
				side2_point1=mirror_point (rotate_point (centre_angle, point1)),
				side2_point2=mirror_point (rotate_point (centre_angle, point2)))
			{
				polygon (
					points=[[0,0],side1_point1,side1_point2,side2_point2,side2_point1],
					paths=[[0,1,2,3,4,0]]);
			}
		}
	}
}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / pi;

// Calculate the involute position for a given base radius and involute angle.

function rotated_involute (rotate, base_radius, involute_angle) = 
[
	cos (rotate) * involute (base_radius, involute_angle)[0] + sin (rotate) * involute (base_radius, involute_angle)[1],
	cos (rotate) * involute (base_radius, involute_angle)[1] - sin (rotate) * involute (base_radius, involute_angle)[0]
];

function mirror_point (coord) = 
[
	coord[0], 
	-coord[1]
];

function rotate_point (rotate, coord) =
[
	cos (rotate) * coord[0] + sin (rotate) * coord[1],
	cos (rotate) * coord[1] - sin (rotate) * coord[0]
];

function involute (base_radius, involute_angle) = 
[
	base_radius*(cos (involute_angle) + involute_angle*pi/180*sin (involute_angle)),
	base_radius*(sin (involute_angle) - involute_angle*pi/180*cos (involute_angle)),
];
//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------

