epsilon = 0.1;

m3_nut_radius = (5.5/sqrt(3)) + 0.2;
m3_nut_height = 2.4;
m3_wide_radius = 1.55;
m3_head_radius = (5.56/2) + 0.1;
m3_head_height = 3.05;

m4_nut_radius = (7/sqrt(3)) + 0.2;
m4_nut_height = 3.2;
m4_wide_radius = 2;

ball_diameter = 10;

bearing_diameter = 14;
bearing_thickness = 6;

bearing_outer_diameter = 13;
bearing_inner_diameter = 10.0;
bearing_inner_height = 2;
bearing_outer_height = (bearing_thickness - bearing_inner_height)/2 + epsilon;

screw_size = 4.3;
screw_length = 10;

arm_to_rod_length = bearing_diameter/2;

rod_distance = 210;

carbon_rod_diameter = 4;
carbon_rod_length = 160;
carbon_rod_length_inset_length = 10;
carbon_rod_length_inset_length_extra = 5;

holder_length = (rod_distance - carbon_rod_length)/2 + carbon_rod_length_inset_length;
holder_width = 9;

arm_rod_hexagon = bearing_thickness*2/sqrt(3);
arm_rod_extra_width = 2;

ball_tolerance = 0.10;	//Change if rod is too tight or too loose

slot_thickness = 0.1;
slot_length = 10;
slot_direction = 1;

interlocking_length = 20;
interlocking_thickness = 2;
interlocking_count = 3;
interlocking_tolerance = 0.25;
interlocking_inset = true;
interlocking_inset_height = 1;
interlocking_inset_percentage = 0.5;
interlocking_edge_tolerance = 0.3;

bridge_thickness = 0.1;

interlocking_test = false;
interlocking_test_length = interlocking_length + 20;

printable = false;	//Printable rod?
interlocking = false;	//One piece or 3 piece?
rod = true;		//show rod
end = true;		//show end


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

rod();

module rod(){
	if(printable){
		if(interlocking){
			arm_length = 10;
			hexagon_length = 35 - interlocking_length;
			
			if(rod){
				difference(){
					union(){
						difference(){
							translate([0, rod_distance/2 ,0])
							rotate([-90, 0, 0])
							hull(){
								translate([arm_rod_extra_width/2, 0, 0])
								cylinder(d = arm_rod_hexagon, h = rod_distance - interlocking_edge_tolerance*2 - (arm_length + hexagon_length)*2, $fn = 6, center = true);
								translate([-arm_rod_extra_width/2, 0, 0])
								cylinder(d = arm_rod_hexagon, h = rod_distance - interlocking_edge_tolerance*2 - (arm_length + hexagon_length)*2, $fn = 6, center = true);
							}
							
							for(i = [0, 1]){
								translate([0, rod_distance/2, 0])
								mirror([0, i, 0])
								translate([0, -rod_distance/2 + arm_length + hexagon_length - epsilon, 0]){
									translate([-(arm_rod_hexagon + arm_rod_extra_width)/2 - epsilon, 0, interlocking_thickness/2])
									cube([arm_rod_hexagon + arm_rod_extra_width + epsilon*2, interlocking_length + epsilon*2, 20]);
									
									for(i = [0:interlocking_count-2]){
										translate([-interlocking_tolerance/2 + -(arm_rod_hexagon + arm_rod_extra_width)/2 + ((arm_rod_hexagon + arm_rod_extra_width)/((interlocking_count*2)-1))*i*2 + ((arm_rod_hexagon + arm_rod_extra_width)/((interlocking_count*2)-1)), 0, -interlocking_tolerance/2 - interlocking_thickness/2])
										cube([(arm_rod_hexagon + arm_rod_extra_width)/((interlocking_count*2)-1) + interlocking_tolerance, interlocking_length + epsilon*2, 20]);
									}
									
									translate([0, interlocking_length/2, 0])
									polyhole(d = m3_wide_radius*2, h = 100, center = true);
									
									translate([0, interlocking_length/2, -bearing_thickness/2 - epsilon])
									polyhole(d = m3_head_radius*2, h = epsilon + interlocking_inset_height);
								}
							}
							
						}
						
						for(i = [0, 1]){
							translate([0, rod_distance/2, 0])
							mirror([0, i, 0])
							translate([0, -rod_distance/2 + arm_length + hexagon_length + interlocking_length/2 - epsilon*2, -bearing_thickness/2 + interlocking_inset_height])
							polyholehires(d = m3_wide_radius*2 + 0.4, h = 0.1, $fn = 16);
						}
					}
			
					if(interlocking_test){
						translate([-(arm_rod_hexagon + arm_rod_extra_width)/2 - epsilon, arm_length + hexagon_length + interlocking_test_length ,-bearing_thickness/2 - epsilon])
						cube([(arm_rod_hexagon + arm_rod_extra_width) + epsilon*2, 1000, bearing_thickness + epsilon*2]);
					}
				}
			}
			if(end){
				arm(holder_length = arm_length, hexagon_length = hexagon_length);
				
				translate([0, hexagon_length + arm_length - epsilon, 0])
				difference(){
					rotate([-90, 0, 0])
					hull(){
						translate([arm_rod_extra_width/2, 0, 0])
						cylinder(d = arm_rod_hexagon, h = interlocking_length - interlocking_edge_tolerance + epsilon, $fn = 6);
						translate([-arm_rod_extra_width/2, 0, 0])
						cylinder(d = arm_rod_hexagon, h = interlocking_length - interlocking_edge_tolerance + epsilon, $fn = 6);
					}
					*cylinder(d = arm_rod_hexagon, h = interlocking_length + epsilon, $fn = 6);
					
					translate([-(arm_rod_hexagon + arm_rod_extra_width)/2 - epsilon, 0, interlocking_thickness/2])
					cube([(arm_rod_hexagon + arm_rod_extra_width) + epsilon*2, interlocking_length + epsilon*2, 20]);
					
					for(i = [0:interlocking_count-1]){
						translate([-interlocking_tolerance/2 + -(arm_rod_hexagon + arm_rod_extra_width)/2 + ((arm_rod_hexagon + arm_rod_extra_width)/((interlocking_count*2)-1))*i*2, 0, -interlocking_tolerance/2 - interlocking_thickness/2])
						cube([(arm_rod_hexagon + arm_rod_extra_width)/((interlocking_count*2)-1) + interlocking_tolerance, interlocking_length + epsilon*2, 20]);
					}
					
					translate([0, interlocking_length/2, 0])
					polyhole(d = m3_wide_radius*2, h = 100, center = true);
					
					translate([0, interlocking_length/2, -bearing_thickness/2 - epsilon])
					cylinder(r = m3_nut_radius, h = epsilon + interlocking_inset_height, $fn = 6);
				}
				
				translate([0, (hexagon_length + arm_length - epsilon) + interlocking_length/2, -bearing_thickness/2 + interlocking_inset_height])
				polyholehires(d = m3_wide_radius*2 + 0.4, h = 0.1, $fn = 16);
					
				
				*color("gold")
				translate([0, rod_distance, 0])
				mirror([0, 1, 0])
				%arm(holder_length = arm_length, hexagon_length = hexagon_length);
			}
		} else {
			arm_length = 10;
			hexagon_length = 15;

			arm(holder_length = arm_length, hexagon_length = hexagon_length);
			
			translate([0, rod_distance/2 ,0])
			rotate([-90, 0, 0])
			hull(){
				translate([arm_rod_extra_width/2, 0, 0])
				cylinder(d = arm_rod_hexagon, h = rod_distance - (arm_length + hexagon_length)*2, $fn = 6, center = true);
				translate([-arm_rod_extra_width/2, 0, 0])
				cylinder(d = arm_rod_hexagon, h = rod_distance - (arm_length + hexagon_length)*2 + epsilon*2, $fn = 6, center = true);
			}
			
			*translate([0, arm_to_rod_length ,0])
			rotate([-90, 0, 0])
			cylinder(d = (arm_rod_hexagon + arm_rod_extra_width), h = rod_distance - arm_to_rod_length*2, $fn = 6);
			
			translate([0, rod_distance, 0])
			mirror([0, 1, 0])
			arm(holder_length = arm_length, hexagon_length = hexagon_length);
		}
	} else {
		hexagon_length = 10;
		difference(){
			union(){
				arm(holder_length = holder_length - hexagon_length, hexagon_length = hexagon_length);
				
				%translate([0, rod_distance, 0])
				mirror([0, 1, 0])
				color("gold")
				arm(holder_length = holder_length - hexagon_length, hexagon_length = hexagon_length);
			}
			translate([0, rod_distance/2, 0])
			rotate([90, 0, 0])
			polyholehires(d = carbon_rod_diameter, h = carbon_rod_length + carbon_rod_length_inset_length_extra*2, center = true);
		}
		%translate([0, rod_distance/2, 0])
		rotate([90, 0, 0])
		color("grey")
		cylinder(d = carbon_rod_diameter, h = carbon_rod_length, $fn = 16, center = true);
		
	}
}

