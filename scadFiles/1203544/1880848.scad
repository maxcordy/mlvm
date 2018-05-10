$fn = 100;

// Which one would you like to see?
part = "all"; // [flangia:Half Shell,gola:Bearing Dress,all:Complete Pulley]

// External bearing diameter in mm
bearing_diameter = 24; //[10:40]
// Bearing height in mm
bearing_height = 8; //[4:12]
// Bearing hole diameter in mm
bearing_hole = 8; //[4:12]

// Plate side in mm
plate_side = 100;

draw();

module draw() {
	if (part == "flangia") {
		translate([0,0,bearing_height]) flangia();
	} else if (part == "gola") {
		translate([0,0,bearing_height / 2]) gola();
	} else if (part == "all") {
		translate([0,0,bearing_height]) {
			flangia();
			gola();
			rotate([180,0,0]) flangia();
		}
	} else {
		translate([0,0,bearing_height]) {
			flangia();
			gola();
			rotate([180,0,0]) flangia();
		}
	}
	%translate([0,0,-1]) cube([plate_side,plate_side,2], center=true);
}
module flangia() {
	union() {
		difference() {
			translate([0,0,-bearing_height/2]) hull() {
			   translate([bearing_diameter*1.33,0,0]) cylinder(d=bearing_diameter, h=bearing_height, center=true);
			   cylinder(d=bearing_diameter*1.5, h=bearing_height, center=true);
			}
			translate([bearing_diameter*1.33,0,-5]) cylinder(d=bearing_hole, h=bearing_height*5, center=true);
			translate([bearing_diameter*1.33,0,-bearing_height]) cylinder(d1=bearing_hole*1.5, d2=bearing_hole, h=bearing_height/2, center=true);
			translate([0,0,0]) cylinder(d=bearing_diameter*1.375, h=bearing_height*1.25, center=true);
			translate([0,0,0]) cylinder(d=bearing_hole, h=bearing_height*5, center=true);
			translate([-bearing_diameter/3,0,0]) cylinder(d=bearing_diameter*2.5, h=bearing_height*0.75, center=true);
			translate([bearing_diameter*1.666, 0, -bearing_height/4]) rotate([90,0,0]) rotate_extrude(convexity = 10) translate([bearing_height*0.9, 0, 0]) scale([0.8,1,1]) circle(r = bearing_hole/2.5);
		}
		difference() {
			translate([0,0,-bearing_height/1.6]) cylinder(d=bearing_hole*1.75, h=bearing_height/4, center=true);
			translate([0,0,0]) cylinder(d=bearing_hole, h=bearing_height*5, center=true);
		}
	}
}

module gola() {
	difference() {
		cylinder(h=bearing_height, d=bearing_diameter*1.3, center=true);
		cylinder(h=bearing_height*2, d=bearing_diameter*1.01, center=true);
		rotate_extrude($fn=100, convexity = 10) translate([bearing_diameter/1.5, 0, 0]) scale([0.5, 1]) circle(d = bearing_height*0.875);
	}
}