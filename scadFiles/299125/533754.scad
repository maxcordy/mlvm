// For Tikal, a value of 20 is good.
volcano_base_radius=20; 

// How wide should each strip be in percent of the base radius?
volcano_strip_width_percent=.1;

// Degree to turn from strip to strip.
volcano_strips_angle=4; 

// The crater size in relation to the base radius
volcano_inner_percentage=.35; 

// Set the randomness of the strip size.
random_resize_percentage=.6;

volcano_strip_width=volcano_base_radius*volcano_strip_width_percent; 

/*
Volcano piece for the game Tikal
Version 1, April 2014
Written by MC Geisler (mcgenki at gmail dot com)

Have fun!

License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
Under the following terms:
    Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. 
    You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial - You may not use the material for commercial purposes.
    ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. 
*/

hexmapradius=82/2;

module octogon(type)
{
	if (type=="map")
	{
		cylinder(r=hexmapradius,h=1,$fn=6);
	}
	if (type=="small")
	{
		cylinder(r=11/2,h=10,$fn=6);
	}
	if (type=="large")
	{
		cylinder(r=12/2,h=15,$fn=6);
	}
}

module worker()
{
	//small worker
	%translate([hexmapradius*.75,0,0])
		octogon("small");
		
	//large workder
	%translate([-hexmapradius*.75,0,0])
		octogon("large");
	
}

//ground map
%translate([0,0,-1]) octogon("map");
worker();

//----------------------------------

outercutoff=6;

$fn=50;

union()
{
	for (i = [0:360/volcano_strips_angle]) 
	{
		assign (volcanoradius=volcano_base_radius*(1-random_resize_percentage/2+rands(0,10,1)[0]/10*random_resize_percentage) )
			assign (volcano_inner_percentageradius=volcanoradius*volcano_inner_percentage/(volcanoradius/volcano_base_radius))   
			{
				rotate([0,0,i*volcano_strips_angle])
					translate([0,-volcanoradius/2,volcanoradius/2])
						difference()
						{
							translate([0,-(volcano_inner_percentageradius-outercutoff)/2,0])
								cube([volcano_strip_width,volcanoradius+(volcano_inner_percentageradius-outercutoff),volcanoradius],center=true);
							
							//outer round
							translate([0,-volcanoradius/2-volcano_inner_percentageradius,volcanoradius/2])
								rotate([0,90,0])
									cylinder(r=volcanoradius,h=volcanoradius*1.1,center=true);
							
							translate([0,volcanoradius/2+1,volcanoradius/2])
								rotate([0,90,0])
									cylinder(r=volcano_inner_percentageradius,h=volcanoradius*1.1,center=true);
						}
			}
	}
}