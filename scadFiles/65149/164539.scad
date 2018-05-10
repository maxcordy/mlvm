include <MCAD/units.scad>
include <MCAD/math.scad>
use <MCAD/motors.scad>
use <MCAD/fonts.scad>
use <MCAD/regular_shapes.scad>

inches_per_mm = 1/25.4;

//RenderMode: Machine is the whole thing, 2D Projection is set up to render a version OpenSCAD can convert to a DXF file.  All other options render specific parts.
mode="Machine";//["Machine","2DProjection"]

// preview[view:north west]

/* [Base Parameters] */
//Length of the Work Surface (constrains YAxis, inches)
BaseLength = 24;//[12:48]

//Width of the Work Surface (constrains XAxis, inches)
BaseWidth=15;//[12:24]

//Number of Risers supporting the work surface (internal detail)
NumRisers = 3;//[3:12]

//Height of the base (inches)
BaseHeight=3;//[2.5:6]

//Thickness of the wood used (inches)
BaseBoardThickness = 0.5;//[0.25,0.50,0.75,1.0,1.25,1.5]

//Distance that the base extends the width of work surface for Y Axis motor mounts (Inches)
BaseExtension = 4;//[4:8]


//Distance between T-Slots on the work surface (inches)
slotgap = 2;//[2:6]

BaseRiserGap = (BaseWidth - 7*BaseBoardThickness)/NumRisers;


//Rail Dimensions

//Thickness of the metal of the rail (inches)
RailThickness = 0.2;//[0.05,0.10,0.15,0.20,0.25,0.30,0.35,0.40,0.45,0.5]

//Height of the guide rails (inches)
RailHeight=1;//[0.25,0.5,0.75,1.0,1.25,1.5]

//Width of the guide rails (inches)
RailWidth= 1;//[0.25,0.5,0.75,1.0,1.25,1.5]


//T-Slot interior size (1/8 inches)
TSlotInsideSizeEights=3;//[1:8]
TSlotInsideSize = TSlotInsideSizeEights/8;

//T-Slot bolt size (1/8 inches)
TSlotGapSizeEights=2;//[1:8]
TSlotGapSize = TSlotGapSizeEights/8;

//T-Slot metal Thickness(inches)
TSlotThickness = 0.05; //[0.05,0.10,0.15,0.20,0.25,0.30,0.35,0.40,0.45,0.5]

//T-Slot Height(inches)
TSlotHeight = 0.35;//[0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9,0.95,1.0]

TSlotWidth = TSlotInsideSize + 2 * TSlotThickness;

//608 Bearings (convert to inches)
RollerInsideRadius = 4 * inches_per_mm;
RollerOutsideRadius = 11* inches_per_mm;
RollerWidth = 7* inches_per_mm;

NutHeight=RollerWidth;
NutRadius=8*inches_per_mm;

//Gantry

//Distance between rollers on gantry arm (sets width of arms, inches)
gantryRollerGap = 5;//[3:8]

gantryArmWidth = gantryRollerGap + 3 * RollerOutsideRadius;

//Height of the entire gantry arm (constrains Z Axis, inches)
gantryArmHeight = 15;//[10:24]

//Height of boards spanning gantry (inches)
gantryTopHeight = 2;//[2:6]

//Width of cut-out slot in all axes for the drive rod to pass through (inches)
gantryDriveSlotWidth=2;//[0.5,1.0,1.5,2.0,2.5,3.0]

gantryDriveSlotDepth= BaseBoardThickness/3;

//Width of the board that moves on the XAxis.  The zAxis rides this one (inches)
gantryXAxisWidth = 2.5;//[1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0]

gantryXAxisHeight = gantryTopHeight + 4*RollerOutsideRadius + 2* RailHeight;

//Extra height of XAxis board over the distance between the rollers (constrains Z-Axis movement range, inches)
gantryXAxisExtraHeight = 5; //[2:8]

gantryXAxisBoardHeight = gantryXAxisHeight + gantryXAxisExtraHeight;

gantryZAxisWidth = gantryXAxisWidth + 2 * RailHeight + 4*RollerOutsideRadius;

//Distance between rollers on Z-Axis (inches)
gantryZAxisHeight = 4;//[3:10]

