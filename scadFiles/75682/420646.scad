//What is length of a full 360 degree rotation? (mm)
Rotation_lenght=30; // [1:80]

/* [Hidden] */
twist_multiplier = 16 / Rotation_length;

include <MCAD/polyholes.scad>

leadscrew_nut();

module leadscrew_profile()
{
	projection(cut=false){
		polyhole(5,5);
		cube([7.5, 3,1], center=true);
		rotate([0,0,-45])
			cube([6.5,3,1],center = true);
	}
}

module leadscrew_nut(){
	difference(){
		union(){
			cylinder(r=14.8/2,h=14, $fn=6);

		}

		linear_extrude(height = Rotation_length * twist multiplier, center = true, twist = -360 * twist multiplier)
			scale(1.1)
				leadscrew_profile();
	}

}
