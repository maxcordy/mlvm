
// height in mm
height = 12;

// inner diameter in mm
inner_diameter = 6;

// outer diameter in mm
outer_diameter = 20;

/* [Hidden] */

inner_radius = inner_diameter/2;
outer_radius = outer_diameter/2;

$fn = 50;

difference() 
{
	cylinder(h=height, r=outer_radius, center=true);
	cylinder(h=height+1, r=inner_radius, center=true);
}