//Extra height added below Z-Axis rollers to move tool down to work surface(inches)
gantryZAxisExtraHeight = 2;//[1.5:5]

gantryZAxisBoardHeight = gantryZAxisHeight + gantryZAxisExtraHeight;

//Mock up CNC cutting tool radius (inches)
toolRadius = 1;//[1:5]

//Mock up CNC Cutting tool height (inches)
toolHeight = 4;//[3:8]

//Mock up CNC Cutting tool bit length (inches)
toolBitHeight=3;//[1:5]

toolBitRadius=0.125;

gantryZAxisSupportHeight = 2.0;

zAxisGuideRodLength = 4.5 * RollerWidth;

//Drive rod extension beyond X-Axis (inches)
XAxisDriveExtension = 1;//[0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0]

//Drive rod extension beyond Y-Axis (inches)
YAxisDriveExtension = 2;//[1:4];

//Drive rod extension beyond Y-Axis (inches)
ZAxisDriveExtension = 1;//[1,1.25,1.5,1.75,2.0]

//Distance from the end of the motor shaft to the drive rod to allow for a coupler (mm)
MotorOffset = 65;//[25:100]
MotorToRodOffset = MotorOffset * inches_per_mm;


DriveRodRadius = 4* inches_per_mm;


MinYPosition = RollerOutsideRadius;
MaxYPosition = BaseLength - gantryArmWidth;

MinXPosition = gantryZAxisWidth/2 - RailHeight; 
MaxXPosition = BaseWidth - MinXPosition- 2*RollerOutsideRadius - 2*RailWidth;

MinZPosition =  -gantryZAxisHeight/2-gantryXAxisBoardHeight + RollerOutsideRadius;
MaxZPostition = MinZPosition + gantryXAxisBoardHeight-gantryZAxisHeight;


MaxXTravel=MaxXPosition - MinXPosition;
MaxYTravel=MaxYPosition - MinYPosition;
MaxZTravel=MaxZPostition - MinZPosition;

echo("MaxXTravel-Working volume limit (mm)",MaxXTravel*25.4);
echo("MaxYTravel-Working volume limit (mm)",MaxYTravel*25.4);
echo("MaxZTravel-Working volume limit (mm)",MaxZTravel*25.4);

cz = MaxZTravel/2 + MaxZTravel/2 * sin(1080* $t);
cy = MaxYTravel/2 + MaxYTravel/2 * sin(540 * $t);
cx = MaxXTravel/2 + MaxXTravel/2 * sin(360 *$t);

//Position
MachineY = cy;
MachineX = cx;
MachineZ = cz;

/* [Rendering Parameter] */

//Current Y Position (%Max Travel)
MachineYPct = 50;//[0:100]
//Current X Position (%Max Travel)
MachineXPct = 50;//[0:100]
//Current Z Position (%Max Travel)
MachineZPct = 50;//[0:100]

//MachineY = MachineYPct/100 * MaxYTravel;
//MachineX = MachineXPct/100 * MaxXTravel;
//MachineZ = MachineZPct/100 * MaxZTravel;

module Nema14(drawmode="motor")
{
	//The motor library is in MM, but this design was created in inches - I would
	//love to fix that some day, but for the moment, this will keep things in
	//scale
	if(drawmode == "motor")
	{
		scale([inches_per_mm,inches_per_mm,inches_per_mm])
		{
		_stepper_motor_mount(
			motor_shaft_diameter = 5 *mm,
			motor_shaft_length = 20*mm,
			pilot_diameter = 22*mm,
			pilot_length = 2*mm,
			mounting_bolt_circle = 37*mm,
			bolt_hole_size = 4*mm,
			bolt_hole_distance = 26*mm,
			slide_distance = 3*mm,
			mochup = true,
			tolerance= 0);
		}
	}
	else if (drawmode=="mount")
	{
		translate([0,0,0.1])
		{
			linear_extrude(height=BaseBoardThickness + 0.2)
			{
				scale([inches_per_mm,inches_per_mm,inches_per_mm])
				{
					_stepper_motor_mount(
						motor_shaft_diameter = 5 *mm,
						motor_shaft_length = 20*mm,
						pilot_diameter = 23*mm,
						pilot_length = 2*mm,
						mounting_bolt_circle = 37*mm,
						bolt_hole_size = 4*mm,
						bolt_hole_distance = 26*mm,
						slide_distance = 3*mm,
						mochup = false,
						tolerance= 0);
				}
			}
		}
	}
}


