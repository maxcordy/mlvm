// measure the radius (in mm) of the part of the bike where you want to mount this part. it has to be round: try the stem, top tube, or seat post.
bicycle_neck_radius_in_mm = 18; // [15:26]

$fn = 100*1;

visualizing = false;
printing = false;
printingOther = true;

base_shell_rad = 40*1;

el_wid = 47.6*1;
el_hit = 47.6*1;
el_dpt = 10.8*1;
big = 200*1;


module fitter (hit,clip_thickness,clip_wid) {
    neck_r = bicycle_neck_radius_in_mm;
    wall_thickness = 1.5;
    rad = neck_r + 2*wall_thickness;
    //hit = 32;
    cut_wid = 3;
    screwpoint_thickness = 1.5;
    screwpoint_wid = 15;
    screwpoint_height = 20;
    fillet_radius = 5;
    screw_r = 1.8; // #6 machine screw diameter is 9/64" == 3.57mm, r= 1.78mm
    clip_give = 1.5;
    rotate([0,0,90])
    translate([0,30,22.5])
    difference() {
        union() {
            linear_extrude(height=hit) {
                // make the profile nice 'n' smooth
                fillet(r=fillet_radius) {
                    union() {
                            // the part that actually goes on the bike
                        difference () {
                            union() {
                                hull() {
                                    circle(r=rad);
                                    /* a piece to hold the clip
                                    translate([-rad,-rad-clip_thickness-2*(screwpoint_thickness),0])
                                        square([rad*2,rad]);*/
                                }
                                // the part that will hold the screws
                                translate([-rad-screwpoint_wid,-screwpoint_thickness-cut_wid,0]) {
                                    square([2*(rad+screwpoint_wid),2*(screwpoint_thickness+cut_wid)]);
                                }
                            }
                            // the neck of the bike
                            circle(r=neck_r);
                        }
                    }
                }
            }
            // pyramid to join it to the other bit
            translate([0,-31,hit/2])
            rotate([0,90,90])
            cylinder(r1=37,r2=neck_r*3/4,h=2*neck_r);
        }
        // the neck of the bike
        translate([0,0,-big/2])
            cylinder(r=neck_r,h=big);
        // a cut to get it open and over the neck
        translate([-rad-screwpoint_wid-1,-cut_wid/2,-1]) {
            cube([big,cut_wid,big]);
        }
        // screw holes
        translate([-rad-screwpoint_wid/2,-screwpoint_thickness-cut_wid/2-10,hit/2]) {
            rotate([-90,0,0]) {
                cylinder(r=screw_r,h=big);
            }
        }
        translate([rad+screwpoint_wid/2,-screwpoint_thickness-cut_wid/2-10,hit/2]) {
            rotate([-90,0,0]) {
                cylinder(r=screw_r,h=big);
            }
        }
    }
}

module clipper (hit, clip_thickness, clip_wid) {
    translate([-37,20-clip_wid/2,0]) {
        rotate([180,90,-90]) { 
            // we draw out the clip shape in 2D and extrude.
            linear_extrude(height=clip_wid) {
                polygon(points=[[0,0],[clip_thickness,0],[clip_thickness,clip_thickness],[hit+clip_thickness,clip_thickness],[hit+clip_thickness,clip_thickness-1],[hit+2*clip_thickness,2*clip_thickness],[0,2*clip_thickness]]);
            }
            translate([0,-3,0]) {
                cube([hit+clip_thickness,3,clip_wid]);
            }
        }
    }
}

module baseSphere () {
    if (printing) {
        scale([1,1.25,1]) {
            sphere(r=base_shell_rad,$fn=200);
        }
    } else {
        scale([1,1.25,1]) {
            sphere(r=base_shell_rad,$fn=50);
        }
    }
}

module screwMount(dpth) {
    // need to copy a bunch of times to get 45 degree angle
    if (printing) {
        step = .1;
        for (z = [0:step:dpth]) {
            translate([z,0,-z]) {
                linear_extrude(step) {
                    union() {
                        translate([0,-5,0])
                        square(10);
                        circle(5);
                    }
                }
            }
        }
    } else {
        step = 1.5;
        for (z = [0:step:dpth]) {
            translate([z,0,-z]) {
                linear_extrude(step) {
                    union() {
                        translate([0,-5,0])
                        square(10);
                        circle(5);
                    }
                }
            }
        }
    }
}

