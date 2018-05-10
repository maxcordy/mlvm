// by Les Hall
// started 4-17-2014
// Wolverine Claw
// 


/* [Size] */

// width of handpiece (mm)
handWidth = 100;  // [25:150]

// height of handpiece (mm)
handHeight = 40;  // [10:50]

// length of handpiece (mm)
handLength = 40;  // [10:100]

// overall length (mm)
totalLength = 160;  // [50:250]

// plastic thickness (mm)
thickness = 7;  // [10:50]


/* [Hidden] */

// size of hand section
handPieceSize = [4/5*handWidth+2*thickness, handHeight+2*thickness, handLength];

// knuckle spacing (mm)
spacing = handWidth/3.25;

// number of circular facets
$fn=64;


// the claw instantiation
rotate(-90, [0, 1, 0])
intersection()
{
	union()
	{
		// hand piece
		translate([handPieceSize[2]/2, 0, handPieceSize[1]/2])
		handPiece(handPieceSize, thickness);

		// all three fingers with dividers
		translate([totalLength/2, 0, handPieceSize[1]*1.05])
		fingers(handPieceSize, spacing, totalLength);
	}

	union()
	{
		translate([totalLength/2, 0, totalLength/2])
		cube(totalLength, center=true);
	}
}



// all three fingers
module fingers(size, spacing, length)
{
	difference()
	{
		union()
		{
			translate([0, 0, -0.09*length])
			rotate(10, [0, 1, 0])
			for(finger=[-1:1])
			translate([0, spacing*finger, 0])
			finger(length);
		}

		translate([-length/2+size[2]/2-7, 0, -size[1]/2])
		rotate(90, [0, 1, 0])
		rotate(90, [0, 0, 1])
		oval(size + thickness*[-2, -2, 2]);

		translate([-39, 0, -19.5])
		scale([3, 1, 1])
		rotate(90, [1, 0, 0])
		cylinder(r=size[2]/4, h=size[0], center=true);
	}
}


// one claw finger
module finger(length)
{
	scale([length/20, length/20, length/20])
	translate([-1, 0, -1.25])
	difference()
	{
		scale([11, 4, 4])
		rotate(90, [0, 1, 0])
		sphere(r=1);
	
		for(side=[-1:2:1])
		translate([5, side*4.25, 0])
		scale([17, 4.25, 6])
		rotate(90, [0, 1, 0])
		sphere(r=1);
	
		translate([0, 0, -2.5])
		scale([14, 8, 4])
		rotate(90, [0, 1, 0])
		sphere(r=1);
	}
}

// the hand piece
module handPiece(size)
{
	rotate(90, [0, 0, 1])
	rotate(90, [1, 0, 0])
	handle(size, thickness);
}


// a handle made of two ovals, the smaller
// subtracted from the larger to make it hollow
module handle(size, thickness)
{
	difference()
	{
		oval(size);
	
		union()
		{
			oval(size + thickness*[-2, -2, 2]);
	
			for(side=[-1:2:1])
			translate([0, 0, side*size[2]/2]*0.75)
			rotate(side*90+90, [0, 1, 0])
			insideBevel(size + thickness*[-2, -2, 2]);
		}
	}
}


// a solid oval made of a stretched cube and
// a cylinder on each end.  
module oval(size)
{
	union()
	{
		scale(size)
		cube(1, center=true);

		for(side=[-1:2:1])
		translate([side*size[0]/2, 0, 0])
		cylinder(r=size[1]/2, h=size[2], center=true);
	}
}


// an inside bevel made of a stretched cube and
// a cylinder on each end.  
module insideBevel(size)
{
	union()
	{
		scale(size)
		translate([0, 0, -1])
		scale([1, 1, 2])
		rotate(45, [1, 0, 0])
		cube([1, sqrt(2), sqrt(2)], center=true);

		for(side=[-1:2:1])
		translate([side*size[0]/2, 0, 0])
		cylinder(r1=size[1], r2=0, h=size[2]*2, center=true);
	}
}