module workBase()
{
	difference() 
	{
		cube([BaseWidth,BaseLength,BaseBoardThickness]);
		translate([0,-0.5,0])
		{
			for(slotpost = [RailWidth +1: slotgap : BaseWidth-RailWidth-1])
			{
				translate([slotpost,0,BaseBoardThickness-TSlotHeight])
					cube([TSlotWidth,BaseLength +1, TSlotHeight+1]);	
			}
		}
	}
}

module riser()
{
	cube([BaseBoardThickness,BaseLength - 2*BaseBoardThickness, BaseHeight-BaseBoardThickness]);
}

module bottom()
{
	%cube([BaseWidth,BaseLength,BaseBoardThickness]);
}

module yaxisMotorSupportHorzPlate()
{
cube([BaseWidth+BaseExtension, MotorToRodOffset - BaseBoardThickness,BaseBoardThickness]);
}

module workSurface()
{
	color([0.1,0.3,0.1,0.5]) cube([BaseWidth -5*RailWidth,BaseLength-6*BaseBoardThickness, BaseBoardThickness]);
}

module base()
{
	workBase();
	translate([2.5*RailWidth,3*BaseBoardThickness,BaseBoardThickness]) workSurface();


	for(slotpost = [RailWidth + 1: slotgap : BaseWidth-RailWidth-1])
	{
		translate([slotpost,0,BaseBoardThickness-TSlotHeight])
			tslot(BaseLength);
	}

	translate([0,0,-BaseHeight]) 
	{
		bottom(); 

		translate([3*BaseBoardThickness,BaseBoardThickness,BaseBoardThickness])	riser();
	

		for(x= [3*BaseBoardThickness +BaseRiserGap : BaseRiserGap : BaseWidth-4*BaseBoardThickness]) 
		{
			translate([x,BaseBoardThickness,BaseBoardThickness])
			{
				riser();
			}

	
		}

		translate([BaseWidth-4*BaseBoardThickness,BaseBoardThickness,BaseBoardThickness])
				riser(); 
	
	
		translate([-BaseExtension/2,0,0])
		{
			
			basePlate();


			translate([0,-MotorToRodOffset+ BaseBoardThickness,0]) 
			{
				yaxisMotorSupportHorzPlate();
				translate([0,0,BaseHeight-1.4]) 
					yaxisMotorSupportHorzPlate();
				translate([0,-BaseBoardThickness,0])	basePlate(bearing=false, mmount=true);
			}
			translate([0,BaseLength-BaseBoardThickness,0])
			{
				translate([0,BaseBoardThickness,0]) mirror([0,1,0]) basePlate();
			}
	
			translate([BaseExtension/2-RollerOutsideRadius-RollerWidth-BaseBoardThickness+gantryDriveSlotDepth,
				0,
				BaseHeight+BaseBoardThickness/2])
			{
				gantryDriveUnit();

			}

			translate([BaseWidth + BaseExtension/2+RollerOutsideRadius+RollerWidth+BaseBoardThickness-gantryDriveSlotDepth,
				0,
				BaseHeight+BaseBoardThickness/2])
			{
				gantryDriveUnit();
			}
		}
	}

	translate([0,0,BaseBoardThickness]) rotate([0,0,0])  rail(BaseLength);
	translate([0,BaseLength-BaseBoardThickness,0]) rotate([180,0,0]) rail(BaseLength-BaseBoardThickness*2);


	translate([BaseWidth,0,0])	mirror([1,0,0])
	{
		translate([0,0,BaseBoardThickness]) rotate([0,0,0])  rail(BaseLength);
		translate([0,BaseLength-BaseBoardThickness,0]) rotate([180,0,0]) rail(BaseLength-BaseBoardThickness*2);
	}

}

module gantryDriveUnit()
{
	translate([0,-YAxisDriveExtension/2,0])
	{
		rotate([90,0,180]) 
		{
			color("black") 
			{
				cylinder(r=DriveRodRadius, h=BaseLength + YAxisDriveExtension,$fn=20, center=false);
			}
		}
	}
	
