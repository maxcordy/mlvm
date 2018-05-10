// Graber i3 xy belt holder v2.00 by ValterFC
// January / 2014

// ******************************************************
// Select your belt type *NOT TESTED*
// ******************************************************
//T2.5
//belt_tooth_distance = 2.5;
//belt_tooth_ratio = 0.8;

//T5 (strongly discouraged)
//belt_tooth_distance = 5;
//belt_tooth_ratio = 1.05;

//HTD3
//belt_tooth_distance = 3;
//belt_tooth_ratio = 1.05;

//MXL
//belt_tooth_distance = 2.032;
//belt_tooth_ratio = 0.94;

//GT2
belt_tooth_distance = 2; // [2.5:T2.5, 5:T5, 3:HTD3, 2.032:MXL, 2:GT2]
belt_tooth_ratio = 0.8; // [0.8:T2.5, 1.05:T5, 1.05:HTD3, 0.94:MXL, 0.8:GT2]

//support generation
generate_support = 1; // [0:no, 1:yes]

//side nut orientation
side_nut_orientation = 0; // [0:normal, 1:another way]

//call main function
main();


module main()
{
	//make_object 0:fixed object, 1:tensiometer object
	
	//Y holder
	translate([-14,-25,width+1]) y_holder(0);
	translate([+14,-25,width+1]) y_holder(1);

	//X holder
	translate([-14,5,width+1]) x_holder(0);
	translate([+14,5,width+1]) x_holder(1);
}



/*Non customizer variables*/
length = 17+0;
width = 10+0;
thickness = 21+0;
extra = 0.2+0;
belt_width = 6+0.6;
belt_thickness = 1.2+0; // Excluding teeth height (0.9)
belt_pitch = belt_tooth_distance+0;
teeth_height = 1.1+0;
teeth_width = belt_tooth_ratio+0;
screw_hole_diameter = 3+0;
nut_diameter = 5+0.8;
nut_thickness = 2.5+0;

//for x holder
length_plus = 0+4;
length_xholder = length+length_plus; 
bolt_head_diam = 0+nut_diameter; //adjuste bolt head diameter
//trim block variables
trim_width = nut_thickness+0.5;
trim_pos = (length/2)-(trim_width/2);


//####################################################
// X
//####################################################
module sidenutX_support(make_object) {
	sup_size = 0.44;

	//support of side nut X
	if ((make_object == 1) && (generate_support == 1)) {
		translate([2,-9.5,2])
			cube([8,sup_size,7]);

		translate([2,-7.8,2])
			cube([8,sup_size,7]);

		translate([2,-6,2])
			cube([8,sup_size,7]);
	}
}

module sidenutX(make_object) {
	if (make_object == 0)
	{
		translate([0,0,trim_pos])
			cylinder( h=nut_thickness+trim_width,r=nut_diameter/2+extra*2,$fn=6 );
	} else {
		translate([0,0,trim_pos])
			cylinder( h=length_xholder-trim_pos, r=bolt_head_diam/2, $fn=30);
	} 

	//the screw cylinder
	translate([0,0,-(length_plus/2)])
		cylinder( h=thickness+1, r=screw_hole_diameter/2, $fn=30);

	//trim block
	translate([-6,-4,trim_pos])
		cube([7,nut_diameter+1,trim_width]);
}

module x_holder(make_object) {
	union() {

	difference()
	{
		roundedRect([length+length_plus,thickness,width], 2);

		//+++++++++++++++++++++++++++++++++++++++
		// belt top
		translate([(-length-length_plus)/2,((thickness+belt_thickness+teeth_height)/4)-teeth_height,width-belt_width-4])
			cube([length+length_plus,belt_thickness+6,belt_width+4]);

		// tooth top
		for( x = [0:belt_pitch:length+1] )
		{
			translate([x-length/2,((thickness+belt_thickness+teeth_height)/4),width-belt_width-4])
			rotate(a=180,v=[0,0,1])
				cube(size=[belt_pitch-teeth_width,teeth_height+belt_thickness,belt_width+4], center=false);
		}
		//+++++++++++++++++++++++++++++++++++++++


		//+++++++++++++++++++++++++++++++++++++++
		// belt button
		translate([(-length-length_plus)/2,((thickness+belt_thickness+teeth_height)/4)-(teeth_height+8.7),width-belt_width])
			cube([length+length_plus,belt_thickness,belt_width+1]);

		// tooth button
		for( x = [0:belt_pitch:length+1] )
		{
			translate([x-length/2,((thickness+belt_thickness+teeth_height)/4)-7.2,width-belt_width])
			rotate(a=180,v=[0,0,1])
				cube(size=[belt_pitch-teeth_width,teeth_height+belt_thickness,belt_width+1], center=false);
		}
		//+++++++++++++++++++++++++++++++++++++++



		// top bolt hole
		if (make_object == 1)
		{
			translate([-1.0,1,width+1]) rotate([180,0,0])
				cylinder( h=width+2,r=screw_hole_diameter/2,$fn=30);

			translate([2,1,0]) rotate([180,0,0])
				cube(size=[width-4,screw_hole_diameter,30], center=true);

			translate([+5.0,1,width+1]) rotate([180,0,0])
				cylinder( h=width+2,r=screw_hole_diameter/2,$fn=30);


			//plus hole (positive ou negative position)
			translate([+3+(length_plus/2),1,width+1]) rotate([180,0,0])
				cylinder( h=width+2, r=screw_hole_diameter/2, $fn=30);
		} else {
			//plus hole (positive ou negative position)
			translate([-3-(length_plus/2),1,width+1]) rotate([180,0,0])
				cylinder( h=width+2, r=screw_hole_diameter/2, $fn=30);
		}



		// side nut
		if (side_nut_orientation == 0)
		{
			translate([-length/2,-nut_diameter*1.3,width/2]) rotate([0,-270,0]) //original way
				sidenutX(make_object);
		} else {
			translate([-length/2,-nut_diameter*1.42,width/2]) rotate([0,-270,0]) rotate([0,0,90]) //another way
				sidenutX(make_object);
		}
	}

