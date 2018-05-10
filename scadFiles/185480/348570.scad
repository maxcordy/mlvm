$fn=30;
d = 5.3;			// smallest inner diameter in "neck-hole" (twice the radius)
cyl = 3.3;		// outer radius of neck cylinder
neckd = 9; 		// depth of the "neck-hole"
notch = 0.01; 	// small unit for extra cut-outs to make them unambiguous

debug = 0; // add some objects to show measurements


//cylinder( h = 4.5, r = 6, center=true);
//cube ( [10, 10, .5], center=true);
//translate( [10,0,-4]) cylinder( h=9, r=5);

///// head
if(1)
difference() {
	union(){
		// The head is contained in a cylinder with radius 5 and height 8, shifted
		// 1 unit upwards (z-coordinates from -3 to +5)
	   translate([0,0,1])
		minkowski() {
			cylinder( h = 4.5, r = 3.25, center=true);
			sphere( r=1.75, center=true);
		}
		
		// add a "chin" to prevent horizontal overhang
		// the 3.7 number was tweaked from its original 3.25 value
		translate([0,0,-4]) cylinder( h=1.1, r1 = cyl, r2 = 3.7);
	}
	
	// cut out a cylinder that will be filled
	// with the neck part
	translate ([0,0,-1]) cylinder( h=8, r=cyl, center=true);
}

if (debug)
{
	translate([6,0,-3]) cylinder( r=.5, h=3);
	translate([-6,0,0]) cylinder( r=.5, h=5);
	translate([0,0,6]) cylinder( r=5, h=1);
	translate([0,6,0]) cylinder( r=.5, h=neckd, center=true);
}

///// neck
// first, a cylinder with "square" cut-out
if (1)
	difference() {
		cylinder( h=neckd, r=cyl, center=true);
		cube( size = [d, d, neckd + notch], center= true);
	}

// then, add a cylinder to soften the edges of the square.
if (1)
	difference() {
		cylinder( h=neckd, r=cyl, center=true);
		cylinder( h=neckd+notch, r=2.9, center=true);	
	};

