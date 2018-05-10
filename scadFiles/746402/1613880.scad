// 3up e3d v6 mount
// (c) by dieck, March 2015

// Licensed under the Creative Commons - Attribution-ShareAlike 4.0 International


// What part do you want to view?
preview_part = 3; // [1:Bottom Part,2:Top Part,3: Full Assembly UNUSABLE PRINTED!,4: Fan Duct]

// Use slightly bigger fittings, to counter shrinkage at printing.
oversize = 2; // [0: No, 1: Oversize by 0.2, 2: Oversize by 0.3]

include <MCAD/nuts_and_bolts.scad>;


if (preview_part == 1) {
	bottom_half();
}
if (preview_part == 2) {
	top_half();
} 
if (preview_part == 3) {
	translate([0,0,6]) full_assembly();
    // add fan duct here - full assembly is cut into bottom and top half later on.
    fanduct();
    
} 

if (preview_part == 4) {
	rotate([45,0,0]) rotate([0,-90,0]) fanduct();
    // translate([-30, -8, 18.01]) color([0,0,0,0.25]) cube([60,30,0.1]);
} 


$fn = 360;

module base_plate_with_holes() {
    difference() {
        // base plate
        cube([50,44,6], center=true);
        union() {
            // m3 holes
            translate([-31/2, -31/2, 0]) cylinder(7, r=1.6, center=true);
            translate([+31/2, -31/2, 0]) cylinder(7, r=1.6, center=true);
            translate([-31/2, +31/2, 0]) cylinder(7, r=1.6, center=true);
            translate([+31/2, +31/2, 0]) cylinder(7, r=1.6, center=true);
            
            // screw heads
            translate([-31/2, -31/2, +4/2]) cylinder(4, r=2.75, center=true);
            translate([+31/2, -31/2, +4/2]) cylinder(4, r=2.75, center=true);
            translate([-31/2, +31/2, +4/2]) cylinder(4, r=2.75, center=true);
            translate([+31/2, +31/2, +4/2]) cylinder(4, r=2.75, center=true);
        }
    }
}


module e3dv6_head() {
    
    if (oversize == 2) {
        // e3d v6 assembly
        // oversize prominent parts by 0.3 (& radius 0.3) for easier fit
        union() {
            translate([0, 4, 0]) rotate([90,0,0]) cylinder(4.1, r=8.3);
            translate([0, 4+5.4, 0]) rotate([90,0,0]) cylinder(5.4, r=6.3); // 6 -.2mm left -.2mm right
            translate([0, 4+5.4+3.3, 0]) rotate([90,0,0]) cylinder(3.3, r=8.3);
        
            // for OpenSCAD preview rendering
            color([0,1,1], 0.25) translate([0,15.69,0]) rotate([90,0,0]) cylinder(15.7, r=6.3);
            color([0,1,1], 0.25) translate([0,15.69, 0]) rotate([90,0,0]) cylinder(3, r=8.3);
        }
        
    } else if (oversize == 1) {
        // e3d v6 assembly
        // oversize prominent parts by 0.2 (& radius 0.2) for easier fit
        union() {
            translate([0, 3.9, 0]) rotate([90,0,0]) cylinder(3.9, r=8.2);
            translate([0, 3.9+5.6, 0]) rotate([90,0,0]) cylinder(5.6, r=6.2); // 6 -.2mm left -.2mm right
            translate([0, 3.9+5.6+3.2, 0]) rotate([90,0,0]) cylinder(3.2, r=8.2);
        
            // for OpenSCAD preview rendering
            color([0,1,1], 0.25) translate([0,15.69,0]) rotate([90,0,0]) cylinder(15.7, r=6.2);
            color([0,1,1], 0.25) translate([0,15.69, 0]) rotate([90,0,0]) cylinder(3, r=8.2);
        }
        
    } else {
        
        union() {
            translate([0, 3.7, 0]) rotate([90,0,0]) cylinder(3.7, r=8);
            translate([0, 3.7+6, 0]) rotate([90,0,0]) cylinder(6.0, r=6);
            translate([0, 3.7+6+3, 0]) rotate([90,0,0]) cylinder(3.0, r=8);
        
            // for OpenSCAD preview rendering
            color([0,1,1], 0.25) translate([0,15.69,0]) rotate([90,0,0]) cylinder(15.7, r=6);
            color([0,1,1], 0.25) translate([0,15.69, 0]) rotate([90,0,0]) cylinder(3, r=8);
        }
        
    }
}

