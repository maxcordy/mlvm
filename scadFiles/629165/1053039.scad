// 'My Headset Hook' Version 1.1 by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// (c) January 2015 
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode

// Version 1.1: new parameter for wedge, bugfixes regarding older OpenSCAD version of customizer

// preview[view:north, tilt:bottom]

/* [Base] */
mount_type="front"; // [front,top]
shelf_thickness=19;
bracket_depth=20;

/* [Advanced] */
//defines the relative offset of the hanger text
top_offset=8;
backlash=0.3;
wedge=1.0;
bracket_thickness_wedge=2.0;
bracket_wedge_depth_ratio=0.8;

/* [Hidden] */
bracket_thickness=2.5;

rotate([0,90])
bracket(width=20,shelf_thickness=shelf_thickness,bracket_depth=bracket_depth,bracket_thickness=bracket_thickness,backlash=backlash,mount_type=mount_type);

module bracket(width,shelf_thickness,bracket_depth,bracket_thickness,offset=top_offset,mount_type,backlash)
{
	translate([0,offset,0])
	if(mount_type=="front")
	{
		clamp(width,shelf_thickness,bracket_thickness,bracket_depth,backlash=backlash);
	}
	else
	{
		mirror([0,0,1])
		rotate([-90,0,0])
		clamp(width,shelf_thickness,bracket_thickness,bracket_depth,backlash=backlash);
	}

	tongue(width=width,backlash=backlash,notch_off=.2);
}


module tongue(width=20, thick=2.5,backlash=0,depthness=5,notch_off)
{
	x0=-0.001;
	x1=depthness;
	x2=x1+backlash;
	x3=x2+1.5*thick-backlash;
	
	y0=-thick/2-notch_off;
	y1=y0+notch_off+backlash;
	y2=y1+thick-backlash*2;
	y3=y2+notch_off+backlash;

	points=[
	[x0,y2],
	[x1,y2],
	[x2,y3],
	[x3,y2-backlash],
	[x3,y1+backlash],
	[x2,y0],
	[x1,y1],
	[x0,y1]
	];

	translate([width/2,0,0])
	rotate([0,-90])
	linear_extrude(height=width,convexity=10)
	polygon(points);
}

module clamp(width, shelf_thickness, bracket_thickness,bracket_depth,backlash)
{
	y1=0;
	y2=y1+bracket_thickness_wedge;
	y3=y2+shelf_thickness+backlash;
	y4=y3+bracket_thickness;

	x1=0;
	x2=x1+bracket_thickness;
	x3=x2+bracket_depth*bracket_wedge_depth_ratio;//*3/4;
	x4=x2+bracket_depth;
	x5=x4+bracket_thickness;

	h=20;

	translate([0,-shelf_thickness-bracket_thickness-backlash,bracket_thickness])
	rotate([0,90])
	translate([0,0,-width/2])
	union()
	{
		linear_extrude(height=h,convexity=10)
			polygon([
			[x1,y1],
			[x1,y4],
			[x4,y4],
			[x4,y3],
			[x2,y3],
			[x2,y2],
			[x3,y2],
			[x3,y1],
		]);

		translate([x4,(y3+y4)/2])
		cylinder(r=bracket_thickness/2,h=h,$fn=20);

		hull()
		for(p=[
			[x3-bracket_thickness-wedge,wedge+(y1+y2)/2],
			[x3-bracket_thickness-wedge,(y1+y2)/2],
			[x3,(y1+y2)/2],
		])
		translate(p)
		cylinder(r=bracket_thickness_wedge/2,h=h,$fn=20);
	}
}


