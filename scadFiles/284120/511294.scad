// MakerBot Thingiverse Customizer template 
// with build chamber limiter, 
// Replicator model selection, 
// and cross section option.  
// 
// by Les Hall
// 
// started 3-19-2014
// All dimensions are in millimeters.  
// This template works in Customizer.  
// 




/* [General] */

// MakerBot Replicator Model
buildVolume = 3; // [0:Replicator 2X, 1:Replicator 2, 2:Replicator Z18, 3:Replicator Mini, 4:Replicator]

// Make whole thing or half thing
crossSection = 0; // [0:whole thing, 1: positive x half, 2:negative x half, 3:positive y half, 4:negative y half, 5:positive z half, 6:negative z half]

// Thickness (mm)
wallThickness = 3; // [1:16]

// Round shape smoothness
detail = 64; // [3:256]




/* [Details] */

// Total Height
totalHeight = 80; // [40:457]

// Total Diameter
totalDiameter = 100; // [50:305]

// Base Diameter
baseDiameter = 60; // [25:457]

// Lip Height
lipHeight = 20; // [1:100]

// Foot Height
footHeight = 10; // [1:100]

// lip Diameter
lipDiameter = 82; // [50:305]

// Lip Overhang
lipOverhang = 4; // [0:100]

// Drainage Hole Diameter
drainageHoleDiameter = 8; // [0:16]





// access hole dimensions
mouthAngle = -atan2(2*lipOverhang + wallThickness, lipHeight);
mouthWidth = 12;
downTubeHoleDiameter = (5/8)*25.4;



// size of build volume in millimeters
buildSize = [
	[246, 152, 155], 
	[285, 153, 155], 
	[305, 305, 457], 
	[100, 100, 125],
	[252, 199, 150], 
];

// select the build volume by model
MakerBotSize = buildSize[buildVolume];

// determine offset and size of cross section eraser
xs = MakerBotSize[0];
ys = MakerBotSize[1];
zs = MakerBotSize[2];
crossSectionOffsets = [
	[ 0,   0,   0], 
	[-xs,  0,   0], 
	[ xs,  0,   0], 
	[ 0,  -ys,  0], 
	[ 0,   ys,  0], 
	[ 0,   0, -zs], 
	[ 0,   0,  zs]
];
crossSectionOffset = crossSectionOffsets[crossSection];
crossSectionSize = 2 * MakerBotSize;

// set level of detail for round shapes
$fn = detail;


// set internal diameters
footDiameter = baseDiameter - 
	(footHeight / totalHeight) * 
	(totalDiameter - baseDiameter);
mainPotHeight = totalHeight - lipHeight;

// set internal offsets
lipOffset = mainPotHeight/2;
footOffset = -mainPotHeight/2;
mainPotOffset = -lipHeight/2;

// make it!
difference()
{
	// use intersection to ensure evertything fits in build chamber
	intersection()
	{
		// the potted plant bong
		// difference of two unions, the positive and negative
		difference()
		{
			// shapes (positives)
			union()
			{
				// lip of pot at top
				translate([0, 0, lipOffset])
				cylinder(r1 = lipDiameter/2 + lipOverhang, 
					r2 = totalDiameter/2, 
					h = lipHeight, center = true);
				// main pot shape
				translate([0, 0, mainPotOffset])
				cylinder(r1 = baseDiameter/2, r2 = lipDiameter/2, 
					h = mainPotHeight, center = true);
			}

			// chisels (negatives)
			union()
			{
				// lip of pot at top
				translate([0, 0, lipOffset + wallThickness])
				cylinder(r1 = lipDiameter/2 - lipOverhang - wallThickness, 
					r2 = totalDiameter/2 - wallThickness, 
					h = lipHeight, center = true);
				// main pot shape
				translate([0, 0, 
					mainPotOffset + wallThickness + footHeight/2])
				cylinder(r1 = baseDiameter/2 - wallThickness, 
					r2 = lipDiameter/2 - lipOverhang - wallThickness, 
					h = mainPotHeight - 2*wallThickness - footHeight, 
					center = true);
				// footer of pot at bottom
				translate([0, 0, mainPotOffset - mainPotHeight/2 + 
					footHeight/2 - wallThickness])
				cylinder(r1 = baseDiameter/2 -  wallThickness, 
					r2 = baseDiameter/2 - 2 * wallThickness, 
					h = footHeight, center = true);
				// drainage hole of pot at bottom
				translate([0, 0, mainPotOffset - mainPotHeight/2 + 
					footHeight/2])
				cylinder(r = drainageHoleDiameter/2, 
					h = 6*wallThickness, center = true);
				// mouth hole
				translate([0, lipDiameter/2 - wallThickness/2, 
					mainPotOffset + mainPotHeight/2 + 2*wallThickness])
				rotate(mouthAngle, [1, 0, 0])
				scale([1, 0.2, 1])
				cylinder(r = mouthWidth/2, h = 2*lipHeight, center = true);
				// downtube hole
				translate([0, 0, mainPotOffset + mainPotHeight/2 + 
					wallThickness])
				cylinder(r = downTubeHoleDiameter/2, 
					h = 4*wallThickness, center = true);
			}
		}
		// build chamber size limiter
		cube(MakerBotSize, center = true);
	}
	// cross-section option
	if (crossSection > 0)
		translate(crossSectionOffset)
			cube(crossSectionSize, center = true);
}



