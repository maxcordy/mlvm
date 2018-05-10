cube_size = 20; // [10:Small,20:Medium,30:Large]

hole_diameter = 2.5;
hole_radius = hole_diameter/2;

// How deep should the center hole be?
hole_depth = 1; // [0,1,5,50]

show_wheels = "yes"; // [yes,no]

// How thick should the side wheels be?
wheel_thickness = 1; // [1:20]

// ignore this variable!
// foo=1;

// don't turn functions into params!
function BEZ03(u) = pow((1-u), 3);

// ignore variable values
bing = 3+4;
baz = 3 / hole_depth;

difference() {
  union() {
    translate([0, 0, cube_size/2]) cube([cube_size,cube_size,cube_size], center=true);
    if (show_wheels == "yes") {
      translate([0, 0, cube_size/2]) rotate([0, 90, 0]) {
        cylinder(r=cube_size/2, h=cube_size+(wheel_thickness*2), center=true);
      }
    }
  }
  translate([0, 0, cube_size-hole_depth]) cylinder(r=hole_radius, h=hole_depth);
}          

module example001()
{
	function r_from_dia(d) = d / 2;

	module rotcy(rot, r, h) {
		rotate(90, rot)
			cylinder(r = r, h = h, center = true);
	}

	difference() {
		sphere(r = r_from_dia(size));
		rotcy([0, 0, 0], cy_r, cy_h);
		rotcy([1, 0, 0], cy_r, cy_h);
		rotcy([0, 1, 0], cy_r, cy_h);
	}

	size = 50;
	hole = 25;

	cy_r = r_from_dia(hole);
	cy_h = r_from_dia(size * 2.5);
	import("C:\Users\gtao\Dropbox\Mattr\STLs-stunnaShades\v0_drew\rim_old.stl")
}

//example001();

