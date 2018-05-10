// by Les Hall
// started 4-17-2014
// 
// Wolverine Claw
// Grandma Vigilante Edition
// 
// 

/* [Size] */
// length of blades (mm)
length = 139;

/* [Hidden] */

// knuckle spacing (mm)
spacing = 15;

$fn=64;

scale(2*length/25.4*[1, 1, 1])
union()
{
	scale(0.9)
	for(finger=[-1:1])
	rotate(-finger*21, [1, 0, 0])
	translate([(1-abs(finger)), spacing/7*finger, 1+abs(finger)/2])
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
	
		translate([0, 0, -2])
		scale([14, 8, 4])
		rotate(90, [0, 1, 0])
		sphere(r=1);
	}

	scale([1.25, 0.85, 1.15])
	rotate(-14, [0, 1, 0])
	translate([-5.75, 0, 1.25])
	difference()
	{
		scale(spacing/15*[7, 7, 2])
		rotate(90, [0, 1, 0])
		sphere(r=1);

		scale(spacing/15*[7, 6, 1.33])
		rotate(90, [0, 1, 0])
		sphere(r=1);

		for(side=[-1:2:1])
		rotate(30*side, [0, 1, 0])
		translate([side*7+1, 0, 1])
		scale(spacing/15*[5.5, 11, 5])
		rotate(90, [0, 1, 0])
		sphere(r=1);
	}
}





