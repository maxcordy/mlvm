length = 65;

/*** right part ***/
difference() {
    union() {
        difference() {
            hull() {
                rotate([90,0,0]) cylinder(h=14, r1=7, r2=7, center=true, $fn=40);
                translate([length,0,0]) {
                    rotate([90,0,0]) cylinder(h=14, r1=7, r2=7, center=true, $fn=40);
                }
            }
            translate([-20,-10,0]) cube(size = [length+40, 20,20], center = false);
        }
        

        /*** handle ***/

        hull() {
            translate([length+6.5,0,-0.5]) rotate([90,0,0]) cylinder(h=14, r1=0.5, r2=0.5, center=true, $fn=40);
            translate([length+9,-5.5,-1.5]) rotate([90,0,0]) sphere(r=1.5, $fn=40);
            translate([length+9,5.5,-1.5]) rotate([90,0,0]) sphere(r=1.5, $fn=40);
            
            translate([ length+2.4,0,-6]) rotate([90,0,0]) cylinder(h=14, r1=0.5, r2=0.5, center=true, $fn=40);
        }
    }
    
    hull() {
        rotate([90,0,0]) cylinder(h=12, r1=6, r2=6, center=true, $fn=40);
        translate([length,0,0]) {
            rotate([90,0,0]) cylinder(h=12, r1=6, r2=6, center=true, $fn=40);
        }
    }

    translate([length-1.5,0,0]) cube(size = [4, 11,100], center = true);
    
    // center part
    translate([0,6.5,0]) rotate([90,0,0]) cylinder(h=2, r1=8, r2=8, center=true, $fn=40);
    translate([0,-6.5,0]) rotate([90,0,0]) cylinder(h=2, r1=8, r2=8, center=true, $fn=40);
    translate([0,0,0]) rotate([90,0,0]) cylinder(h=2, r1=8, r2=8, center=true, $fn=40);
}

/*** center part ***/

translate([0,6.5,0]) rotate([90,0,0]) cylinder(h=1, r1=7, r2=7, center=true, $fn=40);
translate([0,0,0]) rotate([90,0,0]) cylinder(h=1, r1=7, r2=7, center=true, $fn=40);
translate([0,-6.5,0]) rotate([90,0,0]) cylinder(h=1, r1=7, r2=7, center=true, $fn=40);
difference() {
    union() {
        translate([0,3.25,0]) rotate([90,0,0]) cylinder(h=4.5, r1=7, r2=7, center=true, $fn=40);
        translate([0,-3.25,0]) rotate([90,0,0]) cylinder(h=4.5, r1=7, r2=7, center=true, $fn=40);
    }
    translate([0,0,0]) rotate([90,0,0]) cylinder(h=14, r1=4, r2=4, center=true, $fn=40);
}
translate([0,0,0]) rotate([90,0,0]) cylinder(h=14, r1=3.5, r2=3.5, center=true, $fn=40);

/*** left part ***/

difference() {
    union() {
        difference() {
            hull() {
                rotate([90,0,0]) cylinder(h=14, r1=7, r2=7, center=true, $fn=40);
                translate([-length,0,0]) {
                    rotate([90,0,0]) cylinder(h=14, r1=7, r2=7, center=true, $fn=40);
                }
            }
            translate([-length-20,-10,0]) cube(size = [length+40, 20,20], center = false);
        }
    }

    hull() {
        rotate([90,0,0]) cylinder(h=12, r1=6, r2=6, center=true, $fn=40);
        translate([-length,0,0]) {
            rotate([90,0,0]) cylinder(h=12, r1=6, r2=6, center=true, $fn=40);
        }
    }

    translate([0,3,0]) rotate([90,0,0]) cylinder(h=6, r1=8, r2=8, center=true, $fn=40);
    translate([0,-3,0]) rotate([90,0,0]) cylinder(h=6, r1=8, r2=8, center=true, $fn=40);

}

// finn left
hull() {
    translate([-length-1,0,-2.8]) rotate([90,0,0]) cylinder(h=1, r1=4, r2=4, center=true, $fn=40);
    translate([0,0,-2.8]) rotate([90,0,0]) cylinder(h=1, r1=4, r2=4, center=true, $fn=40);
}

// finns right
difference() {
    union() {
        hull() {
            translate([length-4.5,5,-6]) rotate([90,0,0]) cylinder(h=1, r1=1, r2=1, center=true, $fn=40);
            translate([length-10,5,-2.8]) rotate([90,0,0]) cylinder(h=1, r1=4, r2=4, center=true, $fn=40);
            translate([0,5,-2.8]) rotate([90,0,0]) cylinder(h=1, r1=4, r2=4, center=true, $fn=40);
        }
        hull() {
            translate([length-4.5,-5,-6]) rotate([90,0,0]) cylinder(h=1, r1=1, r2=1, center=true, $fn=40);
            translate([length-10,-5,-2.8]) rotate([90,0,0]) cylinder(h=1, r1=4, r2=4, center=true, $fn=40);
            translate([0,-5,-2.8]) rotate([90,0,0]) cylinder(h=1, r1=4, r2=4, center=true, $fn=40);
        }
    }
    
    // center part hole
    translate([0,0,0]) rotate([90,0,0]) cylinder(h=14, r1=4, r2=4, center=true, $fn=40);
}


/*** nub ***/
// main stud
hull() {
    translate([-length+2.5,0,8.5]) cube(size = [1, 9,1], center = true);
    translate([-length+2.5,0,-6.3]) cube(size = [1, 13.99,1], center = true);
}
hull() {
    translate([-length+3.8,0,8.5]) rotate([90,0,0]) cylinder(h=9, r1=0.5, r2=0.5, center=true, $fn=40);
    translate([-length+2.5,0,7]) rotate([90,0,0]) cylinder(h=9.5, r1=0.5, r2=0.5, center=true, $fn=40);
    //#translate([-length+2.5,0,10]) rotate([90,0,0]) cylinder(h=9, r1=0.5, r2=0.5, center=true, $fn=40);
    
    translate([-length+2.5,-4,10]) rotate([90,0,0]) sphere(r=0.5, $fn=40);
    translate([-length+2.5,4,10]) rotate([90,0,0]) sphere(r=0.5, $fn=40);
}
// nub support
hull() {
    translate([-length-2,0,0]) rotate([90,0,0]) cylinder(h=1, r1=0.5, r2=0.5, center=true, $fn=40);
    translate([-length+2.5,0,10]) rotate([90,0,0]) cylinder(h=1, r1=0.5, r2=0.5, center=true, $fn=40);
    translate([-length+2.5,0,0]) rotate([90,0,0]) cylinder(h=1, r1=0.5, r2=0.5, center=true, $fn=40);
}
