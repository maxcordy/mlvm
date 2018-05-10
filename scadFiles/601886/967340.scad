height = 25.0;
width = 16.0;
hole_width = 7;
expand_part_shift = 3;
expand_gap = 5;
nut_width = 10.25;
nut_height = 5;

$fn = 100;

module tube(height, radius, wall, center = false) {
  difference() {
    cylinder(h=height, r=radius, center=center);
    cylinder(h=height, r=radius-wall, center=center);
  }
}

module hexagon(size, height) {
	boxWidth = size/1.75;
	for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}

module base(height, width, hole_width, nut_width, nut_height) {
	difference() {
		tube(height, width / 2, (width - hole_width) / 2);
		translate([0, 0, nut_height / 2]) hexagon(nut_width, nut_height);
	}
}

module expanding_part() {
	difference() {
		base(height, width, hole_width, nut_width, nut_height);
		cut_block();
	}
}

module cut_block() {
	translate([-1 * width / 2, -1 * width / 2, expand_part_shift])
		rotate([0, 20, 0])
			translate([0, 0, -1 * height])
				cube([width*2, width, 100]);
}

module push_part() {
	difference() {
		intersection() {
			base(height, width, hole_width, nut_width, nut_height);
			cut_block();
			rotate([0, 0, 180]) cut_block();
		}

		translate([0, 0, height - expand_gap + 10]) cube([20, 20, 20], true);
	}
}

translate([-3, 0, 5]) expanding_part();
translate([3, 0, 5]) rotate([0, 0, 180]) expanding_part();
push_part();

// For demostration only:
%color("PowderBlue") {
	// Nut
	translate([0, 0, -10]) 
		difference() {
			hexagon(nut_width, nut_height);
			cylinder(h = 100, r = hole_width / 2, center = true);
		}
	
	// Bolt
	translate([0, 0, 60])
		cylinder(h = 40, r = hole_width / 2, center = true);
	translate([0, 0, 80])
		hexagon(nut_width, nut_height / 1.5);
	
	// Washer
	translate([0, 0, 35])
		tube(1, width / 2, (width - hole_width) / 2);
}