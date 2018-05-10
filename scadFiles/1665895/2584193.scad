/*      
Customizable freeform-3-hole LEGO Technic Connector Bone - variant A (with cylinders and a twist)
Jens Henrik Sandell
July 2016

Created by forking the thing:629875
        Customizable Curved LEGO Technic Beam
        Steve Medwin
        January 2015
*/
$fn=20*1.0;
// preview[view:north east, tilt:top]

// constants
width = 7.3*1.0; // beam width
height = 7.8*1.0; // beam height
hole = 5.0/2; // hole diameter
counter = 6.1/2; // countersink diameter
depth = 0.85*1.0; // countersink depth
pitch = 8.0*1.0; // distance between holes

// user parameters
// distance between first and mid hole =
Distance1 = 50; // [20:100]
// distance between mid and last hole =
Distance2 = 50; // [20:60]
// twist =
Twist_Hole_3 = 30; // [-90:90]
// angle between first and second bone =
AngleBones = 20.0; // [0.0:90]
// degrees between adjacent holes
BoneFactor = 1.0; // [0.5,0.6,0.7,0.8,0.9,1.0]

// calculations
// create beam
difference()
{
	union(){
		cylinder(h=height, r=width/2);
		translate([0,0,height/2]) rotate([0,90,0]) cylinder(h=Distance1,r=BoneFactor*width/2);
		translate([Distance1,0,0]) cylinder(h=height,r=width/2);

		translate([Distance1,0,0]) rotate([0,0,AngleBones]) {
			translate([0,0,height/2]) rotate([0,90,0]) cylinder(h=Distance2,r=BoneFactor*width/2);
			translate([Distance2,0,height/2]) rotate([Twist_Hole_3,0,0]) cylinder(h=height,r=width/2,center=true);
		}
	}
	for (i=[0:1]) {
		translate([i*Distance1,0,0]) {
			translate([0,0,-2])
			cylinder(h=height+4, r=hole);
                
			translate([0,0,-0.01])
			cylinder(h=depth+0.01, r=counter);      
                
			translate([0,0,height-depth])
			cylinder(h=depth+0.01, r=counter);
                
			translate([0,0,depth])
			cylinder(h=(counter - hole), r1=counter, r2=hole);           
		}    
	}
	translate([Distance1,0,0]) rotate([0,0,AngleBones]) translate([Distance2,0,height/2]) rotate([Twist_Hole_3,0,0]) translate([0,0,-height/2]) {
		translate([0,0,-2])
		cylinder(h=height+4, r=hole);
               
		translate([0,0,-0.01])
		cylinder(h=depth+0.01, r=counter);      
                
		translate([0,0,height-depth])
		cylinder(h=depth+0.01, r=counter);
                
		translate([0,0,depth])
		cylinder(h=(counter - hole), r1=counter, r2=hole);           
	}    
}