	translate([0,-MotorToRodOffset,0])
	{
		//marker();
		 rotate([0,0,-90]) motor14();
	}
}

module basePlate(bearing = true, mmount=false)
{

	difference()
	{
		union()
		{
			cube([BaseWidth+BaseExtension, BaseBoardThickness, BaseHeight]);

			cube([BaseExtension/2 ,BaseBoardThickness,BaseHeight+BaseBoardThickness+RailHeight]);
			translate([BaseWidth+BaseExtension/2,0,0])
			{
				cube([BaseExtension/2,BaseBoardThickness,BaseHeight+BaseBoardThickness+RailHeight]);
			}
		}

		translate([BaseExtension/2-RollerOutsideRadius-RollerWidth-BaseBoardThickness+gantryDriveSlotDepth,
				BaseBoardThickness+RollerWidth-0.1,
				BaseHeight+BaseBoardThickness/2])
		{
			
			//	color("red") sphere(r=0.3,$fn=20);
			//%marker();
			if(mmount == true)
			{
				rotate([90,0,0]) Nema14(drawmode="mount");
			}
			else
			{
				translate([0,-BaseBoardThickness+RollerWidth,0])
				{
					rotate([90,0,0]) cylinder(h=RollerWidth+0.2 , r=RollerOutsideRadius, $fn=20);
				}
				rotate([90,0,0])
				{
					 cylinder(h=BaseBoardThickness + 0.2, r=RollerOutsideRadius*0.9, $fn=20);
				}
			}
		}

		translate([BaseWidth + BaseExtension/2+RollerOutsideRadius+RollerWidth+BaseBoardThickness-gantryDriveSlotDepth,
			BaseBoardThickness+RollerWidth-0.1,
			BaseHeight+BaseBoardThickness/2])
		{
			if(mmount == true)
			{
				rotate([90,0,0]) Nema14(drawmode="mount");
			}
			else
			{
				translate([0,-RollerWidth,0])
				{
					rotate([90,0,0]) cylinder(h=RollerWidth+0.2 , r=RollerOutsideRadius, $fn=20);
				}
				rotate([90,0,0])
				{
					 cylinder(h=BaseBoardThickness + 0.2, r=RollerOutsideRadius*0.9, $fn=20);
				}
			}
		}
		
	}
	
	if(bearing)
	{
		translate([BaseExtension/2-RollerOutsideRadius-RollerWidth-BaseBoardThickness+gantryDriveSlotDepth,
					0,
					BaseHeight+BaseBoardThickness/2])
		{
			rotate([0,0,90]) 
			{
				Bearing608(nut1=true,nut2=true);
			}
		}

		translate([BaseWidth + BaseExtension/2+RollerOutsideRadius+RollerWidth+BaseBoardThickness-gantryDriveSlotDepth,
				0,
				BaseHeight+BaseBoardThickness/2])
		{
			rotate([0,0,90])
			{
				Bearing608(nut1=true,nut2=true);
			}
		}
	}
}

module rail(length = 1)
{
	color("silver") {
		translate([0,length,0])
		rotate([90,0,0])
		linear_extrude(height=length)
		polygon(
			points = [
						[0,0],
						[0,RailHeight],
						[RailThickness,RailHeight-RailThickness],
						[RailThickness,RailThickness],
						[RailWidth,RailThickness],[RailWidth,0]
						]
		);
		
	}
}



module tslot(length = 1)
{
	TSlotDiff = TSlotInsideSize - TSlotGapSize;
	color("thistle") {
		translate([0,length,0])
		rotate([90,0,0])
		linear_extrude(height=length)
		polygon(
			points = [
						[0,0],
						[0,TSlotHeight],
						[TSlotDiff+TSlotThickness,TSlotHeight],
						[TSlotDiff+TSlotThickness,TSlotHeight-TSlotThickness],
						[TSlotThickness,TSlotHeight-TSlotThickness],
						[TSlotThickness,TSlotThickness],
						[TSlotThickness+TSlotInsideSize,TSlotThickness],
						[TSlotThickness+TSlotInsideSize,TSlotHeight-TSlotThickness],
						[TSlotThickness+TSlotInsideSize-TSlotDiff,TSlotHeight-TSlotThickness],
						[TSlotThickness+TSlotInsideSize-TSlotDiff,TSlotHeight],
						[TSlotThickness+TSlotInsideSize+TSlotThickness,TSlotHeight],
						[TSlotThickness+TSlotInsideSize+TSlotThickness,0]
				
						]
		);
		
	}
}