	sidenutX_support(make_object);
	}
}


//####################################################
// Y
//####################################################
module sidenutY(make_object) {
	//nut fitting
	if (make_object == 0) cylinder( h=nut_thickness+0.8,r=nut_diameter/2+extra*2,$fn=6 );
	//the screw cylinder
	cylinder( h=thickness+1, r=screw_hole_diameter/2, $fn=30);
}

module y_holder(make_object) {
	length = 17+0;
	width = 10+0;
	thickness = 21+0;
	extra = 0.2+0;
	belt_width = 6+0.6;
	belt_thickness = 1.2+0; // Excluding teeth height (0.9)
	belt_pitch = belt_tooth_distance+0;
	teeth_height = 1.1+0;
	teeth_width = belt_tooth_ratio+0;
	screw_hole_diameter = 3+0;
	nut_diameter = 5+0.8;
	nut_thickness = 2.5+0;

	difference()
	{
		roundedRect([length,thickness,width], 2);

		//+++++++++++++++++++++++++++++++++++++++
		// belt top
		translate([-length/2,((thickness+belt_thickness+teeth_height)/4)-teeth_height,width-belt_width])
			cube([length,belt_thickness,belt_width+1]);

		// tooth top
		for( x = [0:belt_pitch:length+1] )
		{
			translate([x-length/2,((thickness+belt_thickness+teeth_height)/4),width-belt_width])
			rotate(a=180,v=[0,0,1])
				cube(size=[belt_pitch-teeth_width,teeth_height+belt_thickness,belt_width+1], center=false);
		}
		//+++++++++++++++++++++++++++++++++++++++


		//+++++++++++++++++++++++++++++++++++++++
		// belt button
		translate([-length/2,((thickness+belt_thickness+teeth_height)/4)-(teeth_height+8.7),width-belt_width])
			cube([length,belt_thickness,belt_width+1]);

		// tooth button
		for( x = [0:belt_pitch:length+1] )
		{
			translate([x-length/2,((thickness+belt_thickness+teeth_height)/4)-7.2,width-belt_width])
			rotate(a=180,v=[0,0,1])
				cube(size=[belt_pitch-teeth_width,teeth_height+belt_thickness,belt_width+1], center=false);
		}
		//+++++++++++++++++++++++++++++++++++++++

		// top bolt hole
		if (make_object == 1)
		{
			translate([-3.0,1,width+1]) rotate([180,0,0])
				cylinder( h=width+2,r=screw_hole_diameter/2,$fn=30);

			translate([0,1,0]) rotate([180,0,0])
			cube(size=[width-4,screw_hole_diameter,30], center=true);

			translate([+3.0,1,width+1]) rotate([180,0,0])
				cylinder( h=width+2,r=screw_hole_diameter/2,$fn=30);
		}

		translate([0,1,width+1]) rotate([180,0,0])
			cylinder( h=width+2, r=screw_hole_diameter/2, $fn=30);

		// side nut
		if (side_nut_orientation == 0)
		{
			translate([-length/2,-nut_diameter*1.3,width/2]) rotate([0,-270,0]) //original way
				sidenutY(make_object);
		} else {
			translate([-length/2,-nut_diameter*1.42,width/2]) rotate([0,-270,0]) rotate([0,0,90]) //another way
				sidenutY(make_object);
		}
	}
}






// from thingiverse.com/thing:9347
module roundedRect(size, radius)
{
	x = size[0]-radius;
	y = size[1];
	z = size[2];
	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
  		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
			circle(r=radius);

		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
			circle(r=radius);

		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
			circle(r=radius);

		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
			circle(r=radius);
	}
}

