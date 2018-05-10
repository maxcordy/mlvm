// by Les Hall
// started Sun Aug 17 2014
// 
// Robotic Arm based on 3D printed stepper motor
// 




// includes
include <MCAD/involute_gears.scad>




// base size (mm)
baseSize = [100, 100, 10];

// offset of Motor
motorOffset = [0, 0, 10];

// frame around base
keepOut = 5;

// size of motor base (mm)
motorBaseSize = [50, 50, 10];

// skateboard bearing size [ID, OD, H] (mm) 
bearingSize608ZZ = [8, 22, 7];

// small bearing size [ID, OD, H] (mm)
bearingSize623ZZ = [3, 10, 4];

// backlash amount
bl = 0.0;

// size of cylindrical magnet (mm)
magnetSize = [9.33, 9.33, 3];

// size of the rotor (mm)
rotorSize = [22, 22, 24];

// size of rotor shaft (mm)
rotorShaftSize = [5, 5, 10];

// number of bobbins (1)
numBobbins = 4;

// size of the bobbins (mm)
bobbinSize = [20, 20, 20];

// thickness of planetary gears (mm)
gearDepth = 5;

// diameter of ring gear
ringGearDiameter = 90;

// size of section 0 of arm (mm)
arm0Size = [40, 40, 10];

// diameter of non-tapped hole size for 440 bolt (mm)
boltDiameter440 = 4;

// wall thickness (mm)
walls = 2;

// clearance between components (mm)
clearance = 2;

// surface alignment (mm)
merge = 0.2;

// number of facets (facets)
$fn = 64;





// make it!
roboticArm();
//baseAssembly();
//motorBase();
//rotor();
//bobbin();

// the robot arm assembly
module roboticArm()
{
	// base assembly
	baseAssembly();

	translate(motorOffset)
	translate([0, 0, motorBaseSize[2]])
	translate([0, 0, rotorSize[2]])
	//rotate(45, [0, 0, 1])
	{
		// rotor with magnets built in
		rotate(180, [0, 1, 0])
		rotor();
	
		// bobbins
		translate([0, 0, -bobbinSize[0]/2])
		bobbinSet();
	
		elipticalGearAssembly();
	}
}


module elipticalGearAssembly()
{
	union()
	{
		// the gears
		elipticalGears();
	}
}


// annular ring extension down to case
module ringGearMount()
{
	color([0, 1, 0])
	translate([0, 0, -merge])
	difference()
	{
		cylinder(d=ringGearDiameter, 
			h=baseSize[2]+rotorSize[2]+clearance, 
			center=true);

		cylinder(d=ringGearDiameter-walls, 
			h=baseSize[2]+rotorSize[2]+clearance+merge, 
			center=true);
	}
}


module elipticalGears()
{
	cp = 200;
	teeth0 = 16;
	teeth1 = 23;
	sunCirc = cp*PI/180*teeth0;
	planetCirc = cp*PI/180*teeth1;
	planetRadius = sunCirc/2/PI + planetCirc/2/PI;
	annularCirc = 2*PI*(sunCirc/2/PI + planetCirc/PI);
	teeth2 = annularCirc/cp*180/PI;
echo(teeth2);
	gearRotation = [7.5, 3.5, 10.5];

	union()
	{
		// sun gear
		color([1, 0, 1])
		translate([0, 0, gearDepth])
		rotate(0, [0, 0, 1])
		rotate(180, [0, 1, 0])
		difference()
		{
			gear (
				number_of_teeth=teeth0,
				circular_pitch=cp, diametral_pitch=false,
				pressure_angle=28,
				clearance = 0.2,
				gear_thickness=gearDepth,
				rim_thickness=gearDepth,
				rim_width=0,
				hub_thickness=gearDepth,
				hub_diameter=0,
				bore_diameter=0,
				circles=0,
				backlash=-bl,
				twist=0,
				helix_angle=0,
				involute_facets=0,
				flat=false,
				roundsize=1,
				internal = false);
			translate([0, 0, bearingSize623ZZ[2]/2-merge])
			cylinder(d=bearingSize623ZZ[1], 
				h=bearingSize623ZZ[2]+merge, 
				center=true);
		}
	
		// planet gears
		color([0.5, 0, 0.5])
		for(t=[0:2])
		assign(theta=360*t/3)
		rotate(theta, [0, 0, 1])
		translate([0, 0, gearDepth])
		translate([planetRadius, 0, 0])
		rotate(180, [0, 1, 0])
		rotate(gearRotation[t], [0, 0, 1])
		difference()
		{
			gear (
				number_of_teeth=teeth1,
				circular_pitch=cp, diametral_pitch=false,
				pressure_angle=28,
				clearance = 0.2,
				gear_thickness=gearDepth,
				rim_thickness=gearDepth,
				rim_width=0,
				hub_thickness=gearDepth,
				hub_diameter=0,
				bore_diameter=0,
				circles=0,
				backlash=bl,
				twist=0,
				helix_angle=0,
				involute_facets=0,
				flat=false,
				roundsize=1,
				internal = false);
			translate([0, 0, bearingSize623ZZ[2]/2-merge])
			cylinder(d=bearingSize623ZZ[1], 
				h=bearingSize623ZZ[2]+merge, 
				center=true);
		}
		
