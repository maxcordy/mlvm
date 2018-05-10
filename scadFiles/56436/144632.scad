// Cylinders bracelet
// Paul Murrin - Feb 2013

// Diameter of wrist in mm (inside diameter of bracelet)
wrist_diameter = 54; 
// diameter of outer cylinder (mm)
cylinder_size = 8 ;	//[8:small, 10:medium, 12:large]
// (mm)
height = 10;			// [5:15];
// (mm)
wall_width = 0.8;
// (mm) between outside and inside cylinders. Needs to be big enough that the small cylinders can freely move within the larger one.
gap = 2.8;	
// number of struts joining big and small cylinders (use 1 for height less than 10mm)								
num_struts = 2;				
// include_opening_segment
include_opening_segment=1; // [1:yes, 0:no]				

tol = 0.05 + 0;
pi = 3.1415926 + 0;
radPerDeg = 360 / (2*pi);

// Dimensions of the ring formed by the segments
ring_rad =  (wrist_diameter + cylinder_size) / 2;
ring_circumf = 2*ring_rad*pi;

inside_cyl_dia = cylinder_size-wall_width-gap;
desired_cylinder_spacing = cylinder_size*1.15;	// center-to-center spacing of the cylinders

num_cylinders = floor(ring_circumf/desired_cylinder_spacing);
cylinder_spacing = ring_circumf / num_cylinders;
angle = 2*pi*radPerDeg / num_cylinders;

// Work out the angle to offset the first segment so the cylinders line up
d = ring_rad*(1/cos(angle/2) - cos(angle/2));
offset_angle = atan(d / (cylinder_spacing/2));

// Struts joining segments
strut_oversize = 1 + 0;							// additional length to ensure strut meets cylinder properly
strut_length = cylinder_spacing - cylinder_size/2 - inside_cyl_dia/2 + strut_oversize;
strut_height = (height - 4) / (num_struts+1);
strut_width = 1.2 + 0;
strut_gap_v = 1.4 + 0;							// vertical gap around where the strut goes through the outer
strut_gap_h = 1.4 + 0;							// horizontal gap around where the strut goes through the outer
strut_spacing = height / (num_struts+1);			// Spacing between struts
gap_angle = angle;

$fa = 6+0;
$fs = 0.2+0;


module segment()
{
	union()
	{	
		// Outer cylinder
   		difference() 
		{
			cylinder(h=height, r=cylinder_size/2, center=false);
			cylinder(h=height+tol, r=cylinder_size/2-wall_width, center=false);
			rotate([0,0,-gap_angle])
				for(n=[1:num_struts])
					translate([cylinder_size/2, 0, n*strut_spacing])
						cube(size=[cylinder_size, strut_width+strut_gap_h, strut_height+strut_gap_v], center=true);
		}
		// Inner cylinder
		translate([-cylinder_spacing, 0, 0]) difference() 
		{
			cylinder(h=height, r=inside_cyl_dia/2, center=false);
			cylinder(h=height+tol, r=inside_cyl_dia/2-wall_width, center=false);
		}
		// struts
		for(n=[1:num_struts])
		{
			translate([-strut_length/2-cylinder_size/2+strut_oversize/2, 0, n*strut_spacing])
				cube(size = [strut_length, strut_width, strut_height], center=true);
		}
	}
}


module openingSegment()
{
	gapSpanAngle = 360 * ( (strut_width) / (pi*cylinder_size));
	difference()
	{
		segment();
		rotate([0,0,-(gap_angle+gapSpanAngle)])
		{
			for(n=[1:num_struts])
				translate([cylinder_size/2, 0, n*strut_spacing])
					cube(size=[cylinder_size, strut_width, strut_height+strut_gap_v], center=true);
			translate([cylinder_size/2, 0, (num_struts)*strut_spacing/2-tol])
				cube([cylinder_size, strut_width+0.5, (num_struts)*strut_spacing], center=true);
		}
	}
}



for (n=[1:(num_cylinders-1)])
	rotate([0, 0, (n-1)*angle])
		translate([0, ring_rad, 0])
			rotate([0,0,offset_angle])
				segment();
rotate([0, 0, (num_cylinders-1)*angle])
	translate([0, ring_rad, 0])
		rotate([0,0,offset_angle])
			if(include_opening_segment==1)
				openingSegment();
			else
				segment();

