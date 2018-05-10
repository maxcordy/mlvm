//include <configuration.scad>;
include <Rod End.scad>;


// Belt parameters
belt_width_clamp = 6;              // width of the belt, typically 6 (mm)
belt_thickness = 1.0 - 0.05;       // slightly less than actual belt thickness for compression fit (mm)           
belt_pitch = 2.0;                  // tooth pitch on the belt, 2 for GT2 (mm)
tooth_radius = 0.8;                // belt tooth radius, 0.8 for GT2 (mm)

separation = 40;
thickness = 6;

horn_thickness = 13;
horn_extra_thickness = 4;
horn_screw_Z_offset = 2;
horn_screw_head_inset = 2;
horn_x = 8;
horn_z = 2;

belt_width = 5;
belt_x = 5.6;
belt_z = 7;
corner_radius = 3.5;

ball_clearance = bearing_diameter + 4;

m3_nut_radius = 3.0;
m3_wide_radius = 1.55;

m4_nut_radius = (7/sqrt(3));
m4_nut_height = 3.2 + 0.2;
m4_wide_radius = 2;

echo(m4_nut_radius);

carriage();

module rod();

module polyhole(h, d, center) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n, center = center);
}

module polyholehires(h, d, center) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = 16, center = center);
}

module carriage() {

	// Timing belt (up and down).
	translate([-belt_x, 0, belt_z + belt_width/2]) %
	cube([1.7, 100, belt_width], center=true);
	translate([belt_x+1.23, 0, belt_z + belt_width/2]) %
	cube([2.3, 100, belt_width], center=true);
	
	difference() {
		union() {
			
			// Main body.
			translate([0, 4, thickness/2])
			cube([27, 40, thickness], center=true);
			
			difference(){
				belt_clamps();
				translate([horn_x, 16, (horn_thickness + horn_extra_thickness + horn_screw_Z_offset)/2]) rotate([90, 0, -90])
				hull(){
					cylinder(r1=m4_nut_radius, r2=m4_nut_radius+0.5, h=8, center=true, $fn=6);
					translate([0, 100, 0])
					cylinder(r1=m4_nut_radius, r2=m4_nut_radius+0.5, h=8, center=true, $fn=6);			
				}
			}
			
			// Ball joint mount horns.
			for (x = [-1, 1]) {
				scale([x, 1, 1])
				difference(){
					intersection() {
						translate([0, 15, (horn_thickness + horn_extra_thickness)/2])
						cube([separation, 18, (horn_thickness + horn_extra_thickness)], center=true);
						translate([horn_x, 16, (horn_thickness + horn_extra_thickness + horn_screw_Z_offset)/2]) rotate([0, 90, 0])
						cylinder(r1=14, r2=2.5, h=separation/2-horn_x);
					}
					translate([10, 10, horn_thickness + horn_extra_thickness - horn_screw_head_inset])
					hull(){
						cylinder(r=m3_wide_radius+1.5, h=100, center=false, $fn=12);
						translate([0, -10, 0])
						cylinder(r=m3_wide_radius+1.5, h=100, center=false, $fn=12);
					}
				}
			}

			// Ball clearance visual.
			for (x = [-1, 1]) {
				scale([x, 1, 1]) 
				translate([(separation/2) + ball_clearance/2 - 1, 16, (horn_thickness + horn_extra_thickness + horn_screw_Z_offset)/2]) rotate([0, 90, 0])
				%sphere(d = ball_clearance, $fn = 32);
			}
			
			// Avoid touching diagonal push rods (carbon tube).
			for(x = [-1, 1]){
				scale([x, 1, 1])
				difference() {
					translate([10.75, 2.5, horn_thickness/2+1])
					cube([5.5, 37, (horn_thickness)-2], center=true);

					translate([23, -12, 12.5 - 2]) rotate([30, 40, 30])
					cube([40, 80, 20], center=true);
					translate([10, -10, 0])
					hull(){
						cylinder(r=m3_wide_radius+1.5, h=100, center=true, $fn=12);
						translate([0, -10, 0])
						cylinder(r=m3_wide_radius+2, h=100, center=true, $fn=12);
					}
				}
			}
		}

		// Screws for linear slider.
		for (x = [-10, 10]) {
			for (y = [-10, 10]) {
				translate([x, y, thickness])
				polyhole(d=m3_wide_radius*2, h=30, center=true);
			}
		}
		
		// Screws for ball joints.
		translate([-35, 16, (horn_thickness + horn_extra_thickness + horn_screw_Z_offset)/2]) rotate([0, 90, 0])
		polyholehires(d=m4_wide_radius*2, h=60, center=true, $fn=12);
		translate([35, 16, (horn_thickness + horn_extra_thickness + horn_screw_Z_offset)/2]) rotate([0, 90, 0])
		polyholehires(d=m4_wide_radius*2, h=60, center=true, $fn=12);
		
		// Lock nuts for ball joints.
		for (x = [-1, 1]) {
			scale([x, 1, 1]) 
			translate([horn_x, 16, (horn_thickness + horn_extra_thickness + horn_screw_Z_offset)/2]) rotate([90, 0, -90])
			cylinder(r1=m4_nut_radius, r2=m4_nut_radius+0.5, h=8, center=true, $fn=6);
		}
	}
}

module belt_clamps(){
	// Belt clamps
	for (y = [[9, -1], [-1, 1]]) {
		translate([2.20, y[0], horn_thickness/2+1])
		hull() {
			translate([ corner_radius-1.5,  -y[1] * corner_radius + y[1], 0])
			cube([3.0, 5, horn_thickness-2], center=true);
			cylinder(h=horn_thickness-2, r=corner_radius, $fn=12, center=true);
		}
	}

	// top cube
	translate([2.20, 19, horn_thickness/2+1])
	difference() {
		cube([7, 10, horn_thickness-2], center=true);
		*translate([2.8, -3,1])
		cube([1.6, 6.1, 10], center=true);
		
		translate([-1.5,-5,-1.5]) {
			cube([belt_thickness,10,10]);
			for (mult = [0:5]) {
				translate([1,belt_pitch*mult,0]) cylinder(r=tooth_radius, h=10);
			}
		}
	}

	// bottom cube
	translate([2.20, -11, horn_thickness/2+1])
	difference() {
		cube([7, 10, horn_thickness-2], center=true);
		translate([-1.5,-5,-1.5]) {
			cube([belt_thickness,10,10]);
			for (mult = [0:5]) {
				translate([1,belt_pitch*mult,0]) cylinder(r=tooth_radius, h=10);
			}
		}
	}
}