module Bearing608(nut1=false,nut2=false)
{
	cntBearing = cntBearing + 1;
	rotate([0,90,0])  
	{
		if(nut1)
		{
			color("silver") translate([0,0,-NutHeight]) myNut();
		}
		if(nut2)
		{
			color("silver") translate([0,0,RollerWidth]) myNut(); 
		}
		color("skyblue") 
		{
			difference() 
			{
				cylinder(h=RollerWidth, r=RollerOutsideRadius,  $fn=20);
				translate([0,0,-0.01])
				{ 
					cylinder(h=RollerWidth+0.02, r=RollerInsideRadius*1.4, $fn=20);
				}
			}
		}
		color("blue") 
		{
			difference() 
			{
				cylinder(h=RollerWidth, r=RollerInsideRadius*1.4,  $fn=20);
				translate([0,0,-0.01])
				{ 
					cylinder(h=RollerWidth+0.02, r=RollerInsideRadius,  $fn=20);
				}
			}
		}
	}
}


module roller()
{
	Bearing608(nut1=true);
	translate([RollerWidth+0.02,0,0]) Bearing608(nut2=true);
}


module gantryRollers()
{
		for(offset=[0,gantryRollerGap])
		{
			translate([0,offset,RollerOutsideRadius + BaseBoardThickness+RailHeight]) roller();
		}
		for(offset=[0,gantryRollerGap])
		{
			translate([0,offset,-RollerOutsideRadius -RailHeight]) roller();
		}
}



module gantryArm(bearings=true)
{
	translate([-RollerWidth-BaseBoardThickness,-RollerOutsideRadius,-RailHeight-2*RollerOutsideRadius]) 
	{
		color("peru") 
		{
			difference() 
			{
				cube([BaseBoardThickness,gantryArmWidth,gantryArmHeight]);
				translate([-BaseBoardThickness+gantryDriveSlotDepth,
							-0.1,
							((RailHeight+RollerOutsideRadius*2)+BaseBoardThickness)/2 
					])
				{
					cube([BaseBoardThickness,gantryArmWidth + 0.2,gantryDriveSlotWidth]);
				}
				
				translate([-0.1,BaseBoardThickness+DriveRodRadius,gantryArmHeight-gantryTopHeight/2])
				{

					translate([RollerWidth,0,0])
					{
						rotate([0,90,0]) cylinder(h=RollerWidth+0.1 , r=RollerOutsideRadius, $fn=20);
						
					}
					rotate([0,90,0]) cylinder(h=BaseBoardThickness + 0.2, r=RollerOutsideRadius*0.9, $fn=20);

				}
			}
		}

		if(bearings == true)
		{
			translate([0,BaseBoardThickness+DriveRodRadius,gantryArmHeight-gantryTopHeight/2])
			{
				Bearing608(nut1=true,nut2=true);
			}
		}
	}

	if(bearings == true)
	{
		translate([-RollerWidth,RollerOutsideRadius/2,0]) 
		{
			gantryRollers();
		}
	}
}

module xAxisBoard()
{

	color("olive")
	{	
		cube([gantryXAxisWidth, BaseBoardThickness,
		gantryXAxisBoardHeight+ZAxisDriveExtension/2 + MotorToRodOffset -
		2*BaseBoardThickness]);
	}
}

module zAxisRodSupport(mmount=false)
{
	color("olive") 
	{
		difference()
		{
			cube([gantryXAxisWidth, gantryZAxisSupportHeight, BaseBoardThickness]);
		
			if(mmount == true)
			{
				 translate([gantryXAxisWidth/2, gantryZAxisSupportHeight/2 ,-0.2])
				{
					rotate([0,0,90]) Nema14(drawmode="mount");
				}
			}
			else
			{
				translate([gantryXAxisWidth/2, gantryZAxisSupportHeight/2,BaseBoardThickness-RollerWidth])
				{
					cylinder(h=RollerWidth+0.1, r=RollerOutsideRadius,$fn=20);
				}
				translate([gantryXAxisWidth/2, gantryZAxisSupportHeight/2,-0.1])
				{
					cylinder(h=BaseBoardThickness+0.2, r=RollerOutsideRadius*0.9,$fn=20);
				}
			}
		}
	}
}

