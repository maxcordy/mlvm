use <MCAD/involute_gears.scad>

00_build_plate = 0; //[0:Replicator 2,1:Replicator,3:Thing-o-Matic]

01_number_of_teeth = 30;

//Controls the size of the teeth (and hence the size of the gear)
02_circular_pitch =  400;

//Controls the shape of the teeth
03_pressure_angle = 21;

//The gap between the root between teeth and the teeth point on a meshing gear
04_clearance = 1;

//the thickness of the gear plate
05_gear_thickness = 5;

//the thickness of the gear at the rim (including the teeth)
06_rim_thickness = 10;

//radial distance from the root of the teeth to the inside of the rim
07_rim_width = 5;

//the thickness of the section around the bore
08_hub_thickness = 10;


09_hub_diameter = 20;

//size of the hole in the middle
10_bore_diameter = 10;


//the number of circular holes to cut in the gear plate
11_circles = 5;

//the space between this the back of this gears teeth and the front of its meshing gear's teeth when the gear is correctly spaced from it
12_backlash = .5;

//for making helical gears
13_twist = 0;

//the number of facets in one side of the involute tooth shape. If this is omitted it will be 1/4 of $fn. If $fn is not set, it will be 5.
14_involute_facets = 20;



gear(	number_of_teeth = 01_number_of_teeth,
		circular_pitch =  02_circular_pitch,
		pressure_angle = 03_pressure_angle,
		clearance = 04_clearance,
		gear_thickness = 05_gear_thickness,
		rim_thickness = 06_rim_thickness,
		rim_width = 07_rim_width,
		hub_thickness = 08_hub_thickness,
		hub_diameter = 09_hub_diameter,
		bore_diameter = 10_bore_diameter,
		circles = 11_circles,
		backlash = 12_backlash,
		twist = 13_twist,
		involute_facets = 14_involute_facets
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