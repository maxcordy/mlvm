rail_width = 4.5; // 6.3
inner_width = 9.1; // 9.4
depth = 3.5; // 8.5
resolution =  50;
clamp = true;
hook = false;

difference() {
	union() {
		// knobs
		translate([-10,0,depth/2.2]) rotate([90,0,0]) cylinder(h=inner_width, d=depth, center=true, $fn=resolution);
		translate([10,0,depth/2.2]) rotate([90,0,0]) cylinder(h=inner_width, d=depth, center=true, $fn=resolution);

		// main shape
		hull() {
			translate([-10,0,depth/2.2]) rotate([90,0,0]) cylinder(h=rail_width, d=depth, center=true, $fn=resolution);
			translate([10,0,depth/2.2]) rotate([90,0,0]) cylinder(h=rail_width, d=depth, center=true, $fn=resolution);
			translate([0,0,10]) rotate([90,0,0]) cylinder(h=rail_width, d=depth, center=true, $fn=resolution);
		}

		// clamp
		hull() {
			translate([0,0,7]) rotate([0,90,0]) cylinder(h=18, d=rail_width, center=true, $fn=resolution);
			translate([0,2,10]) rotate([0,90,0]) cylinder(h=18, d=rail_width, center=true, $fn=resolution);
			translate([0,-2,10]) rotate([0,90,0]) cylinder(h=18, d=rail_width, center=true, $fn=resolution);
			translate([0,2,25]) rotate([0,90,0]) cylinder(h=18, d=rail_width, center=true, $fn=resolution);
			translate([0,-2,25]) rotate([0,90,0]) cylinder(h=18, d=rail_width, center=true, $fn=resolution);
		}
	}
	
	// teeth
	if(clamp) {
		for (i = [8:20]) {
			translate([0,0,-4.6+(i*1.6)]) rotate([0,90,0]) cylinder(30,2.7 - (i*0.08),2.7 - (i*0.08),$fn=3,center=true);
		}
	}
	if(hook) {
		hull() {
			translate([0,0,13]) rotate([90,0,0]) cylinder(h=18, d=rail_width, center=true, $fn=resolution);
			translate([0,0,20]) rotate([90,0,0]) cylinder(h=18, d=rail_width, center=true, $fn=resolution);
			translate([-7,0,13]) rotate([90,0,0]) cylinder(h=18, d=rail_width, center=true, $fn=resolution);
		}
	}
	
	// ground
	translate([0,0,-10]) cube([30,20,20], center = true);

}