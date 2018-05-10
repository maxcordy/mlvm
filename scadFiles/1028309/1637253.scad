// Template for large DIY 7 Segment Display with Single LEDs
// by Jochen Krapf
// Version 1.01

// preview[view:south east, tilt:top diagonal]

/* [Global] */

// To render the parts choose the correcponding Part Name

Part = "Digit";   // [Digit:Single 7 Segment Digit,Colon:Colon for Clock,Point:Decimal Point,Spacer:Additional Mounting Spacer,Clock:Example Clock - 4 Digits and Colon,Test:Test Single Segment]

// Parameters

// Diameter of a single LED in mm
LED_Diameter = 5.1;

// Count of LEDs at every segment
LED_per_Seg = 3;   // [1:10]

// Heigth of the iluminated Digit in mm
DigitHeight = 100;

// Angle for slanted Digit in Degree (e.g. 10°)
DigitSlantAngle = 7.5;

// Width of a Segment (Line width) in mm (typical 10..12% of Digit Heigth)
SegWidth = 12;

// Mounting Depth in mm (typical 2..3 times as Segment Width)
MountingDepth = 20;

// Horozontal Mounting Size in mm (min 70% of Digit Heigth or 0 for no spacer)
MountingWidth = 70;

// Vertical Mounting Size in mm (min 100% of Digit Heigth or 0 for no spacer)
MountingHeight = 140;

// Wall Width in mm
WallWidth = 1.5;

// Colon Horozontal Mounting Size in mm (min 26% of Digit Heigth or 0 for no spacer)
ColonMountingWidth = 26;

// Spacer Horozontal Mounting Size in mm
SpacerMountingWidth = 14;

// Thick ends of fillets
FilletSwell = 2;   // [0:None, 2:Small, 3:Medium, 4:Large]

/* [Hidden] */

// Level of Details - Set to 0.1 for export to stl
$fs = 0.2;

SegLength = (DigitHeight-SegWidth) / 2;
SegHeight = MountingDepth;
LED_Distance = (SegLength-SegWidth) / LED_per_Seg;
LED_FirstOffset = (LED_per_Seg-1) * LED_Distance / -2.0;
Wall = WallWidth;
SlantFactor = tan(DigitSlantAngle);
CircleFactor = 1.2;

// Modules

module cylinderCorr (dd, hh, center, corr)
{
	if (corr==1)
	{
		multmatrix(m = [ [1, -SlantFactor, 0, 0],
   		              [0, 1, 0, 0],
      		           [0, 0, 1, 0],
         		        [0, 0, 0,  1] ])
			cylinder (d=dd, h=hh, center=center);
	}
	else if (corr==2)
	{
		multmatrix(m = [ [1, 0, 0, 0],
   		              [SlantFactor, 1, 0, 0],
      		           [0, 0, 1, 0],
         		        [0, 0, 0,  1] ])
			cylinder (d=dd, h=hh, center=center);
	}
	else
		cylinder (d=dd, h=hh, center=center);
}



module SegTemplate(l, w, h, led, corr)
{
	a = w*0.707;
	
	hull()
	{
		translate([0,(l-w)/2,h-Wall/2])
			rotate([0,0,45])
				cube(size = [a,a,Wall], center = true);
		
		translate([0,-(l-w)/2,h-Wall/2])
			rotate([0,0,45])
				cube(size = [a,a,Wall], center = true);
		
		
		for ( i = [0 : (LED_per_Seg-1)] )
		{
			translate([0, LED_FirstOffset + i*LED_Distance, 0])
				cylinderCorr (led, Wall, false, corr);
		}
	}
}

module PointTemplate(d, h, led)
{
	hull()
	{
		translate([0,0,h-Wall])
			cylinder (d=d, h=Wall);
		
		cylinder (d=led, h=Wall);
	
	}
}

module SegBodyFillet(spw)
{
	translate([-spw, -Wall*0.5, 0])
		cube([spw,Wall,SegHeight]);
	
	if (FilletSwell>0)
		{
		translate([-spw, -Wall*FilletSwell*0.5, 0])
			cube([Wall,Wall*FilletSwell,SegHeight]);
		}
}

module SegBody(sp,corr)
{
	w2 = 0.707*2*Wall;
	spw = SegWidth/2 + sp;
	
