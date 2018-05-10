/*

	CustomClip

v1.0 - 02/01/2014 TAR
	Created initial script

v1.1 - 02/13/2014 TAR
	Modified script to allow it to function using the Thingiverse Customizer

*/

use <write/Write.scad>

/* [Clip] */

//	Create the text, clip, or both
createWhat = 3;	//	[1:clip only, 2:text only, 3:both clip and text]

//	Width of the clip (mm)
clipWidth = 20;	//	[10:50]

// Height (thickness) of the clip (mm)
clipHeight = 2;

//	Width of outer clip (mm)
outerWidth = 5;

tongueWidth = clipWidth/2;

/* [Text] */

// Text to add to the clip
string1 = "My Clip";

// Height of characters above the clip
fontWidth = 1.0;

// Size of font relative to tongue width
fontPercent = 0.75;

fontSize = tongueWidth * fontPercent;

/* [Hidden] */

//	This adds a little bit of extra size where needed to ensure
// that certain overlapping parts do overlap.
fudge = 0.1*1;

//	Length of the clip (mm)


//	This is the main module
{
	clipLength = 25+7*len(string1)*fontPercent;

	if (createWhat==1 || createWhat==3)
		Clip();
	if (createWhat==2 || createWhat==3)
		Text();
}


module 	Clip()
{
	difference() 
	{
		union()
		{
			// Generate circles at either end
			translate([0,0,0])
				cylinder(r=clipWidth/2, h=clipHeight, fn=32);
			translate([clipLength-clipWidth,0,0])
				cylinder(r=clipWidth/2, h=clipHeight, fn=32);

			// Fill in the middle with a cube
			translate([0, -clipWidth/2, 0])
				cube([clipLength-clipWidth,clipWidth,clipHeight]);
		}

		union()
		{
			// Carve out slot
			translate([clipWidth/4, -(clipWidth-outerWidth)/2, -fudge])
				cube([clipLength-5*clipWidth/4,(clipWidth-outerWidth),clipHeight+2*fudge]);
			translate([clipLength-clipWidth, 0, -fudge])
				cylinder(r=(clipWidth-outerWidth)/2, h=clipHeight+2*fudge, fn=32);
		}
	}

	// Add the tongue
	union()
	{
			translate([clipWidth/4-fudge, -tongueWidth/2, 0])
				cube([clipLength-5*clipWidth/4, tongueWidth, clipHeight+fudge]);
			translate([clipLength-clipWidth,0,0])
				cylinder(r=(tongueWidth)/2, h=clipHeight+2*fudge, fn=32);
	}
}

module 	Text()
{
	//	Add text
	{
		color("green")
		translate([0*clipWidth/3,-fontSize/2,clipHeight])
		{
			write(string1,t=fontWidth,h=fontSize,center=false, font = "orbitron.dxf");
		}
	}
}