module gantryXAxis()
{
	translate([0,BaseBoardThickness/2+RollerWidth ,0])
	{

		translate([0,0,
			-2*RailHeight-4*RollerOutsideRadius
				+ gantryArmHeight-gantryTopHeight 
				])
		{
			translate([0,0, gantryArmHeight-BaseBoardThickness-4*RailHeight-4*RollerOutsideRadius-gantryXAxisBoardHeight])
			{
				//color("red") sphere(r=0.3,$fn=20);
				translate([0,-BaseBoardThickness/2-RollerWidth,MachineZ + MinZPosition])
				{
					gantryZAxis();
				}
	
				
				xAxisBoard();
				
				
				translate([0,BaseBoardThickness,gantryXAxisBoardHeight -BaseBoardThickness])
				{
					
					zAxisRodSupport();

					translate([0,0,MotorToRodOffset+ZAxisDriveExtension/2-2*BaseBoardThickness])
					{
						zAxisRodSupport(mmount=true);
					}
			

					translate([gantryXAxisWidth/2,gantryZAxisSupportHeight/2,
					MotorToRodOffset + ZAxisDriveExtension/2 - BaseBoardThickness]) 
						rotate([0,-90,90]) motor14();

					color("black")	
					translate([gantryXAxisWidth/2,gantryZAxisSupportHeight/2,
					BaseBoardThickness + ZAxisDriveExtension/2]) 
					{	%marker();

						rotate([0,180,0]) 
								cylinder(r=DriveRodRadius, h=gantryXAxisBoardHeight + ZAxisDriveExtension,$fn=20);
					}

					translate([gantryXAxisWidth/2,gantryZAxisSupportHeight/2, BaseBoardThickness]) 
						rotate([0,90,0]) Bearing608(nut1=true,nut2=true);
				}
				translate([0,BaseBoardThickness,0])
				{
					zAxisRodSupport();
					translate([gantryXAxisWidth/2,gantryZAxisSupportHeight/2, BaseBoardThickness]) 
						rotate([0,90,0]) Bearing608(nut1=true,nut2=true);
				}
				translate([0,RailWidth,0])
				{
					rotate([90,0,-90]) rail(gantryXAxisBoardHeight);
					translate([gantryXAxisWidth,0,0])
					{
						mirror([1,0,0]) rotate([90,0,-90]) rail(gantryXAxisBoardHeight);
					}
				}
			}

			translate([RollerOutsideRadius,0,RollerOutsideRadius])
			{	
				rotate([0,0,-90]) roller();
				translate([gantryXAxisWidth - 2* RollerOutsideRadius,0,0]) rotate([0,0,-90]) roller();
			
				translate([0,0,gantryXAxisHeight - RollerOutsideRadius*2])
				{	
					rotate([0,0,-90]) roller();
					translate([gantryXAxisWidth - 2* RollerOutsideRadius,0,0]) rotate([0,0,-90]) roller();
				}
			}
		}
	}
}


module zAxisBoard()
{
	color("LightCyan") difference() 
	{
		cube([gantryZAxisWidth, BaseBoardThickness, gantryZAxisBoardHeight]);
			
		translate([
				(gantryZAxisWidth - gantryXAxisWidth*1.2)/2,
				gantryDriveSlotDepth - BaseBoardThickness,
				-0.1])
		{
				cube([gantryXAxisWidth*1.2,BaseBoardThickness,gantryZAxisBoardHeight+0.2]);
		}

		translate([0,0,(gantryZAxisBoardHeight - gantryZAxisHeight)])
			zAxisRollerRods();
	}

}

module myNut()
{
	cntNut = cntNut + 1;
	color("silver")
		hexagon_prism(NutHeight,NutRadius);
}

module zAxisRollerRods()
{
	translate([RollerOutsideRadius,-zAxisGuideRodLength,RollerOutsideRadius]) 
	{
		zAxisGuide();
				
				
		translate([0,0,gantryZAxisHeight - 2*RollerOutsideRadius])
		{
			zAxisGuide();
		}
	

	translate([gantryZAxisWidth - 2*RollerOutsideRadius,0,0])
	{
		zAxisGuide();

		translate([0,0,gantryZAxisHeight - 2*RollerOutsideRadius])
		{
			zAxisGuide();
		}
	}
	}
}

