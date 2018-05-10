/* [everything in mm] */
battrery_type = [10,44]; //[AA, AAA, 18650, Custom]
custom_dia = 18; //[2:50]
custom_length = 65; //[10:250]
//of walls:
thickness = 2;
//around battery:
margin = 1.0; //[0:3]
//it should hold:
batteries = 9; //[2:40]

// resolution (# of segments per 20mm):
curve = 6; //[1:20]

/* HIDDEN */

battrery_size = battrery_type == "AA"? [10, 44] : 
                battrery_type == "AAA"? [14, 50] : 
                battrery_type == "18650"? [18, 65] : 
                [custom_dia, custom_length];

battery_r = battrery_size[0] / 2 + margin;
width = battrery_size[1] + margin * 2;

use<grid.scad>

$fn = curve * 4;

////////////////////////////////////////////////////////////////////////////////////////////////

module battery(outline = false) {
	rotate([0, 90, 0])
	{
		if(outline) {
			#%translate([0, 0, 0])
			cylinder(r = battery_r, h = battrery_size[1] + margin * 2);
		} else {
			color([0, 0.4, 1]) translate([0, 0, 0.1])
			cylinder(r = battrery_size[0] / 2, h = battrery_size[1] - 1.1);
			color("white") cylinder(r = battrery_size[0] / 2.5, h = 1);
			translate([0, 0, battrery_size[1] - 2])
			color("white") cylinder(r = battrery_size[0] / 6, h = 2, $fn = $fn / 2);
		}
	}
}

module outside(height) {
	difference() {
		translate([-thickness, -battery_r - thickness, 0])
		cube([width + thickness * 2, battery_r * 3 + thickness * 2, height]);

		translate([-thickness - 1, battery_r + thickness, battery_r * 2 + thickness * 2])
		cube([width + thickness * 2 + 2, battery_r * 2, height]);
	}

	translate([-thickness, battery_r * 2 + thickness, battery_r + thickness])
	rotate([0, 90, 0])
	cylinder(h = width + thickness * 2, r = battery_r + thickness);

*	translate([-thickness, battery_r + thickness, battery_r + thickness])
	cube([width + thickness * 2, battery_r * 2 + thickness, battery_r + thickness]);
}

module inside(height) {
	difference() {
		difference() {
			translate([0, -battery_r, thickness])
			cube([width, battery_r * 3 + thickness, height]);

			difference() {	
			translate([-1, battery_r, battery_r * 2 + thickness])
			cube([width + 2, battery_r * 2, height]);
				difference() {
					translate([-2, battery_r + thickness, battery_r * 2 + thickness * 2])
					rotate([180, 0, 0])
					cube([width + 4, thickness + 1, thickness + 1]);

					translate([-3, battery_r + thickness, battery_r * 2 + thickness * 2])
					rotate([0, 90, 0])
					cylinder(h = width + 6, r = thickness);
				}
			}
		}	

		difference() {
			translate([-1, battery_r + thickness, battery_r * 2 + thickness * 2])
			rotate([180, 0, 0])
			cube([width + 2, battery_r * 2 + thickness + 1, battery_r * 2 + thickness + 1]);

			translate([-2, battery_r + thickness, battery_r * 2 + thickness * 2])
			rotate([0, 90, 0])
			cylinder(h = width + 4, r = battery_r * 2 + thickness, $fn = $fn * 2);
		}
	}

	translate([0, battery_r * 2 + thickness, battery_r + thickness])
	rotate([0, 90, 0])
	cylinder(h = width, r = battery_r);

	translate([0, battery_r + thickness, battery_r + thickness])
	cube([width, battery_r * 2, battery_r + thickness * 2]);
}


module battery_dispenser(height) {
	difference() {
		outside(height);

		inside(height);

		translate([width / 5, -battery_r - thickness - 1, -1])
		cube([width - width / 5 * 2, battery_r * 4 + thickness * 3 + 2,height + 2]);
	}

	difference() {
		translate([width + thickness, -battery_r - thickness, 0])
		rotate([0, 0, 180])
		cube([thickness * 2 + width, height / 4, thickness]);

		translate([width - thickness * 2, -battery_r - thickness + 1, -1])
		rotate([0, 0, 180])
		cube([width - thickness * 4, height / 4 - thickness * 3 + 1, thickness + 2]);
	}

	scale([1, -1])
	translate([0, -battery_r - thickness, 0])
	cube([width, thickness * 3, thickness]);

	translate([0, -battery_r - thickness, height - thickness * 3])
	cube([width, thickness, thickness * 3]);

	translate([0, -battery_r - thickness, height / 2 - thickness * 3])
	cube([width, thickness, thickness * 3]);
}

////////////////////////////////////////////////////////////////////////////////////////////////

anim_y = [
	[1, battery_r * 2 + thickness],
	[2, battery_r * 2 + thickness - battrery_size[0]],
	[2.5, battery_r - battrery_size[0] / 2],
	[3, 0],
];

anim_z = [
	[0, thickness * 2 + battery_r * 3],
	[1, thickness + battery_r],
	[2, thickness + battery_r],
	[2.5, thickness + battrery_size[0]],
	[3, thickness + battery_r + battrery_size[0]],
	[batteries, thickness + battery_r + battrery_size[0] * 8]
];


if ($t > 0)
translate([margin, lookup((1 - $t) * batteries, anim_y), lookup((1 - $t) * batteries, anim_z)])
battery();	

height = thickness + battrery_size[0] * (batteries - 1);
echo(str("height: ", height));

rotate(180)
battery_dispenser(height);


//rotate([0, 90, 0])
//grid(1, 0.15, 40);
