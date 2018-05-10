/*********************************************/
/*																					 */
/*		HALF SPHERE FOR LIGHT GRAFFITI RIG     */
/*						        BY                     */
/*                 NUNO CRUZ								 */
/*																					 */
/*********************************************/


led_diameter = 4.7;
radius = 30;
thickness = 2;
detail = 30; 					//increasing this number might affect openscad performance
leds_per_level = 5;
delta = 360 / leds_per_level;

module halfSphere()
{
	difference(){
		sphere(radius, $fn=detail);
		sphere(radius - thickness, $fn=detail); 
		translate([0,0,-radius])cube(size = radius*2, center = true);
	}
}

module holeInPos(r, t, s)
{
	x = r * cos(s) * sin(t);
	y = r * sin(s) * sin(t);
	z = r * cos(t);

	translate([x,y,z])
		rotate([0, t, s])
			color("red")
				cylinder(thickness*3, $fn=detail, r=led_diameter, center=true);
}

difference()
{
	halfSphere();
	holeInPos(radius, 0, 0);

	for(i=[1:leds_per_level])
		holeInPos(radius, 25, i*delta);

	for(i=[1:leds_per_level])
		holeInPos(radius, 45, (i*delta) + delta/2 );

	for(i=[1:leds_per_level])
		holeInPos(radius, 55, (i*delta));

	for(i=[1:leds_per_level])
		holeInPos(radius, 70, (i*delta) + delta/2);
}

