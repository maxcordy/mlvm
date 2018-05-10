// configurable screw cap

cap_diameter = 32.2;
cap_height = 13.2;

thread_number_of_windings = 2.5;
thread_winding_distance = 3.6; // pitch
thread_spiral_resolution = 8;
thread_spiral_offset = 2.7;
thread_thread_thickness = 1.6;
thread_thread_height = 0.7;

resolution = 60;



difference() {
	cylinder(h=cap_height+2,d=cap_diameter+8, center=false, $fn=10);
	
	translate([0,0,-2]) cylinder(h=cap_height+2,d=cap_diameter, center=false, $fn=resolution);
}

degrees = (360/2) * thread_number_of_windings;
distance = thread_winding_distance/(360/2);
winding_center_offset_1 = (cap_diameter/2)-thread_thread_height;
winding_center_offset_2 = (cap_diameter/2)+1;
for ( z = [1:degrees]) {
	hull() {
		translate([0,0,thread_spiral_offset + (z*distance)]) {
			rotate([0,0,z*2]) {
					translate([winding_center_offset_1,0,0]) sphere(thread_thread_thickness/2, $fn=thread_spiral_resolution);
					translate([winding_center_offset_2,0,0]) sphere(thread_thread_thickness/2, $fn=thread_spiral_resolution);
			}
		}
		translate([0,0,thread_spiral_offset + ((z+1)*distance)]) {
			rotate([0,0,(z+1)*2]) {
					translate([winding_center_offset_1,0,0]) sphere(thread_thread_thickness/2, $fn=thread_spiral_resolution);
					translate([winding_center_offset_2,0,0]) sphere(thread_thread_thickness/2, $fn=thread_spiral_resolution);
			}
		}
	}
}