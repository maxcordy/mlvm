/* 
   Parametric Lego Brick
   Andrew Sweet, 2014
   Feel free to use my design,
	credit is appreciated where appropriate

   If you choose to alter this code, please keep this
	top comment in all further iterations :)
*/

/* Parameters */

//Any non-zero integer
numRows = 7; // [1:12]

//Any non-zero integer
numCols = 1; // [1:12]

// 1/3 and 1 are the two standard heights
height = 1; // [0.33333333, 1]

// Multiples of 2 of each other can fit into each other
brickScale = 1; // [1, 2, 4, 0.5, 0.25]

// The higher the number, the smoother the curves
curveFidelity = 50; // [10:100]

/* End Parameters */


/* Lego Dimensions courtesy of:

http://www.robertcailliau.eu/Lego/Dimensions/zMeasurements-en.xhtml

and

http://static2.wikia.nocookie.net/__cb20130331204917/legomessageboards/images/3/3c/Lego_brick_2x4.png

*/

/* [Hidden] */

// Brick Dimensions
brickHeightDim = 9.6; // toBeScaled

brickUnit = 8.0;

dWidth = 0.2;
brickWidth = ((brickUnit * numRows) - dWidth) * brickScale;
brickDepth = ((brickUnit * numCols)  - dWidth) * brickScale;

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

if (numRows > 1 && numCols > 1){
/* Add Interior */
for (row = [1:(numRows - 1)]){
	for (col = [1:(numCols - 1)]){

		// Cylinders
		translate([uPegOffset + (pegDistance * (row - 1)),
				   uPegOffset + (pegDistance * (col-1)),
				   0])	
		difference()
		{
		cylinder(h=uPegHeight, 
				 r1=uPegMaxRadius, 
				 r2=uPegMaxRadius, $fn=curveFidelity);
		translate([0,0,-1])	
		cylinder(h=uPegHeight+0.999, 
				 r1=uPegMinRadius, 
				 r2=uPegMinRadius, $fn=curveFidelity);
		}
	}
}
} else {
	assign (rad = (pegDistance - (pegRadius * 2))/2 - (0.1 * brickScale))
    {
		if (numRows > 1){

			for (row = [1:(numRows - 1)]){
				translate(
					[uPegOffset + (pegDistance * (row - 1)),
				  	(brickUnit * brickScale)/2,
				  	0])	
				cylinder(h=uPegHeight, 
					 	r1=rad, 
					 	r2=rad, $fn=curveFidelity);
			}

		} else if (numCols > 1){
			for (col = [1:(numCols - 1)]){
				translate(
					[(brickUnit * brickScale)/2,
				uPegOffset + (pegDistance * (col - 1)),
				  	0])	
				cylinder(h=uPegHeight, 
					 	r1=rad, 
					 	r2=rad, $fn=curveFidelity);
			}
		}
	}
}

// KnobHolders (underneath)
if (numRows > 1 && numCols > 1){
for (row = [0:(numRows - 1)]){
		translate([khOffset + (pegDistance * row),
				   shellThicknessSides,
				   0])	
		cube([khWidth, khDepth, uPegHeight]);

		translate([khOffset + (pegDistance * row),
			(numCols * (brickUnit * brickScale)) - shellThicknessSides - khDepth - (0.2 * brickScale),
				   0])	
		cube([khWidth, khDepth, uPegHeight]);
}

for (col = [0:(numCols - 1)]){
		translate([shellThicknessSides,
				   khOffset + (pegDistance * col),
				   0])	
		cube([khDepth, khWidth, uPegHeight]);

		translate([(numRows * (brickUnit * brickScale)) - shellThicknessSides - khDepth - (0.2 * brickScale),
khOffset + (pegDistance * col),
				   0])	
		cube([khDepth, khWidth, uPegHeight]);
}
}

// Create the Pegs
for (row = [0:(numRows - 1)]){
	for (col = [0:(numCols - 1)]){
		translate([pegOffset + (pegDistance * row),
				   pegOffset + (pegDistance * col),
				   brickHeight])	
		cylinder(h=pegHeight, 
				 r1=pegRadius, 
				 r2=pegRadius, $fn=curveFidelity);
	}
}