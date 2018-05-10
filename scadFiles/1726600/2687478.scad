inside_dim = [10, 3, 40];
wall = 2;

$fn=50; 

module footprint(inside_dim) {
	cube(inside_dim);
	translate([inside_dim[0]/2, 0, inside_dim[2]])
		rotate([-90,0,0])
		cylinder(h=inside_dim[1], r=inside_dim[0]/2);
}

difference() {
	minkowski() {
		footprint(inside_dim);
		sphere(r=wall);
	}
	footprint(inside_dim);
	translate([-wall, -wall, 0])
		mirror([0,0,1])
		cube(inside_dim + [2*wall, 2*wall, 0]);
}
