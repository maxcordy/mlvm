use <utils/build_plate.scad>


$fn=100*1;

//of the ring in mm:
Inside_Diameter = 50; //[10:100]

//in mm:
Ring_Thickness = 5; //[1:10]

//these cutouts may be used to style the ring.  It may also facilitate cutting the ring in the event it may not be removed in the conventional manner.
Number_of_Cutouts = 4; //[0:10]






//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);







inside_d = Inside_Diameter;
inside_r = inside_d/2;

ring_d = Ring_Thickness;
ring_r = ring_d/2;

outside_d = inside_d+ring_d*2;
outsie_r = outside_d/2;

middle_d = (inside_d+outside_d)/2;
middle_r = middle_d/2;

weaklinks_count = Number_of_Cutouts;
weaklinks_rotate = 360/weaklinks_count;

weaklink_ring_d = ring_d*0.25;
weaklink_ring_r = weaklink_ring_d/2;

weaklink_middel_d = ring_d;
weaklink_middel_r = weaklink_middel_d/2;

translate([0,0,ring_r])  {
	difference() {
		ring();
		weaklinks();
	}
}

module ring () {
	rotate_extrude(convexity = 10)
		translate([middle_r, 0, 0])
			circle(r = ring_r,$fn=100);
}


module weaklinks() {

	for (i=[1:weaklinks_count]) {
		rotate([0,0,weaklinks_rotate*i])
			weaklink ();
	}
}
 
module weaklink () {
	translate([middle_r,0,0])
		rotate(90,[1,0,0])
			rotate_extrude(convexity = 10)
				translate([weaklink_middel_r, 0, 0])
					circle(r = weaklink_ring_r,$fn=100);
}


