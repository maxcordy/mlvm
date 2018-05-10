// Set the pole diameter in mm
pipeDiameter = 20.60;

// Set the number of spokes
numberOfFeet = 5;

// Whether to render the hub piece
printMainPiece = true;

// Whether to render the spokes
printFeet = true;

// Whether bottom of feet is flat (0) or slanted downwards slightly (-1)
feet_slant = 0;

/* [Hidden] */
bottom = pipeDiameter > 25 ? pipeDiameter + 15 : 40;
top = pipeDiameter > 25 ? pipeDiameter + 5 : 30;
distance = pipeDiameter > 25 ? pipeDiameter - 5 : 20;

scale([0.5,0.5,0.5]) {
if(printMainPiece) {
translate([0,0,-4]) {
difference() {
	union() {
		cylinder(h=80, r1=bottom, r2=top, center=true, $fn=100);
		
		for (i = [0:numberOfFeet-1]) {
			rotate([0,0,i*(360/numberOfFeet)]) {
				translate([distance+2,0,0]) {
					cube(size = [40,20,80], center = true);
				}
			}
		}
	}
	translate([0,0,5]) {
		cylinder(h=80, r1=pipeDiameter, r2=pipeDiameter, center=true, $fn = 100);
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

if(printFeet) {
translate([-100,100,000]) {
    for (i = [0:numberOfFeet-1]) {
        translate([40+distance,i*30 - 30,0]) {
            difference() {
                rotate([0,feet_slant,0]) {
                    union() {
                        translate([15,0,-0.5]) {
                            cube(size = [18,6.5,80], center = true);
                        }
                        translate([8.8,0,-0.5]) {
                            cube(size = [7,12,80], center = true);
                        }
                        translate([11,0,-42.5]) {
                            cube(size = [23,25,10], center = true);
                        }
                        translate([270,0,-2.5]) {
                            cube(size = [500,20,100], center = true);
                        }
                    }
                }
                translate([410,0,145]) {
                    rotate([90,0,0]) {
                        scale([1.1,0.45,1.0]) {
                            translate([0,6,20]) cylinder(h=30, r1=420, r2=420, center=true, $fn=360);
                            translate([0,6,-20]) cylinder(h=30, r1=420, r2=420, center=true, $fn=360);
                            translate([-5,13,0]) cylinder(h=30, r1=420, r2=420, center=true, $fn=360);
                        }

                    }
                }
                rotate([90,0,0]) {
                    hull() {
                        translate([30,25,00]) cylinder(h=30, r1=5, r2=5, center=true, $fn=10);
                        translate([30,-35,0]) cylinder(h=30, r1=5, r2=5, center=true, $fn=10);
                        translate([80,0,0]) cylinder(h=30, r1=5, r2=5, center=true, $fn=10);
                    }
                    hull() {
                        translate([120,-35,0]) cylinder(h=30, r1=5, r2=5, center=true, $fn=10);
                        translate([55,-35,0]) cylinder(h=30, r1=5, r2=5, center=true, $fn=10);
                        translate([98,-7,0]) cylinder(h=30, r1=5, r2=5, center=true, $fn=10);
                    }
                    hull() {
                        translate([240,-39,0]) cylinder(h=30, r1=2, r2=2, center=true, $fn=10);
                        translate([140,-35,0]) cylinder(h=30, r1=5, r2=5, center=true, $fn=10);
                        translate([124,-16,0]) cylinder(h=30, r1=5, r2=5, center=true, $fn=10);
                    }
                }
                
                /*
                translate([360,0,-50]) cylinder(h=6, r1=8, r2=8, center=true, $fn=10);
                translate([205,0,-50]) cylinder(h=6, r1=8, r2=8, center=true, $fn=10);
                translate([40,0,-50]) cylinder(h=6, r1=8, r2=8, center=true, $fn=10);
                */

                translate([500,0,-50]) {
                    rotate([0,-20,0]) {
                        cube(size = [80,60,60], center = true);
                    }
                }
                /* ground */
                translate([240,0,-74]) {
                     cube(size = [500,100,60], center = true);
                }
            }
        }
    }
}
}
}