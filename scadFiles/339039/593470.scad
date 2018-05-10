// Template for Delta Printer Effector and Lift with magnetic Joints
// by Jochen Krapf

// preview[view:north west, tilt:top diagonal]

/* [Global] */

// To render the parts choose the correcponding Part Name

Part = "Effector";   // [Effector:Effoector Plate,Lift:Vertical Lift / Carriage]

// Parameters

// Diameter of the bearing balls in mm
BallDiameter = 12;

// Outer diameter of the ring magnets in mm
MagnetOuterDiameter = 10;
// Inner diameter of the ring magnets in mm (the circle where the ball touches the magnet)
MagnetInnerDiameter = 6;
// Height of the ring magnets in mm
MagnetHeight = 3;
MagnetHolderDiameter = MagnetOuterDiameter + 5;
MagnetOffset = sqrt(BallDiameter*BallDiameter - MagnetInnerDiameter*MagnetInnerDiameter) / 2;

JointDistance = 60;
JointRestAngle = 30;

/* [Effector] */

JointOffsetCenterEff = 27;

/* [Lift] */

JointOffsetCenterLift = 12;

/* [Hidden] */

// Level of Details - Set to 0.1 for export to stl
$fs = 0.25;

PlateCutOff = BallDiameter/2+MagnetHeight+1;

Rotations = [ [0,0,0], [0,0,120], [0,0,240] ];

ShowBalls = 1;
ShowMagnets = 1;


// Modules

module baseBall()
{
	% color([ 0.7, 0.7, 0.7 ])
		sphere (BallDiameter/2);
}

module baseMagnet()
{
	% color([ 0.5, 0.5, 0.5 ])
	translate([0, 0, -(MagnetOffset+MagnetHeight)])
	difference() 
	{
		cylinder (r=MagnetOuterDiameter/2, h=MagnetHeight);
		
		translate([0, 0, -2])
			cylinder (r=MagnetInnerDiameter/2, h=MagnetHeight+4);
	}
}

module baseMagnetDrill()
{
	translate([0, 0, -(MagnetOffset+MagnetHeight)])
		cylinder (r=MagnetOuterDiameter/2, h=MagnetHeight*2, $fa=2);
}

module baseMagnetHolder()
{
	translate([0, 0, -(MagnetOffset+MagnetHeight)-7])
		minkowski()
		{
			cylinder (r=MagnetHolderDiameter/2-2, h=MagnetHeight+5);
			sphere (2);
		}
}

module PairBall()
{
	rotate([-JointRestAngle,0,0])
	{
		translate([-JointDistance/2,0,0])
			baseBall();
		translate([JointDistance/2,0,0])
			baseBall();
	}
}

module PairMagnet()
{
	rotate([-JointRestAngle,0,0])
	{
		translate([-JointDistance/2,0,0])
			baseMagnet();
		translate([JointDistance/2,0,0])
			baseMagnet();
	}
}

module PairMagnetHolder()
{
	rotate([-JointRestAngle,0,0])
	{
		translate([-JointDistance/2,0,0])
			baseMagnetHolder();
		translate([JointDistance/2,0,0])
			baseMagnetHolder();
	}
}

module PairMagnetDrill()
{
	rotate([-JointRestAngle,0,0])
	{
		translate([-JointDistance/2,0,0])
			baseMagnetDrill();
		translate([JointDistance/2,0,0])
			baseMagnetDrill();
		translate([0,0,-40])
			cylinder (r=1.5, h=50);
	}
}

module LiftPlate()
{
	difference() 
	{
	hull()
	{
		translate([0,JointOffsetCenterLift,0])
			PairMagnetHolder();
		rotate([0,0,180]) 
			translate([0,JointOffsetCenterLift,0])
				PairMagnetHolder();
	}

	translate([-100,-200,-100])
		cube([200,200,200]);

	translate([-100,-100,-(50+PlateCutOff)])
		cube([200,200,50]);

	translate([0,JointOffsetCenterLift,0])
		PairMagnetDrill();

}

	if (ShowBalls==1)
	{
		translate([0,JointOffsetCenterLift,0])
			# PairBall();
	}
	if (ShowMagnets==1)
	{
		translate([0,JointOffsetCenterLift,0])
			PairMagnet();
	}

}

module EffectorPlate()
{
	difference() 
	{
	hull()
	{
		for (r = Rotations)
			rotate(r)
			{
				translate([0,JointOffsetCenterEff,0])
					PairMagnetHolder();
			}
	}

	translate([-100,-100,-(50+PlateCutOff)])
		cube([200,200,50]);

		for (r = Rotations)
			rotate(r)
			{
				translate([0,JointOffsetCenterEff,0])
					PairMagnetDrill();
			}

}

	if (ShowBalls==1)
	{
		for (r = Rotations)
			rotate(r)
			{
				translate([0,JointOffsetCenterEff,0])
					PairBall();
			}
	}

	if (ShowMagnets==1)
	{
		for (r = Rotations)
			rotate(r)
			{
				translate([0,JointOffsetCenterEff,0])
					PairMagnet();
			}
	}
}

module UserNozzleHolder()
{
	NozzleRadius = 8;

	difference() 
	{
		translate([0, 0, 0.01])
		hull()
		{
			cylinder (r1=NozzleRadius+2+7.5, r2=NozzleRadius+2, h=15);
			translate([0, NozzleRadius+5, PlateCutOff])
				rotate([0, 90, 90])
					cube([10,8,6], center = true);   // M4 nut
		}
	

		hull()
		{
			translate([0, -1, -20])
				cylinder (r=NozzleRadius-0.5, h=40);   // 16mm nozzle diameter
			translate([0, 1, -20])
				cylinder (r=NozzleRadius+0.5, h=40);   // 16mm nozzle diameter
		}

				translate([0, 0, PlateCutOff+2])
					rotate([0, 90, 90])
						cylinder (r=2, h=40);   // M4 screw

				translate([0, NozzleRadius+4, PlateCutOff+2])
					rotate([0, 90, 90])
						#cube([8,7,3.6], center = true);   // M4 nut
	}

}

module UserNozzleHolderDrill()
{
	translate([0, 0, -20])
		cylinder (r=10, h=40);
}

module UserEffectorPlate()
{
	difference() 
	{
	union() 
	{
	difference() 
	{
		translate([0, 0, PlateCutOff])
			EffectorPlate();

		// Nozzle Holder bas hole (example)
		UserNozzleHolderDrill();
	}

	// Nozzle Holder (example)
	color([ 0.5, 0.5, 1 ])
		UserNozzleHolder();
	}

		// Mounting Holes (example)
		for (r = Rotations)
			rotate(r)
			{
				rotate([0, 0, 90])
				translate([-23.094, 0, -2])
						cylinder (r=1.6, h=40);   // M3 screw
			}

		// Cable Holes (example)
			hull()
			{
				translate([-2, -16, -2])
						cylinder (r=3, h=40);   // M3 screw
				translate([2, -16, -2])
						cylinder (r=3, h=40);   // M3 screw
			}

	// Fan Holder (example)

	}
}

module UserLiftPlate()
{
	union()
	{
	difference() 
	{
		translate([0, 0, PlateCutOff])
			LiftPlate();

	// Additional Mounting Holes (example)

	}

	// User Mounting Plate (example)
	translate([-25,0,0])
		cube([50,4,25]);
	}

}

// Use Modules

if (Part == "Effector")
    UserEffectorPlate();

if (Part == "Lift")
    UserLiftPlate();
