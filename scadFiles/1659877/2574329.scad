$fn = 200*1;

//The total height of this magazine release extension
TOTAL_HEIGHT = 21;

//The depth of the pocket that the existing magazine release fits in
POCKET_DEPTH = 9.6;

//The width of the existing magazine release
RELEASE_WIDTH = 13;

//The height of the existing magazine release
RELEASE_HEIGHT = 2.5;


//Size of the 'foot' section that extends towards the trigger
FOOT_LENGTH = 5; // the rounded edge will add SIDE_WALL_THICKNESS * 2 to this
FOOT_HEIGHT = 4;

// screw hole size
SCREW_SIZE = 1;

//How thick to make the walls (added to the RELEASE_WIDTH)
SIDE_WALL_THICKNESS = 1.5;

//How thick to make the walls (added to the RELEASE_HEIGHT)
TOP_AND_BOTTOM_WALL_THICKNESS = 2;

// Used to make sure that there isn't a "film" 
// of plastic covering the top
TOLERANCE = 0.01 * 1;

// An adjustment to the rounding of corners
ROUNDING_ADJUSTMENT = 0.05 * 1; //

intersection() {
	difference() {
        //main body
		cube(size = [RELEASE_WIDTH + 2*SIDE_WALL_THICKNESS,
						 RELEASE_HEIGHT + 2*TOP_AND_BOTTOM_WALL_THICKNESS,
						 TOTAL_HEIGHT],
								 center = true);
        
        //pocket
		translate([0, 0, (TOTAL_HEIGHT - POCKET_DEPTH)/2 + TOLERANCE]){
			cube(size = [RELEASE_WIDTH, RELEASE_HEIGHT, POCKET_DEPTH], center = true);
		}
        
        //screw hole
        translate([0,0, POCKET_DEPTH/2])
        rotate(a=[90,0,0])
        cylinder(SIDE_WALL_THICKNESS*10, r=SCREW_SIZE, center=true);
	}

	//Round the corners slightly
	cylinder(r = max( RELEASE_WIDTH/2 + SIDE_WALL_THICKNESS, RELEASE_HEIGHT/2 + TOP_AND_BOTTOM_WALL_THICKNESS) + ROUNDING_ADJUSTMENT, h = TOTAL_HEIGHT, center = true);
}

difference() {
    // foot that extends under the trigger guard
    translate([0,FOOT_LENGTH/2 + RELEASE_HEIGHT/2 + SIDE_WALL_THICKNESS,-TOTAL_HEIGHT/2+FOOT_HEIGHT/2])
    minkowski()
    {
        cube([RELEASE_WIDTH + SIDE_WALL_THICKNESS,FOOT_LENGTH,FOOT_HEIGHT], center=true);
        cylinder(r=2*SIDE_WALL_THICKNESS, h=FOOT_HEIGHT);
    };
    //subtract the pocket from here too
    translate([0, 0, (TOTAL_HEIGHT - POCKET_DEPTH)/2 + TOLERANCE]){
			cube(size = [RELEASE_WIDTH, RELEASE_HEIGHT, POCKET_DEPTH], center = true);

}}