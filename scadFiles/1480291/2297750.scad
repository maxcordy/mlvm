$screw_distance = 16.5;


rotate([-187,0,0]) {
difference() {
	// basic block
	cube([80, 70, 50], true);
	
	// circular hole for showerhead
	translate([0, 10, 0]) {
		rotate([25,0,0]) {
			cylinder(65, 9, 12.7, true);
		}
	}
	translate([0, -27, 0]) {
		rotate([25,0,0]) {
			cube([18, 70, 100], true);
		}
	}
	
	// front edge cutoff bottom
	translate([0, -27, 0]) {
		rotate([25,0,0]) {
			cube([90, 50, 100], true);
		}
	}
	// front edge cutoff top
	translate([0, -45, 0]) {
		rotate([-30,0,0]) {
			cube([90, 50, 100], true);
		}
	}
	
	// side cutoff left
	translate([-60, 0, 0]) {
		rotate([30,-10,10]) {
			cube([90, 100, 100], true);
		}
	}
	
	// side cutoff left front
	translate([-60, 0, 0]) {
		rotate([30,-10,20]) {
			cube([90, 100, 100], true);
		}
	}
	
	// side cutoff left top
	translate([-60, 0, 25]) {
		rotate([30,10,10]) {
			cube([90, 100, 100], true);
		}
	}
	
	// side cutoff right
	translate([60, 0, 0]) {
		rotate([30,10,-10]) {
			cube([90, 100, 100], true);
		}
	}
	
	// side cutoff right front
	translate([60, 0, 0]) {
		rotate([30,10,-20]) {
			cube([90, 100, 100], true);
		}
	}

	// side cutoff right top
	translate([60, 0, 25]) {
		rotate([30,-10,-10]) {
			cube([90, 100, 100], true);
		}
	}
	
	// top cutoff
	translate([0, -10, 70]) {
		rotate([7,0,0]) {
			cube([90, 120, 100], true);
		}
	}
	
	// screw inset top
	translate([0, 20, 10]) {
		rotate([90,0,0]) {
			cylinder(  50,    2.25,    2.25, true);
		}
	}
	translate([0, 21, 10]) {
		rotate([90,0,0]) {
			cylinder(  20,    9,    9, true);
		}
	}
	
	// screw inset bottom
	translate([0, 20, 10-$screw_distance]) {
		rotate([90,0,0]) {
			cylinder(  50,    2.25,    2.25, true);
		}
	}
	translate([0, 21, 10-$screw_distance]) {
		rotate([90,0,0]) {
			cylinder(  20,    9,    9, true);
		}
	}
}
}