module mount_head() {
    // mount head
    difference() {

        union() {
            difference() {
                union() {
                    // big block
                    translate([0,5,(22/2)-1.5]) cube([50, 14, 22+3], center=true);
                    // bottom block
                    // 5 + 14/2 + 3/2 = 13.5
                    translate([0,13.5,9.5]) cube([22, 3, 25], center=true);
                    // 45° angles
                    translate([11,12,9.5]) rotate([0,0,45]) cube([sqrt(18),sqrt(18),25], center=true);
                    translate([-11,12,9.5]) rotate([0,0,45]) cube([sqrt(18),sqrt(18),25], center=true);
                }
                // just a slice off. if I make a thinner head base, I would have to recalculate all distances, and I'm just lazy now ;)
                translate([0,-1.01,12]) cube([50,2,24], center=true);
            }
            
            // 45° hold
            rotate([45,-0.01,0]) cube([50,18,8], center=true);
        }
        
        union() {
            // top hole
            translate([0,0.05,12]) rotate([90,0,0]) cylinder(5.1, r=5, center=true);
            
            translate([0,2.5,12]) e3dv6_head();
            
            // tilted edges
            translate([-25,5,16]) rotate([0,15,0]) cube([10,30,40], center=true);
            translate([25,5,16]) rotate([0,-15,0]) cube([10,30,40], center=true);
            
            // remove 45° part below the base
            translate([0,0,-8]) cube([55,55,10],center=true);

            
        }
    }
}


module full_assembly() {

    difference() {
        union() {
            // again, the translation is me being lazy ;)
            translate([0,0,-6]) base_plate_with_holes();
            mount_head();
        }
        union() {
            // m3 holes
            translate([-12,6,10]) cylinder(40, r=1.6, center=true);
            translate([12,6,10]) cylinder(40, r=1.6, center=true);
            
            // m3 screw head holes
            // 6mm base plate + 22mm mount head = 28mm, leave 1mm at bottom
            // => countersink 2mm for using m3 x 25
            // not visible if displaying only bottom part!
            translate([-12,6,22]) cylinder(3, r=2.75, center=true);
            translate([12,6,22]) cylinder(3, r=2.75, center=true);
    
            // nut holes
            translate([-12, 6, -3.01-6]) nutHole(3);
            translate([-12, 6, -2.01-6]) nutHole(3); // +1mm wiggle space
    
            translate([12, 6, -3.01-6]) nutHole(3);
            translate([12, 6, -2.01-6]) nutHole(3); // +1mm wiggle space
        }
    }

}


module bottom_half() {
    translate([0,0,6])
    difference() {
        full_assembly();
        translate([-30,-30,12]) cube(60);
    }
}

module top_half() {
    rotate([0,180,0]) translate([0,0,-22])
    difference() {
        full_assembly();
        translate([-30,-30,12-60]) cube(60);
    }
}


module fanduct1() {
    // yes, I did a crappy job here, guessing sizes sometimes instead of calculating. If you have the spare time, grab it and clean it up, that's Open Source / Creative Commons for you :)
    
    difference() {
        union() {
            difference() {
                // base plate
                translate([-34,0,5]) cube([50,47,4], center=true);

                // minus original assembly
                translate([0,0,5.98]) full_assembly();
                
                // leaves a hole from the head mount as cylinder
                translate([-12,6,2.5]) cylinder(h=6, r=2);
                
                // cut superflous edged
                translate([-72.01,19.3,1.02]) cube([30,5,6]);
                translate([-63.21,-1.9,1.02]) rotate([0,0,45]) cube([30,25,6]);
                translate([-79.21,-10.9,1.02]) rotate([0,0,-45]) cube([45,25,6]);
                
                // delete under "fan"
                translate([-41.02, -8, 20]) rotate([0,0,-45]) translate([0,-7,0]) cube([40.04,10,40.04], center=true);
    
                
                
            }
            // screw heads
            translate([-31/2, -31/2, +4/2+1]) cylinder(4, r=2.75-0.5, center=true);
            translate([-31/2, +31/2, +4/2+1]) cylinder(4, r=2.75-0.5, center=true);
            
           
            
        } // union
    
    // m3 holes
    translate([-31/2, -31/2, 5]) cylinder(12, r=1.6, center=true);
    translate([-31/2, +31/2, 5]) cylinder(12, r=1.6, center=true);
        
    // screw heads
    translate([-31/2, -31/2, 7]) cylinder(4, r=2.75, center=true);
    translate([-31/2, +31/2, 7]) cylinder(4, r=2.75, center=true);
    } // difference            
            

