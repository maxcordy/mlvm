// paramaters
box_width = 68;
box_length = 46;
base_height = 17;

lid_height = 10;

wall_thickness = 1.5; // 1, 2 or 3x  your extrusion width is a good idea
slop = 0.5;

spacing_between_parts = 3;

// [Hidden]
// formulas
lid_extra_dimen = (wall_thickness + slop) * 2;
lid_width = box_width + lid_extra_dimen;
lid_length = box_length + lid_extra_dimen;



print();

/////////////////////////////////////////////////////////////////////////////
//										//
//				Models					//
//										//
/////////////////////////////////////////////////////////////////////////////

module print() {
	box(box_width, box_length, base_height);
	translate([box_width + wall_thickness + slop, -spacing_between_parts, 0]) {
		rotate([0, 0, 180]) {
			box(lid_width, lid_length, lid_height);
		}
	}
}

module closed() {
	box(box_width, box_length, base_height);
	translate([box_width + wall_thickness + slop, -(wall_thickness + slop), base_height + wall_thickness]) {
		rotate([0, 180, 0]) {
			box(lid_width, lid_length, lid_height);
		}
	}
}

module nested() {
	translate([0, 0, wall_thickness]) {
		box(box_width, box_length, base_height);
	}
	translate([-(wall_thickness + slop), -(wall_thickness + slop), 0]) {
		box(lid_width, lid_length, lid_height);
	}
}

/////////////////////////////////////////////////////////////////////////////
//										//
//				Parts						//
//										//
/////////////////////////////////////////////////////////////////////////////

module box(width, length, height) {
	difference() {
		linear_extrude(height = height) {
			boxProfile(width, length);
		}
		translate([wall_thickness, wall_thickness, wall_thickness]) {
			linear_extrude(height = height) {
				boxProfile(width - wall_thickness * 2, length - wall_thickness * 2);
			}
		}
	}
}

module boxProfile(width, length) {
	square([width, length - width / 2]);
	intersection() {
		square([width, length]);
		translate([width / 2, length - width / 2, 0]) {
			circle(width/2);
		}
	}
}