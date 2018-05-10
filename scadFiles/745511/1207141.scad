/*      
        LEGO Technic Hemisphere
        Steve Medwin
        March 2015
*/
$fn=100*1.0;  
// preview[view:north east, tilt:top]

// constants
depth = 0.85*1.0;       // countersink depth
slotWidth = 2.1*1.0;    // width of cross slot
slotLength = 5.1*1.0;   // length of cross slot
bevel = 0.4*1.0;        // bevel on bottom of cross
hole = 5.2/2;           // hole radius
counter = 3.0*1.0;          // ratio of countersink to full radius
widRing = 2*1.0;        // width of ring
depRing = 0.75*1.0;     // depth of ring

// user parameters
// radius of sphere (mm) =
Size = 20;      // [5:40]
// type of hole for axle
Axle = "both";  // [fixed,free,both]
// number of rings on surface (0 - 5)?
Rings = 4;      // [0:5]

numRings = Rings;   

difference() {
    // create sphere
    sphere (r=Size); 
    // subtract bottom half to leave a hemisphere
    translate ([0,0,-Size])  cube(size = Size*2, center = true);
    
    if (Axle=="fixed") {
        // subtract cross for shaft
        cube(size = [slotWidth+bevel, slotLength+bevel, depth], center = true);
        cube(size = [slotLength+bevel, slotWidth+bevel, depth], center = true);
        cube(size = [slotWidth, slotLength, Size*2.1], center = true);
        cube(size = [slotLength, slotWidth, Size*2.1], center = true);         
        }
        // or subtract clearance hole
        else if (Axle=="free") {
            cylinder (h=Size*2.1, r=hole, center = true); 
            }
            // or subtract cross with countersink
            else {
                translate ([-slotWidth/2, -slotLength/2,Size/counter]) 
                    cube(size = [slotWidth, slotLength, Size*2.1], center = false);
                translate ([-slotLength/2, -slotWidth/2,Size/counter]) 
                    cube(size = [slotLength, slotWidth, Size*2.1], center = false); 
                translate ([0,0,-0.09])
                    cylinder (h=Size/counter+0.11, r=hole, center = false);
                translate ([0,0,Size/counter])
                    cylinder (h=hole-slotWidth/2, r1=hole, r2=slotWidth/2, center = false);
            }

    // add rings on surface
    if (numRings>0) {
        for (i=[0:numRings-1]) {
            rotate([0,0,i*180/numRings]) ring();  
        } 
    }
 }

module ring() {
    difference() {
      translate([0,widRing/2,0]) rotate([90,0,0])  cylinder(h=widRing, r=Size+depRing);
      translate([0,widRing,0]) rotate([90,0,0])  cylinder(h=widRing*2, r=Size-depRing);
    }  
 }   
