// Which part to render
 part = "everything"; // [everything:Everything,main_piece:Main Part,feet:All Feet,foot:One Foot]


// Pole diameter in mm
pipeDiameter = 16.0;

// Number of spokes
numberOfFeet = 5; // [3:7]

// Length of an individual foot in mm
footLength = 250;

// Style of cutout in the feet; "none" is recommended. If you want to use less plastic, change the infill in your slicer
cutoutStyle = "none"; // [none, circles]

// Resolution of the circles in the model; smaller renders faster, higher looks better
resolution = 100;

/* [Hidden] */

// Whether to render the hub piece
printMainPiece = true;

// Whether to render the spokes
printFeet = true;

bottom = pipeDiameter > 25 ? pipeDiameter + 15 : 40;
top = pipeDiameter > 25 ? pipeDiameter + 5 : pipeDiameter + 8;
distance = pipeDiameter > 25 ? pipeDiameter - 5 : 20;


module MainPiece() {
	translate([0,0,-4]) {
		difference() {
			union() {
				translate([0,0,20]) cylinder(h=120, r1=bottom, r2=top, center=true, $fn=100);
				
				for (i = [0:numberOfFeet-1]) {
					rotate([0,0,i*(360/numberOfFeet)]) {
						translate([distance+2,0,0]) {
							cube(size = [40,20,80], center = true);
						}
					}
				}
			}
			translate([0,0,5+20]) {
				cylinder(h=120, r1=pipeDiameter, r2=pipeDiameter, center=true, $fn = resolution);
			}
			for (i = [0:numberOfFeet-1]) {
				rotate([0,0,i*(360/numberOfFeet)]) {
					translate([distance+2,0,0]) {
						translate([16,0,-5]) {
							cube(size = [20,8,80], center = true);
						}
						translate([9,0,-5]) {
							cube(size = [8,14,80], center = true);
						}
					}
				}
			}
		}
		for (i = [0:numberOfFeet-1]) {
			rotate([0,0,i*(360/numberOfFeet)+(360/numberOfFeet/2)]) {
				translate([distance+10,0,-20]) {
					hull() {
						rotate([-90,0,0]) {
							translate([0,0,0]) cylinder(h=2, r1=2, r2=2, center=true, $fn=10);
							translate([-10,-5,0]) cylinder(h=2, r1=2, r2=2, center=true, $fn=10);
							translate([-7,-50,0]) cylinder(h=2, r1=2, r2=2, center=true, $fn=10);
						}
					}
				}
			}
		}
	}
}

module Foot(offset) {
	footSize = footLength*2;
	
	translate([40+distance,offset*30 - 30,0]) {
		difference() {
			union() {
				// attachment (front piece)
				translate([15,0,-0.5]) {
					cube(size = [18,6.5,80], center = true);
				}
				// attachment (back piece)
				translate([8.8,0,-0.5]) {
					cube(size = [7,12,80], center = true);
				}
				// attachment (bottom bit)
				translate([11,0,-42.5]) {
					cube(size = [23,25,10], center = true);
				}
				hull() {
					translate([25,0,-2.5]) {
						cube(size = [10,20,84], center = true);
					}
					
					translate([footSize,0,-40]) {
						cube(size = [10,20,10], center = true);
					}
				}
			}
			
			/* ground */
			translate([240,0,-74]) {
				 cube(size = [footSize*2,100,60], center = true);
			}
			
			if(cutoutStyle == "circles") {
				for(i = [50 : 30 : footLength]) {
					translate([i*2-20,0,(((footLength-i)/footLength)*40)-40]) rotate([90,0,0]) cylinder(h=120, r=((footLength-i)/footLength)*35, center=true, $fn = resolution);
				}
			}
		}
	}
}

module Feet() {
	translate([-100,100,000]) {
		for (i = [0:numberOfFeet-1]) Foot(i);
	}
}

scale([0.5,0.5,0.5]) {
	if(part == "everything" || part == "main_piece") MainPiece();
	if(part == "everything" || part == "feet") if(printFeet) Feet();
	if(part == "foot") if(printFeet) Foot(0);
}