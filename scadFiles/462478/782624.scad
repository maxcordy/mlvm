
/* [Bezier Vase] */

// Diameter of base. (mm)
base_diameter = 40;

// Height of vase. (mm)
vase_height = 60;

// Size of waist as percentage of base diameter. Widest part of vase will be at least this wide but may be wider. (%)
waist_size = 140; // [0:200]

// Size of neck as percentage of base diameter. Narrowest part of vase will be at least this narrow but may be narrower. (%)
neck_size = 85; // [0:200]

// Size of opening at top of vase as percentage of base diameter. (%)
top_size = 95; // [0:200]

// Height of waist as percentage of vase height. Should be less than neck height. (%)
waist_height = 40; // [0:100]

// Height of neck as percentage of vase height. Should be greater than waist height. (%)
neck_height = 66; // [0:100]

/* [Resolution] */

// Higher values yield a smoother Bezier curve profile. 
vertical_resolution = 40;

// Higher values yield smoother circumferences.
radial_resolution = 60;

// Set to 0 for a solid volume. (mm)
wall_thickness = 0; // [0:10]

/* [Hidden] */

/*
 * So the top, neck, waist, and base dimensions above
 * are used to define points on the profile of the vase.
 * A cubic Bezier curve is fit to pass through all four.
 * Note that the neck and waist are not necessarily the
 * narrowest and widest points, respectively - the curve
 * may have to pass further in or out to pass through them.
 *
 * |---------+    top
 * |       /           
 * |     /
 * |----+         neck
 * |      \
 * |         \
 * |           \    
 * |------------+ waist
 * |            |     
 * |           /
 * |         /
 * |--------+     base
 *                 
 */

// base
x0 = base_diameter/2;
y0 = 0;

// waist
x1 = x0 * waist_size/100;
y1 = waist_height/100 * vase_height;

// neck
x2 = x0 * neck_size/100;
y2 = neck_height/100 * vase_height;

// mouth
x3 = x0 * top_size/100;
y3 = vase_height;

// Control point coordinates
// https://web.archive.org/web/20131225210855/http://people.sc.fsu.edu/~jburkardt/html/bezier_interpolation.html
p0x = x0;
p0y = y0;
p1x = ((-5 * x0) + (18 * x1) - ( 9 * x2) + (2 * x3)) / 6;
p1y = ((-5 * y0) + (18 * y1) - ( 9 * y2) + (2 * y3)) / 6;
p2x = (( 2 * x0) - ( 9 * x1) + (18 * x2) - (5 * x3)) / 6;
p2y = (( 2 * y0) - ( 9 * y1) + (18 * y2) - (5 * y3)) / 6;
p3x = x3;
p3y = y3;

// Bezier curve function coefficients
a = p3x - (3 * p2x) + (3 * p1x) -      p0x;
b =       (3 * p2x) - (6 * p1x) + (3 * p0x);
c =                   (3 * p1x) - (3 * p0x);
d =                                    p0x;
e = p3y - (3 * p2y) + (3 * p1y) -      p0y;
f =       (3 * p2y) - (6 * p1y) + (3 * p0y);
g =                   (3 * p1y) - (3 * p0y);
h =                                    p0y;

// Bezier curve functions
function bzx(t) = (a * t * t * t) + (b * t * t) + (c * t) + d;
function bzy(t) = (e * t * t * t) + (f * t * t) + (g * t) + h;

union() {
	for (i = [0:vertical_resolution-1]) {
		assign(tbot = i / vertical_resolution, ttop = (i + 1) / vertical_resolution) {
			rotate_extrude($fn=radial_resolution) polygon(points=[
				[wall_thickness > 0 ? bzx(tbot) - wall_thickness : 0, bzy(tbot)],
				[bzx(tbot), bzy(tbot)],
				[bzx(ttop), bzy(ttop)],
				[wall_thickness > 0 ? bzx(ttop) - wall_thickness : 0, bzy(ttop)]
			]);
		}
	}
	if (wall_thickness > 0) {
		rotate_extrude($fn = radial_resolution) polygon(points=[
			[0, 0],
			[bzx(0) - wall_thickness/2, 0],
			[bzx(wall_thickness/vase_height) - wall_thickness/2, bzy(wall_thickness/vase_height)],
			[0, bzy(wall_thickness/vase_height)]
		]);
	}
}

