//Filament spool holder for skateboard bearings, with Lego base.
//John Stäck, 2014
//Based on works by Andrew Sweet and Edward Patel
//Licensed under Creative Commons - Attribution - Share Alike

//Default dimensions are for 608 bearings (plain skateboard/inline bearings)
//lego.scad is "hardcoded" into this file to work with thingiverse customizer.

/* [Parameters] */

//Distance between axle centers. 100mm is reasonable for 12-20cm diameter spools
axle_distance = 100;

//Wall thickness
thickness = 3.5;

//Width of "buffers"
buffer_width = 1.5; 

//Width of walls outside of bearings
clearance = 1.5;

//How far to offset lego from center (for width adjustment). 1/3rd of a "knob" gives adjustability in equal steps.
lego_offset=2.67;

//Number of segments for circles
$fn=72;

/* [Bearing dimensions] */

//Bearing outer diameter
bearing_diameter = 22;

//Bearing width
bearing_width = 7;

//Bearing axle (inner) diameter
axle_diameter = 8;

//Diameter of bearing "inner tube", for washer/buffer
washer_diameter = 11.5;

/* [Hidden] */
//Distance between knobs on lego
knob_size=8.0;

//Height of a regular (knobless) 1/3rd-height piece in mm
lego_height=3.2;



total_width = thickness*2+bearing_width+buffer_width*2;
total_length = axle_distance + bearing_diameter + clearance*2;


/* Begin include lego.scad */

/* 
   Parametric Lego Brick
   Andrew Sweet, 2014
   Feel free to use my design,
	credit is appreciated where appropriate

   If you choose to alter this code, please keep this
	top comment in all further iterations :)

   Modified into a module (with some small changes) by John Stäck
*/


module LegoBrick(
	rows=4,       //Number of pegs in X direction
	cols=2,       //Number of pegs in Y direction
	height=1,     //Normal bricks are 1, "low bricks" are 1/3
	brickScale=1, //Sizing factor. Use powers of 2 for compatibility
	pegs=true,    //If pegs on top are to be included
	fn=72         //"Curve fidelity", used as $fn for cylinders
)
{


/* Lego Dimensions courtesy of:

http://www.robertcailliau.eu/Lego/Dimensions/zMeasurements-en.xhtml

and

http://static2.wikia.nocookie.net/__cb20130331204917/legomessageboards/images/3/3c/Lego_brick_2x4.png

*/

	// Brick Dimensions
	brickHeightDim = 9.6; // toBeScaled

	brickUnit = 8.0;
	
	dWidth = 0.2;
	brickWidth = ((brickUnit * rows) - dWidth) * brickScale;
	brickDepth = ((brickUnit * cols)  - dWidth) * brickScale;
	
	brickHeight = (height * brickHeightDim) * brickScale;

	shellThicknessTop = 1.0 * brickScale;
	shellThicknessSides = 1.2 * brickScale;
	
	// UnderPeg
	uPegMaxRadius = 6.51 * brickScale/2;
	uPegMinRadius = 4.8 * brickScale/2;
	uPegOffset    = (brickUnit - 0.1) * brickScale;
	uPegHeight    = brickHeight - shellThicknessTop;
	
	// Pegs
	tempDistance = 2.4 + 1.6; // To be scaled
	pegOffset    = (tempDistance - 0.1) * brickScale;
	tempRadius   = 4.8 / 2.0;
	pegDistance  = brickUnit * brickScale;
	
	pegRadius   = tempRadius * brickScale;
	pegHeight   = 1.8 * brickScale;
	
	// KnobHolders (small rectangular protrusions underneath)
	khWidth  = 0.6 * brickScale;
	khDepth  = 0.3 * brickScale;
	khOffset = shellThicknessSides + khDepth + pegRadius+ (0.1 * brickScale);


	// Create the Brick
	difference()
	{
	cube([brickWidth, brickDepth, brickHeight]);
	
	translate([shellThicknessSides, 
				shellThicknessSides,
				-1])
	cube([brickWidth - (shellThicknessSides * 2), 
			brickDepth - (shellThicknessSides * 2), 
			brickHeight - shellThicknessTop + 1]);
	}
	
	if (rows > 1 && cols > 1){
	/* Add Interior */
	for (row = [1:(rows - 1)]){
		for (col = [1:(cols - 1)]){

			// Cylinders
			translate([uPegOffset + (pegDistance * (row - 1)),
				   uPegOffset + (pegDistance * (col-1)),
				   0])	
			difference()
			{
				cylinder(h=uPegHeight, 
					r1=uPegMaxRadius, 
					r2=uPegMaxRadius,
					$fn=fn);
				translate([0,0,-1])	
				cylinder(h=uPegHeight+0.999, 
					r1=uPegMinRadius, 
					r2=uPegMinRadius,
					$fn=fn);
			}
		}
	}
	} else {
		assign (rad = (pegDistance - (pegRadius * 2))/2 - (0.1 * brickScale))
	    {
			if (rows > 1){

				for (row = [1:(rows - 1)]){
					translate(
						[uPegOffset + (pegDistance * (row - 1)),
					  	(brickUnit * brickScale)/2,
					  	0])	
					cylinder(h=uPegHeight, 
					 	r1=rad, 
					 	r2=rad,
						 $fn=fn);
				}

			} else if (cols > 1){
				for (col = [1:(cols - 1)]){
					translate(
						[(brickUnit * brickScale)/2,
					uPegOffset + (pegDistance * (col - 1)),
					  	0])	
					cylinder(h=uPegHeight, 
					 	r1=rad, 
					 	r2=rad,
						$fn=fn);
				}
			}
		}
	}

	// KnobHolders (underneath)
	if (rows > 1 && cols > 1){
		for (row = [0:(rows - 1)]){
			translate([khOffset + (pegDistance * row), shellThicknessSides, 0])	
				cube([khWidth, khDepth, uPegHeight]);

			translate([khOffset + (pegDistance * row),
				(cols * (brickUnit * brickScale)) - shellThicknessSides - khDepth - (0.2 * brickScale), 0])	
			cube([khWidth, khDepth, uPegHeight]);
		}

		for (col = [0:(cols - 1)]){
			translate([shellThicknessSides,
				khOffset + (pegDistance * col),
				0])	
			cube([khDepth, khWidth, uPegHeight]);

			translate([(rows * (brickUnit * brickScale)) - shellThicknessSides - khDepth - (0.2 * brickScale), khOffset + (pegDistance * col), 0])	
			cube([khDepth, khWidth, uPegHeight]);
		}
	}

	// Create the Pegs
	if(pegs) for (row = [0:(rows - 1)]){
		for (col = [0:(cols - 1)]){
			translate([pegOffset + (pegDistance * row),
					   pegOffset + (pegDistance * col),
					   brickHeight])	
			cylinder(h=pegHeight, 
				r1=pegRadius, 
				r2=pegRadius,
				$fn=fn);
		}
	}

}