module holder () {
    difference() {
        translate([-el_wid/2,20,-23]) {
            difference() {
                union() {
                    difference() {
                        // create the shell
                        baseSphere();
                        // hollow it out
                        scale([.96,.96,.96])
                            baseSphere();
                    }
                    // add in a backing
                    intersection() {
                        baseSphere();
                        translate([-2.25*base_shell_rad,-2*base_shell_rad,-base_shell_rad])
                            cube([base_shell_rad*2,base_shell_rad*8,base_shell_rad*2]);
                    }
                    // also flatten the front interior
                    intersection() {
                        baseSphere();
                        translate([.65*base_shell_rad,-2*base_shell_rad,-base_shell_rad])
                            cube([base_shell_rad*2,base_shell_rad*8,base_shell_rad*2]);
                    }
                    // add in mounts for screws!
                    intersection() {
                        baseSphere();
                        translate([-9,-30,-25])
                            rotate([180,90,0])
                                screwMount(15);
                    }
                    intersection() {
                        baseSphere();
                        translate([-9,-30,25])
                            rotate([0,-90,0])
                                screwMount(15);
                    }
                    intersection() {
                        baseSphere();
                        translate([-9,30,-25])
                            rotate([180,90,0])
                                screwMount(15);
                    }
                    intersection() {
                        baseSphere();
                        translate([-9,30,25])
                            rotate([0,-90,0])
                                screwMount(15);
                    }
                }
                // cut off the back to be flat
                translate([-2.25*base_shell_rad-1.5,-2*base_shell_rad,-base_shell_rad])
                    cube([base_shell_rad*2,base_shell_rad*8,base_shell_rad*2]);
                // holes through the back for the screws to go
                translate([0,-30,25])
                    rotate([0,-90,0])
                        cylinder(r=2,h=90);
                translate([0,-30,-25])
                    rotate([0,-90,0])
                        cylinder(r=2,h=90);
                translate([0,30,25])
                    rotate([0,-90,0])
                        cylinder(r=2,h=90);
                translate([0,30,-25])
                    rotate([0,-90,0])
                        cylinder(r=2,h=90);
                // cut out a nice hole in the center to see the element logo!
                translate([.75*base_shell_rad,0,0])
                    sphere(15);
                if (visualizing) {
                    // for visualization purposes, cut off the side.
                    translate([-50,-90,-50])
                        cube(90);
                }
                // cut off the back ( for printing )
                if (printing) {
                    translate([-2.25*base_shell_rad+1,-2*base_shell_rad,-base_shell_rad])
                        cube([base_shell_rad*2,base_shell_rad*8,base_shell_rad*2]);
                } else {
                    translate([-10,-2*base_shell_rad,-base_shell_rad])
                        cube([1,base_shell_rad*8,base_shell_rad*2]);
                }
            }
            // mounts for particular parts
            // this is for the element
            intersection() {
                baseSphere();
                translate([el_dpt+3,-el_wid/2,el_hit/2]) {
                    rotate([0,90,0]) {
                        scale([1,1,big])
                            elementClip();
                    }
                }
            }
            // this is for the FONA holes
            intersection() {
                baseSphere();
                translate([el_dpt+1,el_wid/2+6,el_hit/2-7]) {
                    rotate([0,90,0]) {
                        FONAClip();
                    }
                }
            }
            // this is for the GPS antenna
            intersection() {
                baseSphere();
                translate([2,0,base_shell_rad-3.4]) {
                    GPSAntennaClip();
                }
            }
            // this is to hold the LiPo in place
            /*intersection() {
                baseSphere();
                translate([0,45,0]) {
                    LiPolyClip();
                }
            }*/
            // this is to hold the GSM antenna in place
            intersection() {
                baseSphere();
                translate([0,-base_shell_rad,el_wid/2-3]) {
                    GSMAntennaClip();
                }
            }
        }
        cube(1);
        if (printingOther) {
            translate([-34,-30,-63])
                cube([base_shell_rad*2,base_shell_rad*8,base_shell_rad*2]);
        }
        // flatten the front of the thing
        translate([5,-30,-63])
                cube([base_shell_rad*2,base_shell_rad*8,base_shell_rad*2]);
    }
}

hit = 32;
clip_wid = 15;
clip_thickness = 3;
fitter(hit, clip_thickness, clip_wid);
translate([35,-20,62]) {
    //clipper(hit, clip_thickness, clip_wid);
    holder();
    //components();
}

module element () {
    rad = 5;
    cht = 1;
    translate([rad,rad,0]) {
        minkowski()
        {
            cube([el_wid-2*rad,el_hit-2*rad,el_dpt-cht]);
            cylinder(r=rad,h=cht);
        }
    }
}

module elementClip() {
    thickness = 3.5;
    dpt = 5;
    cut_wid = 20;
    // make sure it's at z=0 for scaling
    translate([0,0,-thickness]) {
        intersection() {
            difference() {
                minkowski() {
                    // base
                    element();
                    sphere(thickness);
                }
                // horizontal cut
                translate([(el_wid-cut_wid)/2-thickness,-thickness,-thickness]) {
                    cube([cut_wid+2*thickness,el_hit+2*thickness,el_dpt+2*thickness]);
                }
                // vertical cut
                rotate([0,0,90]) {
                    translate([0,-el_wid,0]) {
                        translate([(el_wid-cut_wid)/2-thickness,-thickness,-thickness]) {
                            cube([cut_wid+2*thickness,el_hit+2*thickness,el_dpt+2*thickness]);
                        }
                    }
                }
                translate([-1,-1,0])
                scale([1.05,1.05,1.05])
                    element();
            }
            // intersect with a cube thing so we just retain the walls
            translate([-thickness,-thickness,thickness]) {
                cube([big,big,dpt]);
            }
        }
    }
}

