resolution = 80;
tire_diameter = 28;
rim_diameter = 19.7;
tire_thickness = 6.5;

cutout_diameter = 22.55;
cutout_thickness_outer = 3.7;
cutout_thickness_inner = 1.4;

difference() {
    union() {
        minkowski() {
            cylinder(h=tire_thickness-2, d=tire_diameter-2, center=true, $fn=resolution);
            sphere(d=2, center=true, $fn=resolution);
        }
    }
    
    for (i = [0:64]) {
        rotate([0,0,i*360/64]) translate([tire_diameter/2,0,0]) cube([1, 0.5, 40], center=true);
    }
    for (z = [-tire_thickness:4:tire_thickness]) {
		for (i = [0:64]) {
			rotate([0,0,i*360/64]) translate([tire_diameter/2,0,z]) rotate([45,0,0]) cube([1, 0.5, 40], center=true);
		}
	}
    
    cylinder(h=tire_thickness+8, d=rim_diameter, center=true, $fn=resolution);
    
    union() {
        cylinder(h=tire_thickness, d=rim_diameter, center=true, $fn=resolution);
        hull() {
            cylinder(h=cutout_thickness_outer, d=rim_diameter, center=true, $fn=resolution);
            cylinder(h=cutout_thickness_inner, d=cutout_diameter, center=true, $fn=resolution);
        }
    }
}