/* End include lego.scad */

module endplate()
{
	rotate([-90,0,0]) translate([0,-bearing_diameter/2-clearance-thickness,0]) {
	 	difference() {
			union() {
				//Circle to cover bearing
				cylinder(r=bearing_diameter/2+clearance, h=thickness);
			
				//"Leg"
				translate([-bearing_diameter/2-clearance,0,0])
					cube([bearing_diameter+clearance*2, bearing_diameter/2+clearance+thickness, thickness]);

				//Buffer/washer part, angled 45 degrees
				translate([0,0,thickness])
					cylinder(r1=(washer_diameter+buffer_width)/2,r2=washer_diameter/2,h=buffer_width);
			}
			//Center hole
			translate([0,0,-0.1])
				cylinder(r=axle_diameter/2,h=thickness+buffer_width+0.2);
		}
	}
}

//Endplates in four corners
endplate();
translate([axle_distance,0,0]) endplate();
translate([0,total_width,0]) rotate([0,0,180]) endplate();
translate([axle_distance,total_width,0]) rotate([0,0,180]) endplate();

//Bottom plate
translate([-bearing_diameter/2-clearance,0,0]) cube([total_length, total_width, thickness]);

//Edges along bottom plate
translate([-bearing_diameter/2-clearance,0,0]) cube([total_length, thickness, thickness*2]);
translate([-bearing_diameter/2-clearance,total_width-thickness,0]) cube([total_length, thickness, thickness*2]);


//Lego base

//Make lego base just larger than the spool holder part
rows=floor(total_length/knob_size)+1;
cols=floor(total_width/knob_size)+1;

//Length of lego base, and where to put it in X to center it
lego_length=rows*knob_size;
lego_offset_x=(total_length-lego_length)/2-(bearing_diameter/2+clearance);

//Center lego in Y, offset by user value
lego_center_y=(cols*knob_size-total_width)/2;

translate([lego_offset_x,-lego_center_y+lego_offset,-(lego_height-0.5)])
  LegoBrick(height=1/3, rows=rows, cols=cols, pegs=false);
