phone_width = 68;
phone_depth = 9.8;
phone_clamp_width = 30;

clamp_lip = 2;
spring_deflection = 5;

clamp_meat = 2.5;

mount_base_length = 43.5;
mount_base_height = 1.6;
mount_slant_length = 35;
mount_slant_height = 8.6;
mount_width = 42.5;

//[Hidden]
// formulas
slant = (mount_base_length - mount_slant_length) / 2;
totalHeight = mount_base_height + mount_slant_height;
centerX = -mount_base_length/2;
centerY = (totalHeight+phone_width+(clamp_meat*2))/-2;

rotate([0, 0, -90]) {
	translate([centerX, centerY, 0]) {
		print();
	}
}


// Modules
module print() {
	union() {
		translate([slant, totalHeight - 0.1, 0]) {
			clamp();
		}
		base();
	}
}

module base() {
	linear_extrude(height = mount_width) {
		polygon([[0, 0], [0, mount_base_height], [slant, totalHeight], [slant + mount_slant_length, totalHeight], [mount_base_length, mount_base_height], [mount_base_length, 0]]);
	}
}

module clamp() {
	union() {
		linear_extrude(height = phone_clamp_width) {
			polygon([[0, 0], [-clamp_meat, clamp_meat], [-clamp_meat-spring_deflection, (phone_width / 2) + clamp_meat], [-clamp_meat, phone_width + clamp_meat], [0, phone_width + clamp_meat*2], [phone_depth + clamp_meat, phone_width + clamp_meat*2], [phone_depth, phone_width + clamp_meat*2], [phone_depth + clamp_meat, phone_width + clamp_meat], [phone_depth + clamp_meat, phone_width + clamp_meat - clamp_lip], [phone_depth, phone_width + clamp_meat - clamp_lip], [phone_depth, phone_width + clamp_meat], [0, phone_width + clamp_meat], [-spring_deflection, (phone_width / 2) + clamp_meat], [0, clamp_meat], [phone_depth, clamp_meat], [phone_depth, clamp_meat + clamp_lip], [phone_depth + clamp_meat, clamp_meat + clamp_lip], [mount_slant_length ,0]]);
		}
		translate([-0.001, clamp_meat -0.01, 0.01]) {
			rotate([0,0,0]) {
				roundedCorner(clamp_meat - 0.01, phone_clamp_width - 0.02);
			}
		}
		translate([-0.001, phone_width + clamp_meat -0.01, 0.01]) {
			rotate([0, 0, 270]) {
				roundedCorner(clamp_meat - 0.01, phone_clamp_width - 0.02);
			}
		}
		translate([phone_depth + 0.01, phone_width + clamp_meat + 0.01, 0.01]) {
			rotate([0, 0, 180]) {
				roundedCorner(clamp_meat - 0.01, phone_clamp_width - 0.02);
			}
		}
	}
}

module roundedCorner(radius, height) {
	intersection() {
		linear_extrude(height = height) {
			circle(radius);
		}
		translate([-radius, -radius,-0.01]) {
			linear_extrude(height = height + 0.02) {
				square([radius, radius], center=false);
			}
		}
	}
}