	difference()
	{
		color( [1, 0.8, 0, 1] )
		union()
		{
			SegTemplate(SegLength+w2, SegWidth+2*Wall, SegHeight, LED_Diameter+2*Wall, corr);
			
			if (sp>0)
			{
				if (corr==1)
				{
					multmatrix(m = [ [1, -SlantFactor, 0, 0],
			   		              [0, 1, 0, 0],
			      		           [0, 0, 1, 0],
			         		        [0, 0, 0,  1] ])
					SegBodyFillet(spw);
				}
				else if (corr==2)
				{
					multmatrix(m = [ [1, 0, 0, 0],
			   		              [SlantFactor, 1, 0, 0],
			      		           [0, 0, 1, 0],
			         		        [0, 0, 0,  1] ])
					SegBodyFillet(spw);
				}
				else
					SegBodyFillet(spw);
			}
		}
		color( [1, 1, 1, 1] )
		translate([0, 0, Wall])
			SegTemplate(SegLength-w2, SegWidth, SegHeight-Wall+0.1, LED_Diameter, corr);
		
		for ( i = [0 : (LED_per_Seg-1)] )
		{
			translate([0, LED_FirstOffset + i*LED_Distance, 0])
				#cylinderCorr (LED_Diameter, Wall*3, true, corr);
		}
	}
}


module Digit()
{
	segOffsetX = SegLength / 2.0;
	segOffsetY = SegLength / 2.0;
	spX = (MountingWidth-(SegLength+SegWidth)) / 2;
	spY = (MountingHeight-DigitHeight) / 2;
	spO = SlantFactor * SegLength/2;


	multmatrix(m = [ [1, SlantFactor, 0, 0],
   	              [0, 1, 0, 0],
      	           [0, 0, 1, 0],
         	        [0, 0, 0,  1] ])
	{
		//a
		translate([0, 2*segOffsetY, 0])
			rotate([0,0,-90]) 
				SegBody(spY,2);
	
		//b
		translate([segOffsetX, segOffsetY, 0])
			rotate([0,0,180]) 
				SegBody(spX-spO,1);
	
		//c
		translate([segOffsetX, -segOffsetY, 0])
			rotate([0,0,180]) 
				SegBody(spX+spO,1);
	
		//d
		translate([0, -2*segOffsetY, 0])
			rotate([0,0,90]) 
				SegBody(spY,2);
	
		//e
		translate([-segOffsetX, -segOffsetY, 0])
				SegBody(spX-spO,1);
	
		//f
		translate([-segOffsetX, segOffsetY, 0])
				SegBody(spX+spO,1);
	
		//g
		rotate([0,0,90]) 
			SegBody(0,2);
	}
}
module SpacerFilletSwell(Width)
{
	if (FilletSwell>0)
		for ( r = [0,180] )
			rotate([0,0,r])
				{
				for ( i = [-1,1] )
					translate([Width/2-Wall/2,i*SegLength/2,MountingDepth/2])
						cube([Wall,Wall*FilletSwell,MountingDepth], center=true);
				if (MountingHeight>0)
					translate([0,MountingHeight/2-Wall/2,MountingDepth/2])
						cube([Wall*FilletSwell,Wall,MountingDepth], center=true);
				}
}

module Colon()
{
	spO = SlantFactor * SegLength/2;

	for ( i = [-1,1] )
	difference()
	{
		color( [0, 0.8, 1, 1] )
		union()
		{
			// horizintal fillets
			translate([0,i*SegLength/2,MountingDepth/2])
				cube([ColonMountingWidth,Wall,MountingDepth], center=true);

			// vertical fillet
			if (MountingHeight>0)
				translate([0,i*MountingHeight/4,MountingDepth/2])
					cube([Wall,MountingHeight/2,MountingDepth], center=true);

			// vertical fillet if no mounting height
			translate([0,i*SegLength/4,MountingDepth/2])
				cube([Wall,SegLength/2,MountingDepth], center=true);

			// point
			translate([i*spO,i*SegLength/2,0])
				PointTemplate(CircleFactor*SegWidth+2*Wall, SegHeight, LED_Diameter+2*Wall);

			SpacerFilletSwell(ColonMountingWidth);
		}

		color( [1, 1, 1, 1] )
		translate([i*spO,i*SegLength/2,Wall])
		{
			// cut off cone
			PointTemplate(CircleFactor*SegWidth, SegHeight-Wall+0.01, LED_Diameter);

			// LED
			#cylinder (d=LED_Diameter, h=Wall*3, center=true);
		}
	}
}