module zAxisGuide()
{
	rotate([0,0,90]) roller();
	rotate([-90,0,0]) 
	{
		translate([0,0,zAxisGuideRodLength+BaseBoardThickness])
		{
			myNut();
			translate([0,0,-BaseBoardThickness-NutHeight]) myNut();
		}
		color("black") 
		{
			translate([0,0,-0.5]) 
			{
				cylinder(r=DriveRodRadius,h=zAxisGuideRodLength+BaseBoardThickness+1.0, $fn=20);
			}
		}
	}
}

module gantryZAxis()
{
	translate([
				-RailWidth -2*RollerOutsideRadius,
				BaseBoardThickness + 2*RollerWidth + zAxisGuideRodLength,
				-2*RailHeight-4*RollerOutsideRadius + gantryArmHeight+RailHeight])
	{
			
		translate([0,0,-(gantryZAxisBoardHeight - gantryZAxisHeight)])
		{
			zAxisBoard();
		}
	
		
		translate([gantryZAxisWidth/2,toolRadius+BaseBoardThickness,-toolHeight/3])
		{
			color("darkcyan")
			{
				cylinder(h=toolHeight, r=toolRadius, center=true, $fn=20);
			}
			color("grey")
			{
				translate([0,0,-toolHeight])
				cylinder(h=toolBitHeight, r=toolBitRadius,cetner=true,$fn=20);
			}
		}
	
		zAxisRollerRods();
	}
}

module motor14()
{
	translate([-45* inches_per_mm,0,0])
	{
		rotate([0,90,0])
			{
			color("violet",0.5)
			{
				cylinder(h=25* inches_per_mm, r=10* inches_per_mm, $fn=20);
			}
		}
	}
	rotate([0,-90,0])
	{
		Nema14();
	}
}

module gantryTopBoard()
{
	color("peru")cube([BaseWidth + 2* RollerWidth, BaseBoardThickness, gantryTopHeight]);
}

module gantryRailBoard()
{
	color("peru") difference() 
	{
		gantryTopBoard();	
		translate([-0.1*RollerWidth,BaseBoardThickness-gantryDriveSlotDepth,(gantryTopHeight-(gantryDriveSlotWidth /2))/2])
		{
			cube([BaseWidth + 2.2* RollerWidth, BaseBoardThickness, gantryDriveSlotWidth/2]);
		}
	}
}


module gantryMotorSupportA()
{
	color("peru")cube([XAxisDriveExtension/2+MotorToRodOffset-2*BaseBoardThickness,gantryArmWidth,BaseBoardThickness]);
}

module gantryMotorSupportB()
{
	color("peru") difference()
	{
		cube([BaseBoardThickness,gantryArmWidth,gantryTopHeight+BaseBoardThickness+BaseBoardThickness]);
		translate([-0.15,
			BaseBoardThickness+DriveRodRadius,
			BaseBoardThickness+gantryTopHeight/2]) 
		{
			rotate([90,0,90]) 
			{
				Nema14(drawmode="mount"); 
				
			}
		}
	}

	translate([BaseBoardThickness,BaseBoardThickness+DriveRodRadius,BaseBoardThickness + gantryTopHeight/2]) 
	{
		motor14();
	}

}

module gantryMotorSupportC()
{
	color("peru")
		mirror([1,0,0])
			cube([XAxisDriveExtension/2+MotorToRodOffset-3*BaseBoardThickness
				,gantryArmWidth
				,BaseBoardThickness]);
}

module gantryMotorSupport()
{

		gantryMotorSupportA();	
		translate([XAxisDriveExtension/2+MotorToRodOffset-2*BaseBoardThickness,0,-gantryTopHeight-BaseBoardThickness])
		{

			gantryMotorSupportB();
			gantryMotorSupportC();	
		}
}

