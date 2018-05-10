$distance = 30;
width = 20;
height = 40;
inset = 6;

// 20, 40, 6

rotate([90,0,0]) {
// main clamp
difference() {
    cube(size = [width+4,20,height+4], center = true);
    cube(size = [width,30,height], center = true);
    translate([-(width/2)-(inset/2),0,-(height*3/4)-(inset/2)]) {
        cube(size = [width,30,height], center = true);
    }
    
    // chamfered edges
	/*
    translate([29.5,0,-25.5]) rotate([0,45,0]) cube(size = [5,25,5], center = true);
    translate([-30,0,25.5]) rotate([0,45,0]) cube(size = [5,25,5], center = true);
    translate([-30,0,11]) rotate([0,45,0]) cube(size = [5,25,5], center = true);
	*/

}

// chamfered inner edge
//translate([27,0,-22.5]) rotate([0,45,0]) cube(size = [2,20,2], center = true);

// hook left top
translate([-width/2, 0, height/4]) {
	hull() {
		cube(size = [2,20,4], center = true);
		translate([3,0,0]) rotate([90,0,0]) cylinder(h=20,d=4,center=true);
	}
}
// hook left bottom
translate([-width/2, 0, -height/4]) {
	hull() {
		cube(size = [2,20,4], center = true);
		translate([3,0,0]) rotate([90,0,0]) cylinder(h=20,d=4,center=true);
	}
}
// hook bottom middle
translate([0, 0, -height/2]) {
	rotate([0,-90,0]) hull() {
		cube(size = [2,20,4], center = true);
		translate([3,0,0]) rotate([90,0,0]) cylinder(h=20,d=4,center=true);
	}
}

// spool guide
translate([width/2+2,0,((height-29)/2)+2]) {
    difference() {
        hull() {
            cube(size = [1,20,29], center = true);
            translate([$distance,0,0]) {
                cylinder(h=29, r1=10, r2=10, center=true, $fn=40);
            }
        }
        
        hull() {
            translate([$distance-15,0,10]) {
                rotate([90,0,0]) {
                    cylinder(h=29, r1=2, r2=2, center=true, $fn=55);
                }
            }
            translate([2,0,10]) {
                rotate([90,0,0]) {
                    cylinder(h=29, r1=2, r2=2, center=true, $fn=55);
                }
            }
            translate([2,0,-5]) {
                rotate([90,0,0]) {
                    cylinder(h=29, r1=2, r2=2, center=true, $fn=55);
                }
            }
        }
        hull() {
            translate([$distance-10,0,5]) {
                rotate([90,0,0]) {
                    cylinder(h=29, r1=2, r2=2, center=true, $fn=55);
                }
            }
            translate([$distance-10,0,-10]) {
                rotate([90,0,0]) {
                    cylinder(h=29, r1=2, r2=2, center=true, $fn=55);
                }
            }
            translate([7,0,-10]) {
                rotate([90,0,0]) {
                    cylinder(h=29, r1=2, r2=2, center=true, $fn=55);
                }
            }
        }
        
        translate([$distance,0,0]) {
            cylinder(h=90, r1=2, r2=2, center=true, $fn=40);
        }
        translate([$distance,0,-18]) {
            cylinder(h=20, r1=40, r2=1, center=true, $fn=40);
        }
        translate([$distance,0,-15]) {
            cylinder(h=20, r1=20, r2=1, center=true, $fn=40);
        }
        translate([$distance,0,15]) {
            cylinder(h=20, r1=3.16, r2=3.25, center=true, $fn=40);
        }
        translate([$distance,0,16.5]) {
            cylinder(h=10, r1=1, r2=10, center=true, $fn=40);
        }
    }
}
}