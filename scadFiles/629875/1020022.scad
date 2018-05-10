/*      
        Customizable Curved LEGO Technic Beam
        Steve Medwin
        January 2015
*/
$fn=50*1.0;
// preview[view:north east, tilt:top]

// constants
width = 7.3*1.0; // beam width
height = 7.8*1.0; // beam height
hole = 5.0/2; // hole diameter
counter = 6.1/2; // countersink diameter
depth = 0.85*1.0; // countersink depth
pitch = 8.0*1.0; // distance between holes
perAngleSmall = 20*1.0; // set smoothness of beam: cylinders between holes

// user parameters
// number of holes =
Holes = 9; // [3:19]
// degrees between adjacent holes
Degrees = 5; // [5,10,20]

// calculations
numHoles = Holes;
angleSmall = Degrees;
radius = pitch / tan(angleSmall); // radius of overall beam depends on degrees between holes
angleBig = (numHoles - 1) * angleSmall;
numCyl = (numHoles - 1) * perAngleSmall;
perCyl = angleSmall / perAngleSmall; // angle rotated per cylinder
partsCircle = 360 / (angleSmall * numHoles);

// create beam
difference()
{
    // make beam from many cylinders
        for (i= [0:numCyl]) {  
            rotate(a=[0,0,-i*perCyl])
            translate([0,radius,0])
            cylinder(h=height, r=width/2);
        }
    // add main holes, countersink holes and add chamfer on bottom to avoid supports
        for (i=[0:numHoles-1]) {
            rotate(a=[0,0,-i*angleSmall])
            {
                translate([0,radius,-2])
                cylinder(h=height+4, r=hole);
                
                translate([0,radius,0])
                cylinder(h=depth, r=counter);      
                
                translate([0,radius,height-depth])
                cylinder(h=depth, r=counter);
                
                translate([0,radius,depth])
                cylinder(h=(counter - hole), r1=counter, r2=hole);           
            }    
        }
    }