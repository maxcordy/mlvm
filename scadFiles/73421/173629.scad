top_width = 20; //mm
top_hole = 10; //mm
bottom_width = 20; //mm
bottom_hole = 10; //mm
hole_distance = 200;
middle_hole_a = top_hole-(top_hole*0.3);
middle_hole_b = bottom_hole-(bottom_hole*0.3);
thickness = 10; //mm

difference() {
      hull() {translate([hole_distance,0,0]) cylinder (h=thickness, r=bottom_width, $fn=100);
      cylinder (h=thickness, r=top_width, $fn=100);
		}
	cylinder (h=thickness+1, r=top_hole, $fn=100);
	translate ([hole_distance,0,0]) cylinder (h=thickness+1, r=bottom_hole, $fn=100);
	translate ([(top_hole*2)+10,0,0]) hull() {translate([(hole_distance-bottom_hole*2)-((top_hole*2)+10)-10,0,0]) cylinder (h=thickness+1, r=middle_hole_b, $fn=100);
      cylinder (h=thickness+1, r=middle_hole_a, $fn=100);
	}
}