module Point()
{
	spO = SlantFactor * SegLength;

	difference()
	{
		color( [0, 0.8, 1, 1] )
		union()
		{
			// horizintal fillets
			translate([0,SegLength/2,MountingDepth/2])
				cube([SegWidth,Wall,MountingDepth], center=true);
			translate([0,-SegLength/2,MountingDepth/2])
				cube([SegWidth,Wall,MountingDepth], center=true);

			// horizintal fillet to point
			translate([-spO/2,-SegLength,MountingDepth/2])
				cube([spO,Wall,MountingDepth], center=true);

			// vertical fillet
			if (MountingHeight>0)
				translate([0,0,MountingDepth/2])
					cube([Wall,MountingHeight,MountingDepth], center=true);

			// vertical fillet if no mounting height
			translate([0,-SegLength*0.25,MountingDepth/2])
				cube([Wall,SegLength*1.5+Wall,MountingDepth], center=true);

			// point
			translate([-spO,-SegLength,0])
				PointTemplate(CircleFactor*SegWidth+2*Wall, SegHeight, LED_Diameter+2*Wall);

			SpacerFilletSwell(SegWidth);
		}

		color( [1, 1, 1, 1] )
		translate([-spO,-SegLength,Wall])
		{
			// cut off cone
			PointTemplate(CircleFactor*SegWidth, SegHeight-Wall+0.01, LED_Diameter);

			// LED
			#cylinder (d=LED_Diameter, h=Wall*3, center=true);
		}
	}
}

module Spacer()
{
	color( [0.8, 0, 0.8, 1] )
	{

	// horizintal fillets
	translate([0,SegLength/2,MountingDepth/2])
		cube([SpacerMountingWidth,Wall,MountingDepth], center=true);
	translate([0,-SegLength/2,MountingDepth/2])
		cube([SpacerMountingWidth,Wall,MountingDepth], center=true);

	// vertical fillet
	if (MountingHeight>0)
		translate([0,0,MountingDepth/2])
			cube([Wall,MountingHeight,MountingDepth], center=true);

	// vertical fillet if no mounting height
	translate([0,0,MountingDepth/2])
		cube([Wall,SegLength,MountingDepth], center=true);

	SpacerFilletSwell(SpacerMountingWidth);
	}
}

// Use Modules

if (Part == "Digit")
{
	Digit();
	if (MountingWidth>0 && MountingHeight>0)
	{
	color( [0.25, 0.5, 1, 0.25] )
		translate([0,0,MountingDepth+0.5])
			%cube([MountingWidth,MountingHeight,1], center=true);
	}
}

if (Part == "Colon")
{
	translate([-0.5*MountingWidth - 0.5*ColonMountingWidth,0,0])
		%Digit();
	
    Colon();
	
	translate([0.5*MountingWidth + 0.5*ColonMountingWidth,0,0])
		%Digit();
}

if (Part == "Clock")
{
	translate([-1.5*MountingWidth - ColonMountingWidth/2,0,0])
		Digit();
	
	translate([-0.5*MountingWidth - ColonMountingWidth/2,0,0])
		Digit();
	
	Colon();
	
	translate([0.5*MountingWidth + ColonMountingWidth/2,0,0])
		Digit();
	
	translate([1.5*MountingWidth + ColonMountingWidth/2,0,0])
		Digit();
}

if (Part == "Point")
{
	translate([-0.5*MountingWidth - 0.5*SegWidth,0,0])
		%Digit();
	
	Point();
	
	translate([0.5*MountingWidth + 0.5*SegWidth,0,0])
		%Digit();
}

if (Part == "Spacer")
{
	translate([-0.5*MountingWidth - 0.5*SpacerMountingWidth,0,0])
		%Digit();
	
	Spacer();
	
	translate([0.5*MountingWidth + 0.5*SpacerMountingWidth,0,0])
		%Digit();
}

if (Part == "Test")
{
//	difference(){
		SegBody(0,0);	
//		cube([50,50,50]);
//	}
}


echo("Digit Height =", DigitHeight);
echo("Digit Width =", SegLength+SegWidth);
echo("Clock Mounting Size =", ColonMountingWidth+4*MountingWidth, MountingHeight);
echo("LED Distance =", LED_Distance);
echo("LEDs =", LED_per_Seg*7);
