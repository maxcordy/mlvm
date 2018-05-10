use <MCAD/involute_gears.scad>

00_build_plate = 0; //[0:Replicator 2,1:Replicator,3:Thing-o-Matic]

01_number_of_teeth = 11;

//the distance from the pitch apex to the outside pitch diameter
02_cone_distance = 100;

//the length of the teeth
03_face_width = 20;

//controls the size of the teeth (and hence the size of the gear). The circular pitch at the outside pitch diameter.
04_outside_circular_pitch =  1000;

//controls the shape of the teeth
05_pressure_angle = 30;

//gap between the tip of the teeth on one gear and the root of the teeth on another meshing gear
06_clearance = .2;

//size of the hole in the middle
07_bore_diameter = 5;

//the thickness of the gear for bevel_gear_back_cone finish (see below)
08_gear_thickness = 15;

//makes the tooth width smaller to make a gap between teeth of correctly spaced gears to allow for manufacturing tolerances
09_backlash = 0;

//the number of facets in one side of the involute tooth shape
10_involute_facets = 0;

11_finish = 0; //[0:Flat,1:Back Cone]


bevel_gear(	number_of_teeth = 01_number_of_teeth,
		cone_distance = 02_cone_distance,
		face_width = 03_face_width,
		outside_circular_pitch =  04_outside_circular_pitch,
		pressure_angle = 05_pressure_angle,
		clearance = 06_clearance,
		bore_diameter = 07_bore_diameter,
		gear_thickness = 08_gear_thickness,
		backlash = 09_backlash,
		involute_facets = 10_involute_facets,
		finish = 11_finish
);

translate([0,0,-.5]){
	if(00_build_plate == 0){
		%cube([285,153,1],center = true);
	}
	if(00_build_plate == 1){
		%cube([225,145,1],center = true);
	}
	if(00_build_plate == 3){
		%cube([120,120,1],center = true);
	}

}