// Quality.  Set it too high, and the Customizer may fail.
$fn=32;

// what to print
object = 1; // [1:Container, 2:Lid]

// increase if lids won't slide through, decrease if they are too loose
slop = 0.25; 

// inside of each compartment on x axis
cellx = 22;
// inside of each compartment on y axis
celly = 22; 
// inside of the compartment (actual inside may be slightly shorter...)
height = 22; 

// how many cells along a lid row
xcells = 7; 
// how many rows
ycells = 4; 

// radius of internal fillet, so that items can be dug out without catching in the corners
filletr = 6; 
// thickness of walls (and floor)
wall = 2; 
// thickness of the lids (generally the same as wall, but your choice)
lidthick = 2; 

module EndOfPublicParams() {}

totalx = wall + xcells*(cellx+wall);
totaly = wall + ycells*(celly+wall);

module RoundBox(x,y,z,r) {
    hull() {
        translate([r,r,r]) sphere(r);
        translate([x-r,r,r]) sphere(r);
        translate([r,y-r,r]) sphere(r);
        translate([x-r,y-r,r]) sphere(r);
        translate([r,r,z-r]) sphere(r);
        translate([x-r,r,z-r]) sphere(r);
        translate([r,y-r,z-r]) sphere(r);
        translate([x-r,y-r,z-r]) sphere(r);
    }
}

module Cell() {
    RoundBox(cellx,celly,2*height,filletr);
}

module Lid(extra=0) {
    thick = lidthick+extra;
    hull() {
        translate([-extra,wall-extra,0])
        cube([totalx+2*extra,celly+2*extra,0.05+extra]);
        
        translate([-extra,wall-extra+thick,thick])
        cube([totalx+2*extra,celly+2*extra-2*thick,0.05+extra]);
    }
}

module Container() {
    difference() {
        // main block
        RoundBox(totalx,totaly,height+lidthick,1);
                    
        // pockets
        translate([wall,wall,wall])
        for(y=[0:ycells-1]) {
            translate([0,y*(celly+wall),0])
            for(x=[0:xcells-1]) {
                translate([x*(cellx+wall),0,0])
                Cell();
            }
        }
        
        // slots for sliding lids
        for(y=[0:ycells-1]) {
            translate([0,y*(celly+wall),height-slop/2])
            Lid(slop);
        }
    }
}

//if (test) {
//    Container();
//    translate([0,-(4*wall+celly),0]) Lid(); // printing
//    %translate([0,0,height+0.2]) Lid(); // visualization
//} else {
//    Container();
////    Lid();
//}

if (object == 1) { Container(); }
if (object == 2) { Lid(); }