module gantry()
{
	translate([0,MachineY+MinYPosition,0]) 
	{
		gantryArm();
		translate([BaseWidth,0,0]) mirror([1,0,0]) 
		{
			gantryArm();
		}
		translate([-RollerWidth,-RollerOutsideRadius,gantryArmHeight-RailHeight-2*RollerOutsideRadius-gantryTopHeight]) 		
		{
			
				translate([0,0,-gantryXAxisHeight/1.4])
				{
					gantryTopBoard();
				}
				
				translate([0,gantryArmWidth-BaseBoardThickness,0])
				{
					gantryTopBoard();	
				}
				

				
			gantryRailBoard();	


			translate([0,RailWidth,gantryTopHeight])
			{
				
				rotate([0,0,-90])
				{
					rail(BaseWidth+2*RollerWidth);
					translate([0,0,-gantryTopHeight])mirror([0,0,1]) rail(BaseWidth+2*RollerWidth);
				}

				translate([BaseWidth+2*RollerWidth,-RailWidth,0]) 
				{
					gantryMotorSupport();
				}
			}
		}

				
		translate([-BaseBoardThickness-RollerWidth,
						0,
						-RailHeight-RollerOutsideRadius*2+gantryArmHeight-gantryTopHeight/2])
		{
				translate([-XAxisDriveExtension/2,
							DriveRodRadius +BaseBoardThickness-MinYPosition,
							0])
				{
					rotate([0,90,0]) 
					{
						color("black")
							cylinder(h=BaseWidth+2*RollerWidth+2*BaseBoardThickness + XAxisDriveExtension, r=DriveRodRadius, $fn=20);
					}
					
				}

		}

		translate([MachineX+MinXPosition,0,0])
		{
			gantryXAxis();

		}
	}
}


module marker()
{
	color("red") sphere(r=0.2, $fn=20, center=true);
}

thisFont=8bit_polyfont();
x_shift=thisFont[0][0];
y_shift=thisFont[0][1];

module label(text)
{
	
	scale([0.08,0.08])
	assign(theseIndicies = search(text, thisFont[2],1,1))
	{
	for(j =[0:len(theseIndicies)-1]) 
		translate([j*x_shift,-y_shift/2])
			polygon(points=thisFont[2][theseIndicies[j]][6][0], 
						paths=thisFont[2][theseIndicies[j]][6][1]);
	}
}



los=1;

if(mode=="Machine")
{
	base();
	gantry();
}
else if(mode=="2DProjection")
{
	projection() workSurface();
	translate([0,-(BaseBoardThickness+los),0]) 
	{
		projection() rotate([-90,0,0]) workSurface();
		translate([0,-los,0])	label("Work Surface");
	}

	translate([BaseWidth-5*RailWidth+2*los,0,0])
	{
		projection() workBase();

		translate([0,-(BaseBoardThickness+los),0]) 
		{
			projection() rotate([-90,0,0]) workBase();
			translate([0,-los,0])
			{
				label("Work Base");
			}
		}


	translate([BaseWidth + 2*los,0,0])
		{
			translate([0,0,-los]) label("End Plate (x2)");

			projection() rotate([-90,0,0]) basePlate(bearing=false);
			
			translate([0, BaseHeight + 5*los,0])
			{
				translate([0,-los,0]) label("End Plate - Motor Mount");

				projection() rotate([-90,0,0]) basePlate(bearing=false,mmount=true);
				
			}
		}
	}

	translate([-(gantryArmWidth + 2* los),0,0])
	{
		translate([0,-3*los,0]) label("arm (x2)");
		projection() rotate([0,-90,-90]) gantryArm(bearings=false);

		translate([-(BaseBoardThickness+los),0,0])
		{
			projection() rotate([90,0,180]) gantryArm(bearings=false);


			translate([-(2*los),0,0]) 
			{

				projection() rotate([-90,0,90]) gantryRailBoard();

				translate([0,-(BaseBoardThickness + los),0])
				{
					projection() rotate([-90,-90,90]) gantryRailBoard();
					translate([-gantryTopHeight-los,-los,0]) label("Gantry");
					translate([-gantryTopHeight-los,-2*los,0]) label("Span (x3)");

				}

				
				translate([-(gantryTopHeight + 2*los),0,0])
				{
					projection() rotate([90,0,180]) xAxisBoard();
					translate([-gantryXAxisWidth-los, 0, 0])
					{
						translate([0,-los,0]) label("X Axis");

					}
				}
			}
		}
	}
}