module FONA () {
    cube([44,43,8]);
}

module FONAClip() {
    screw_diam = .1*25.4;
    screw_wall_thickness = 1.5;
    offset_dist = 1.4*25.4;
    difference() {
        union() {
            cylinder(r=screw_diam/2+screw_wall_thickness,h=20);
            translate([offset_dist,0,0]) {
                cylinder(r=screw_diam/2+screw_wall_thickness,h=20);
            }
        }
        cylinder(r=screw_diam/2,h=20);
        translate([offset_dist,0,0]) {
            cylinder(r=screw_diam/2,h=20);
        }
    }
}

module GPSAntenna () {
    cube([15,15,6.8]);
}

module GPSAntennaClip () {
    thickness = 1.5;
    squish = .9;
    difference() {
        cube([15+2*thickness+2*squish,15+2*thickness+2*squish,6.8+2*thickness], center=true);
        cube([15+squish,15+squish,big], center=true);
        /*translate([0,0,-3])
            rotate([0,90,0])
                cube([10,3,30],center=true);*/
    }
}

module LiPoly () {
    cube([60,36,7]);
}

module LiPolyClip () {
    difference() {
        scale(1.25)
            rotate([90,0,90])
                cube([10,36,10],center=true);
        scale(1.05)
            rotate([90,0,90])
                cube([60,36,7],center=true);
    }
}

module GSMAntenna () {
    // these were measurements for the one I wanted, but it was out of stock
    //cube([75-38,38,2]);
    rotate([90,90,0])
        cylinder(r=4,h=68,center=true);
}

module GSMAntennaClip () {
    // these were measurements for the one I wanted, but it was out of stock
    //cube([75-38,38,2]);
    thickness = 1.5;
    ht = 15;
    slop = .5;
    difference() {
        rotate([90,90,0])
            cylinder(r=4+thickness+slop/2,h=ht,center=true);
        rotate([90,90,0])
            cylinder(r=4.+slop/2,h=68,center=true);
    }
}

module components() {
    translate([4,0,0])
    rotate([0,90,0]) {
        translate([2,2,-8])
            FONA();
        translate([-8,15,8])
            rotate([0,90,0])
                GPSAntenna();
        rotate([90,0,90])
            translate([-5,-37,40])
                LiPoly();
        translate([5,5,-18])
            GSMAntenna();
        element();
    }
}

// below is Oskar Linde's code from https://github.com/OskarLinde/scad-utils/blob/master/morphology.scad . I reproduce it as a part of this file due to Thingiverse's current limitations regarding customizer files.

// Copyright (c) 2013 Oskar Linde. All rights reserved.
// License: BSD
//
// This library contains basic 2D morphology operations
//
// outset(d=1)            - creates a polygon at an offset d outside a 2D shape
// inset(d=1)             - creates a polygon at an offset d inside a 2D shape
// fillet(r=1)            - adds fillets of radius r to all concave corners of a 2D shape
// rounding(r=1)          - adds rounding to all convex corners of a 2D shape
// shell(d,center=false)  - makes a shell of width d along the edge of a 2D shape
//                        - positive values of d places the shell on the outside
//                        - negative values of d places the shell on the inside
//                        - center=true and positive d places the shell centered on the edge

module outset(d=1) {
	// Bug workaround for older OpenSCAD versions
	if (version_num() < 20130424) render() outset_extruded(d) children();
	else minkowski() {
		circle(r=d);
		children();
	}
}

module outset_extruded(d=1) {
   projection(cut=true) minkowski() {
        cylinder(r=d);
        linear_extrude(center=true) children();
   }
}

module inset(d=1) {
	 render() inverse() outset(d=d) inverse() children();
}

module fillet(r=1) {
	inset(d=r) render() outset(d=r) children();
}

module rounding(r=1) {
	outset(d=r) inset(d=r) children();
}

module shell(d,center=false) {
	if (center && d > 0) {
		difference() {
			outset(d=d/2) children();
			inset(d=d/2) children();
		}
	}
	if (!center && d > 0) {
		difference() {
			outset(d=d) children();
			children();
		}
	}
	if (!center && d < 0) {
		difference() {
			children();
			inset(d=-d) children();
		}
	}
	if (d == 0) children();
}


// Below are for internal use only

module inverse() {
	difference() {
		square(1e5,center=true);
		children();
	}
}