    // 40x40 plate for fan
    translate([-41, -8, 27]) 
    union() {
        // "fan"
        rotate([0,0,-45]) 
        union() {
            translate([0,-7,0]) %cube([40,10,40], center=true); // show fan itself as shadow while designing
            difference() {
                cube([40,4,40], center=true);
                // fan
                rotate([90,0,0]) cylinder(r=18, h=4 + 10 + 2, center=true);
                // screws, 3mm, mid-to-mid 32mm
                translate([-16,0,-16]) rotate([90,0,0]) cylinder(r=1, h=4+2, center=true);
                translate([-16,0,+16]) rotate([90,0,0]) cylinder(r=1, h=4+2, center=true);
                translate([+16,0,-16]) rotate([90,0,0]) cylinder(r=1, h=4+2, center=true);
                translate([+16,0,+16]) rotate([90,0,0]) cylinder(r=1, h=4+2, center=true);
                
            }
        }
    }
    
   
    // duct
    
    // inner wall
    difference() {
        translate([-27,-23.5,7]) cube([2,71.5,40]);
        translate([-28,18.5,29.98]) cube([4,40,20]);
    }
    // edge between inner wall and fan 
    translate([-28.3,-23.5,7]) cube([1.3,1.4,40]);
    
    // rotated part on fan attachement
    difference() {
        rotate([0,0,-45]) translate([-43.35,-33,7]) cube([2,20,23]);
        translate([-40,15,6.98]) cube([2,15,40.04]);
    }

    // top triangle on rotated part on fan attachment
    difference() {
        rotate([0,0,-45]) translate([-41.35,-32.7,30]) 

        // triangle:
        translate([0,16.5/2,0]) rotate([0,0,180]) translate([0,-16.5/2,0]) difference() {
            cube([2,16.5,17]);
            rotate([45.5,0,0]) translate([-0.02,0,0]) scale(sqrt(2) * 17/16.5) cube([2.04,16.5,17]);
        }
        
    }
   
    // outer wall
    translate([-42,19,7]) cube([2,28.3,23]);
    
    // rotated part outlet
    translate([12,40,0])    
    difference() {
        rotate([0,0,-45]) translate([-43.35,-33,7]) cube([2,20,23]);
        translate([-40,15,6.98]) cube([2,15,40.04]);
        translate([-42.9,19,4]) cube([3,3,44]);
    }
    
    // back wall
    difference() {
        translate([-42,22,3]) cube([17,37,4]);
        translate([-44.3,45,2]) rotate([0,0,45]) cube([20,20,6]);
    }
    
    // front wall
    difference() {
        translate([-42,18.5,28]) cube([17,40.5,2]);
        translate([-44.3,45,27]) rotate([0,0,45]) cube([20,20,6]);
    }
    
    
    // front top
      polyhedron
    (points = [
    	   [-42,18.5,30], [-42,18.5,28],
           [-25,20.5,30], [-25,18.5,30],
           [-25,-21.2,47], [-25,-21.2,45],
           [-53.8,7.5,47], [-53.8,7.5,45]
	 ], 
     faces = [
           [2,4,6], // top north
           [2,6,0], // top south,
           [1,3,2,0], // south
           [3,5,4,2], // west
           [4,5,7,6], // northeast
           [0,6,7,1], // southeast
           [3,7,5], // bottom north
           [3,1,7], // bottom south,
     ]      
     );
    
     
}

module fanduct() {
  difference() {
    fanduct1();
    
    polyhedron
    (points = [
      	   [-42,18.5,30], [-42,18.5,130],

           [-25,20.5,30], [-25,20.5,130],
           [-25,-21.2,47], [-25,-21.2,130],
           [-53.8,7.5,47], [-53.8,7.5,130]
	 ], 
     faces = [
           [2,4,6], // top north
           [2,6,0], // top south,
           [1,3,2,0], // south
           [3,5,4,2], // west
           [4,5,7,6], // northeast
           [0,6,7,1], // southeast
           [3,7,5], // bottom north
           [3,1,7], // bottom south,
     ]      
     );


    // remove bottom inserts
    translate([0,0,0.02]) cube([100,100,6], center=true);
 
 }

  // "hotend nozzle" view, to compare with fan duct
  %translate([0,65,17]) rotate([90,0,0]) cylinder(r=3, h=50);
 
}
