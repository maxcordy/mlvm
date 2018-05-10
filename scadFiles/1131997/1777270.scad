//include <configuration.scad>;
include <Rod End.scad>;
include <Rod End Arm.scad>;

separation = 40;  // Distance between ball joint mounting faces.
offset = 24;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;
cone_r1 = 2.5;
cone_r2 = 10;

hot_end_depth = 3.65;
hot_end_diameter = 16.4;
hot_end_top_diameter = 12;

m3_nut_radius = 3.0;
m3_wide_radius = 1.55;

m4_nut_radius = (7/sqrt(3)) + 0.1;
m4_nut_height = 3.2;
m4_wide_radius = 2;


ball_clearance = bearing_diameter + 4;

rotate([180, 0 ,0])
translate([0, 0, height/2])
effector();

module rod();

module polyhole(h, d, center) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n, center = center);
}

module effector() {
	difference() {
		union() {
			cylinder(r=20-3, h=height, center=true, $fn=60);
			for (a = [0,120,240]) rotate([0, 0, a]) {
				rotate([0, 0, 30]) translate([offset/1.5, 0, 0])
				cube([offset/2, 24, height], center=true);
				for (s = [-1, 1]) scale([s, 1, 1]) {
					translate([0, offset, 0]) difference() {
						intersection() {
							cube([separation, 40, height], center=true);
							translate([0, -4, 0]) rotate([0, 90, 0])
							cylinder(r=10, h=separation, center=true);
							translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
							cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=24);
							translate([separation/2 + ball_diameter/2 - 1, 0, 0])
							%sphere(d = ball_clearance, $fn = 32);
						}
						rotate([0, 90, 0])
						cylinder(r=m4_wide_radius, h=separation+1, center=true, $fn=12);
						rotate([90, 0, 90])
						cylinder(r=m4_nut_radius, h=separation-28 + m4_nut_height*2, center=true, $fn=6);
					}
				}
			}
		}
		*translate([0, 0, push_fit_height-height/2])
		cylinder(r=hotend_radius, h=height, $fn=36);
		*translate([0, 0, -6]) # import("m5_internal.stl");
		*for (a = [0:60:359]) rotate([0, 0, a]) {
			translate([0, mount_radius, 0])
			cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
		}
		translate([0, 0, -height/2])
		hot_end();
		effector_screw_mount();
	}
}

module effector_screw_mount(){
	for(i = [1:6]){
		rotate(60*i)
		translate([0, mount_radius ,0]){
			polyhole(d = m3_wide_radius*2, h = 100, center = true);
		}
	}
}

module hot_end(){
    translate([0,0,-epsilon])
    polyhole(d = hot_end_top_diameter, h = height+epsilon*2);
    
    translate([0,0,-epsilon])
    polyhole(d = hot_end_diameter, h = hot_end_depth+epsilon);    
}