module arm(holder_length = holder_length, hexagon_length = 0){
	difference(){
		union(){
			cylinder(d = bearing_diameter, h = bearing_thickness, center = true, $fn = 32);
			translate([0, holder_length/2, 0])
			if(hexagon_length > 0){
				hull(){
					cube([holder_width, holder_length, bearing_thickness], center = true);
					translate([0, holder_length/2 + hexagon_length, 0])
					rotate([90, 0, 0])
					hull(){
						translate([arm_rod_extra_width/2, 0, 0])
						cylinder(d = arm_rod_hexagon, h = epsilon, $fn = 6);
						translate([-arm_rod_extra_width/2, 0, 0])
						cylinder(d = arm_rod_hexagon, h = epsilon, $fn = 6);
					}
					*#cylinder(d = arm_rod_hexagon, h = epsilon, $fn = 6);
				}
			} else {
				cube([holder_width, holder_length, bearing_thickness], center = true);
			}
		}
		mirror([0, slot_direction, 0])
		translate([0, -slot_length/2, 0])
		cube([slot_thickness, slot_length, bearing_thickness + epsilon*2], center = true);
		
		sphere(d = ball_diameter + ball_tolerance*2, $fn = 64);
		
		translate([0, 0, bearing_inner_height/2])
		cylinder(d1 = bearing_inner_diameter, d2 = bearing_outer_diameter, h = bearing_outer_height, center = false, $fn = 32);
		
		cylinder(d = bearing_inner_diameter, h = bearing_inner_height + epsilon*2, center = true, $fn = 32);
		
		mirror([0, 0 ,1])
		translate([0, 0, bearing_inner_height/2])
		cylinder(d1 = bearing_inner_diameter, d2 = bearing_outer_diameter, h = bearing_outer_height, center = false, $fn = 32);
		
		*translate([0, ball_diameter/2 + holder_length/2 + (holder_length + (bearing_diameter - ball_diameter))/2 + epsilon, 0])
		rotate([90, 0, 0])
		polyholehires(d = screw_size, h = screw_length + epsilon, $fn = 16);
	}
}