		// annular gear
		color([1, 0, 1])
		translate([0, 0, gearDepth/2])
		rotate(180, [0, 1, 0])
		difference()
		{
			cylinder(d=ringGearDiameter, 
				h=gearDepth-merge, 
				center=true);
			translate([0, 0, -gearDepth/2])
			gear (
				number_of_teeth=teeth2,
				circular_pitch=cp, diametral_pitch=false,
				pressure_angle=28,
				clearance = 0.2,
				gear_thickness=gearDepth,
				rim_thickness=gearDepth,
				rim_width=0,
				hub_thickness=gearDepth,
				hub_diameter=0,
				bore_diameter=0,
				circles=0,
				backlash=-bl,
				twist=0,
				helix_angle=0,
				involute_facets=0,
				flat=false,
				roundsize=1,
				internal = false);
		}
	}
}


module bobbinSet()
{
	bobbin2RotorClearance = 2;
	C = -rotorSize[0]/2-bobbin2RotorClearance;

	for(t=[0:numBobbins-1])
	assign(theta=360*t/numBobbins)
	rotate(theta, [0, 0, 1])
	translate([C, 0, 0])
	rotate(-90, [0, 1, 0])
	bobbin();
}


// bobin
module bobbin()
{
	bobbinDiameter = bobbinSize[0];
	bobbinLength = bobbinSize[2];

	color([1, 0, 0])
	translate([0, 0, bobbinLength/2])
	difference()
	{
		union()
		{
			// main bobbin shaft
			cylinder(d=bobbinDiameter*9/16, 
				h=bobbinLength, 
				center=true);

			// top and bottom discs
			for(side=[-1:2:1])
			assign(dz=side*bobbinLength*7/16)
			translate([0, 0, dz])
			cylinder(d=bobbinDiameter, 
				h=bobbinLength*1/8, 
				center=true);

			// cones
			for(side=[-1:2:1])
			assign(dz=side*bobbinLength/8)
			translate([0, 0, dz])
			rotate(90-90*side, [0, 1, 0])
			cylinder(d1=bobbinDiameter/3, 
				d2=bobbinDiameter,
				h=bobbinLength/2,  
				center=true);
		}

		// hole for core metal
		cylinder(d1=bobbinDiameter/3, 
			d2=0, 
			h=bobbinLength+merge, 
			center=true);
	}
}


module rotor()
{
	numMagnets = 3;
	magnetAdjust = [1.0, 1.0, 1.0];
	shaftAdjust = 0.25;

	color([0, 1, 1])
	difference()
	{
		union()
		{
			// rotor shaft
			translate([0, 0, rotorSize[2]/2+bearingSize608ZZ[2]*3/2])
			cylinder(d=bearingSize608ZZ[0]+shaftAdjust, 
				h=bearingSize608ZZ[2], 
				center=true);
		
			// rotor body
			translate([0, 0, rotorSize[2]/2])
			cylinder(d=rotorSize[0], 
				h=rotorSize[2], 
				center=true);
		}

		// holes for magnets
		for(t=[0:numMagnets-1])
		assign(theta=360*t/numMagnets)
		rotate(theta, [0, 0, 1])
		translate([rotorSize[0]/2-magnetSize[2]-magnetAdjust[2]-1, 0, 0])
		translate([0, 0, rotorSize[2]/4])
		union()
		{
			cube(size=[magnetSize[2]+magnetAdjust[2], 
				magnetSize[0]+magnetAdjust[0], 
				rotorSize[2]/2+merge], 
				center=true);
			translate([0, 0, rotorSize[2]/4])
			rotate(90, [0, 1, 0])
			cylinder(d=magnetSize[0]+magnetAdjust[0], 
				h=magnetSize[2]+magnetAdjust[2], 
				center=true);
		}
	}
}


// base
module motorBase()
{
	bobbin2RotorClearance = 2;
	A = motorBaseSize[2];
	B = ringGearDiameter+merge;
	C = rotorSize[0]/2 + bobbinSize[2] + bobbin2RotorClearance + walls/2;
	bobbinMountSize=[2, 1.25*bobbinSize[0], rotorSize[2]];

	color([0, 1, 0])
	difference()
	{
		union()
		{
			// base
			translate([0, 0, A/2])
			cylinder(d=B, 
				h=A, 
				center=true);

			// bobbin mounts
			for(t=[0:numBobbins-1])
			assign(theta=360*t/numBobbins)
			rotate(theta, [0, 0, 1])
			translate([C, 0, A+rotorSize[2]/2-merge])
			difference()
			{
				union()
				{
					// the mount
					cube(bobbinMountSize, 
						center=true);

					// the braces for support
					for(side=[-1:2:1])
					assign(dy=side*bobbinMountSize[1]/2)
					translate([0, dy, 0])
					cube(size=[7*walls, walls, bobbinMountSize[2]], 
						center=true);
				}

				// the mounting hole
				rotate(-90, [0, 1, 0])
				cylinder(d1=boltDiameter440, 
					d2=2*boltDdiameter440, 
					h=bobbinMountSize[0]+merge, 
					center=true);
			}
		}

		// hole for bearing
		translate([0, 0, motorBaseSize[2]-bearingSize608ZZ[2]/2])
		cylinder(d=bearingSize608ZZ[1], 
			h=bearingSize608ZZ[2]+merge, 
			center=true);
	}
}


module base()
{
	translate([0, 0, baseSize[2]/2])
	minkowski()
	{
		cylinder(d=baseSize[0]-keepOut, 
			h=baseSize[2]-keepOut, 
			center=true);
		sphere(d=keepOut);
	}
}


module baseAssembly()
{
	boxSize = baseSize + [-2*keepOut, -2*keepOut, motorBaseSize[2]];

	color([0, 1, 0])
	union()
	{
		// the rounded base
		base();

		// the motor base
		translate(motorOffset)
		//rotate(45, [0, 0, 1])
		motorBase();

		// attachment and support for ring gear
		translate(motorOffset)
		translate([0, 0, (motorBaseSize[2]+rotorSize[2])/2])
		ringGearMount();
	}
}









