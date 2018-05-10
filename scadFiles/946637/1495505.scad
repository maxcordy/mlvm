//length of whole
a = 58.0;

//width of whole
b =  6.1;

//middle part thickness
c =  1.0;

//length of middle section
d = 18.0;

//tap valley thickness
e =  1.5;

//height of taps
f =  2.7;


difference() {
	union() {
		translate([0, 0, c/2])
		cube([a, b, c], center=true);
		
		for(m = [0, 1])
		mirror([m, 0, 0])
		translate([a/2-d/2, 0, f/2])
		cube([d, b, f], center=true);
	} //union
	
	for(m = [0, 1])
	mirror([m, 0, 0])
	for(g = [0, 5, 10, 15])
	translate([a/2-g, 0, 0])
	union() {
		translate([0, -b/2-1, f-(f-e)])
		cube([2, b+2, f-e+1], center=false);
		
		translate([0, -b/2-1, f-(f-e)])
		rotate([0, -59, 0])
		cube([2, b+2, 10], center=false);
	}
}
