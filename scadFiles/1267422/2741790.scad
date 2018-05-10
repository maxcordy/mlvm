/* [Funnel Parameters] */
// What is the inner diameter of your salt intake slot? Will be the outer diameter of the straight cylinder.
SALT_INTAKE_INNER_RADIUS = 20; // [10:30]
// What is the inner radius of the circle where the pillars touch the ground?
SALT_INTAKE_OUTER_RADIUS = 37; // [20:70]
// Set the overall funnel diameter here...
OUTER_RADIUS             = 60; // [40:60]
// How thick do you want the funnel walls to be?
WALL_THICKNESS           =  3.2; // [1:0.2:4]
// How high should the funnel part be?
FUNNEL_HEIGHT            = 60; // [40:5:80]
// Above the funnel, how long for the straight chute?
STRAIGHT_PART_HEIGHT     = 20; // [10:1:20]

/* [Pillar Parameters] */
// How many pillars do you need?
NUMBER_OF_PILLARS        =  5; // [3:8]
// How wide should the pillars' footprint be (x-dimension)?
WIDTH_OF_PILLARS         =  5; // [3:8]
// How long should the pillars' footprint be (y-dimension)?
LENGTH_OF_PILLARS        = 12; // [10:20]
// How long should the distance between salt outlet bottom and pillar bottom be?
HEIGHT_OF_PILLARS        = 20; // [10:40]

/* [Hidden] */
// OpenSCAD resolution of cirular objects
$fn=200; // [50:300]

module saltFunnel() {
	difference() {
		union() {
			cylinder(r1=OUTER_RADIUS, r2=SALT_INTAKE_INNER_RADIUS, h=FUNNEL_HEIGHT);
			translate([0,0,FUNNEL_HEIGHT]) cylinder(r=SALT_INTAKE_INNER_RADIUS, h=STRAIGHT_PART_HEIGHT);
			for (nrPillars=[0:NUMBER_OF_PILLARS-1]) {
				rotate([0,0,nrPillars*(360/NUMBER_OF_PILLARS)])
				translate([-(WIDTH_OF_PILLARS/2), SALT_INTAKE_OUTER_RADIUS, 0])
				cube([WIDTH_OF_PILLARS, LENGTH_OF_PILLARS, FUNNEL_HEIGHT+STRAIGHT_PART_HEIGHT+HEIGHT_OF_PILLARS]);
			}
		}
		union() {
			cylinder(r1=OUTER_RADIUS-WALL_THICKNESS, r2=SALT_INTAKE_INNER_RADIUS-WALL_THICKNESS, h=FUNNEL_HEIGHT);
			translate([0,0,FUNNEL_HEIGHT-0.1]) cylinder(r=SALT_INTAKE_INNER_RADIUS-WALL_THICKNESS, h=STRAIGHT_PART_HEIGHT+0.2);
		}
	}
}

saltFunnel();