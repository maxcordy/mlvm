/*********************************************/
/*                                           */
/*    HALF SPHERE FOR LIGHT GRAFFITI RIG     */
/*                    BY                     */
/*                 NUNO CRUZ                 */
/*                                           */
/*********************************************/

led_diameter = 12;
axle_diameter = 12;
sphere_radius = 60;
thickness = 2;
detail = 30; 					//increasing this number might affect openscad performance
leds_per_level = 5;


delta = 360 / leds_per_level;

module halfSphere()
{
	difference(){
		sphere(sphere_radius, $fn=detail);
		sphere(sphere_radius - thickness, $fn=detail); 
		translate([0,0,-sphere_radius])cube(size = sphere_radius*2, center = true);
	}
}

module holeInPos(r, t, s, diameter)
{
	x = r * cos(s) * sin(t);
	y = r * sin(s) * sin(t);
	z = r * cos(t);

	translate([x,y,z])
		rotate([0, t, s])
			color("red")
				cylinder(thickness*4, $fn=detail, r=diameter, center=true);
}

difference()
{
	halfSphere();
	holeInPos(sphere_radius, 0, 0, axle_diameter);

	for( i = [1:leds_per_level] )
		holeInPos(sphere_radius, 25, i*delta, led_diameter);

	for( i = [1:leds_per_level] )
		holeInPos(sphere_radius, 45, (i*delta) + delta/2, led_diameter );

	for( i = [1:leds_per_level] )
		holeInPos(sphere_radius, 55, (i*delta), led_diameter);

	for( i = [1:leds_per_level] )
		holeInPos(sphere_radius, 70, (i*delta) + delta/2, led_diameter);
}