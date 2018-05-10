/* [Motor Mount Geometry] */

//Move the motor to front by x millimeters, default -5.2
motorversatz_x = -5.2;//[-17.0:0.2:0] 

//Length of motor mount in LEGO blocks (a 8mm), default 4
blocks_x = 4; //[2,3,4,5,6] 

// Motor Screw holes in mm (default 3mm)
screw = 3; //[1:0.1:5]

/* [Printing] */

// Format for printing
printing="Yes"; // [Yes,No: View only]

// Enlarge LEGO holes for printing imprecision by (default 4mm)
hl_enlarge=0.4; //[0.0:0.1:1.0]

/* [hidden] */
$fn=25;
print = (printing=="Yes");

//color("Yellow",0.02)
module stepper_housing() {
difference()
{
	union() {
		// legostein
		block(6,blocks_x,4.33,axle_hole=false /*true*/ ,reinforcement=true );
		// Lego is 8mm per BLU wide and 9.6mm high
		// Solider Teil
		translate([0.1,0.1,3]) cube([blocks_x*8-1,46,37]);
		
	}
	// Aussparungen
	union() {
		// Platz für Motor
		union() {
			translate([motorversatz_x,24,18+2.2]) rotate([90,180,90]) {
				//Platz für LEGO-Achsadapter
				translate([0,8,19-0.01]) cylinder(r=12/2, h=40, $fn=40);
			}

			// Platzerweiterung für Druck
			translate([motorversatz_x-20,24,18+2.2]) rotate([0,90,0]) cylinder(r=32/2, h=19+20); // more air space for cooling
			// head room for cables
			translate([motorversatz_x-20,13,25+2.6])  
				intersection() {
					cube([19+20,22,12]);
					translate([0,22/2,-18])
						rotate([0,90,0])	
						cylinder(d=60, h=20+20, $fn=50);
				}

			// Schraublöcher für ca. 3,8mm Schauben
			translate([19+motorversatz_x-0.01,6.5,18+2.2]) rotate([0,90,0]) cylinder(d=screw, h=40);
			translate([19+motorversatz_x-0.01,6.5+35,18+2.2]) rotate([0,90,0]) cylinder(d=screw, h=40);

			// Schraubenkopfgang
			hull() {
				translate([motorversatz_x-20,6.5,18+2.2]) rotate([0,90,0]) cylinder(r=4.4, h=19+20);
				translate([motorversatz_x-20,6.5+35,18+2.2]) rotate([0,90,0]) cylinder(r=4.4, h=19+20);
			}
		}
		//Lego-Achslöcher
		// Horizontale Löcher parallel zur Achse
		for (j = [-1:3])
		for (i = [-2:2])
			if((j==1)&&(i==2)) {
				// kein Loch
			}
			else if ((j==1)&&(i==-2)) {
				// kein Loch
			}
			else
			translate([blocks_x*8-8-0.5,24+8*i,18+2.2-8+j*8]) 
				rotate([270,0,90]) 
				translate([0,0,-8])
				axle(1/1.2);
		
		// Seitenlöcher
		for (j = [-1:3])
		for (i = [-0:(blocks_x-2)])
			if((j!=1))
			translate([8+i*8, 8, 18+2.2-8+j*8]) 
				rotate([270,0,0]) 
				translate([0,0,-8])
				Lego_axle(1);			
		// Seitenlöcher
		for (j = [-1:3])
		for (i = [-0:(blocks_x-2)])
			if((j!=1))
			translate([8+i*8, 5*8-0.2, 18+2.2-8+j*8]) 
				rotate([90,0,0]) 
				translate([0,0,-8])
				Lego_axle(1);	
	}
}

translate([motorversatz_x,24,18+2.2]) 
	rotate([90,180,90]) 
		union() {
			if(!print) stepper28BYJ();
			translate ([0,8,22.9]) color("Red") adaptor();
	}


}

if (print) {rotate([0,90,0]) stepper_housing();}
else stepper_housing();



// 28BYJ-48 Stepper Motor Model

// Mark Benson

// 23/07/2013

// Creative Commons Non Commerical

module stepper28BYJ()
{

difference()
{
	
	union()
	{
		//Body
		color("SILVER") cylinder(r=28/2, h=19, $fn=60);

		//Base of motor shaft
		color("SILVER") translate([0,8,19]) cylinder(r=9/2, h=1.5, $fn=40);

		//Motor shaft
		color("SILVER") translate([0,8,20.5]) 
		intersection()
		{
		cylinder(r=5/2, h=9, $fn=40);
		cube([3,6,9],center=true);
		}

		//Left mounting lug
		color("SILVER") translate([-35/2,0,18.5]) mountingLug();
		
		//Right mounting lug
		color("SILVER") translate([35/2,0,18.5]) rotate([0,0,180]) mountingLug();
	
		difference()
		{
			//Cable entry housing
			color("BLUE") translate([-14.6/2,-17,1.9]) cube([14.6,17,17]);

			cylinder(r=27/2, h=29, $fn=60);
		}

	}

	union()
	{
		//Flat on motor shaft
		//translate([-5,0,22]) cube([10,7,25]);
	}
}

}//end of stepper28BYJ module wrapper

module mountingLug()
{
	difference()
	{
		hull()
		{
			cylinder(r=7/2, h=0.5, $fn=40);
			translate([0,-7/2,0]) cube([7,7,0.5]);
		}

		translate([0,0,-1]) cylinder(r=4.2/2, h=2, $fn=40);
	}
}

//Call stepper module - comment this out if you include this file in another model

// edited 2/24/11 3:29 PM

knob_diameter=4.8;		//knobs on top of blocks
knob_height=2;
knob_spacing=8.0;
wall_thickness=1.45;
roof_thickness=1.05;
block_height=9.5;
pin_diameter=3;		//pin for bottom blocks with width or length of 1
post_diameter=6.5;
reinforcing_width=1.5;
axle_spline_width=2.1;
axle_diameter=5;
cylinder_precision=0.1;

//block(5,2,2,axle_hole=true,reinforcement=true);

module block(width,length,height,axle_hole,reinforcement) {
	overall_length=(length-1)*knob_spacing+knob_diameter+wall_thickness*2;
	overall_width=(width-1)*knob_spacing+knob_diameter+wall_thickness*2;
	union() {
		difference() {
			union() {
				cube([overall_length,overall_width,height*block_height]);
				translate([knob_diameter/2+wall_thickness,knob_diameter/2+wall_thickness,0]) 
					for (ycount=[0:width-1])
						for (xcount=[0:length-1]) {
							translate([xcount*knob_spacing,ycount*knob_spacing,0])
								cylinder(r=knob_diameter/2,h=block_height*height+knob_height,$fs=cylinder_precision);
					}
			}
			translate([wall_thickness,wall_thickness,-roof_thickness]) cube([overall_length-wall_thickness*2,overall_width-wall_thickness*2,block_height*height]);
			if (axle_hole==true)
				if (width>1 && length>1) for (ycount=[1:width-1])
					for (xcount=[1:length-1])
						translate([xcount*knob_spacing,ycount*knob_spacing,-block_height/2])  axle(height+1);
		}

		if (reinforcement==true && width>1 && length>1)
			difference() {
				for (ycount=[1:width-1])
					for (xcount=[1:length-1])
						translate([xcount*knob_spacing,ycount*knob_spacing,0]) reinforcement(height);
				for (ycount=[1:width-1])
					for (xcount=[1:length-1])
						translate([xcount*knob_spacing,ycount*knob_spacing,-0.5]) cylinder(r=post_diameter/2-0.1, h=height*block_height+0.5, $fs=cylinder_precision);
			}

		if (width>1 && length>1) for (ycount=[1:width-1])
			for (xcount=[1:length-1])
				translate([xcount*knob_spacing,ycount*knob_spacing,0]) post(height,axle_hole);

		if (width==1 && length!=1)
			for (xcount=[1:length-1])
				translate([xcount*knob_spacing,overall_width/2,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);

		if (length==1 && width!=1)
			for (ycount=[1:width-1])
				translate([overall_length/2,ycount*knob_spacing,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);
	}
}

module post(height,axle_hole=false) {
	difference() {
		cylinder(r=post_diameter/2, h=height*block_height,$fs=cylinder_precision);
		if (axle_hole==true) {
			translate([0,0,-block_height/2])
				axle(height+1);
		} else {
			translate([0,0,-0.5])
				cylinder(r=knob_diameter/2, h=height*block_height+1,$fs=cylinder_precision);
		}
	}
}

module reinforcement(height) {
	union() {
		translate([0,0,height*block_height/2]) union() {
			cube([reinforcing_width,knob_spacing+knob_diameter+wall_thickness/2,height*block_height],center=true);
			rotate(v=[0,0,1],a=90) cube([reinforcing_width,knob_spacing+knob_diameter+wall_thickness/2,height*block_height], center=true);
		}
	}
}

module axle(height) {
	translate([0,0,height*block_height/2]) union() {
		cube([axle_diameter,axle_spline_width,height*block_height],center=true);
		cube([axle_spline_width,axle_diameter,height*block_height],center=true);
			}
	cylinder(d1=axle_diameter+1, d2=0, h=2);
	translate([0,0,-1.99]) cylinder(d=axle_diameter+1, h=2);
}
	


// 28byj-48 Axle hub to LEGO Axle adaptor

// Lego(c) dimensions with additional space for printing imprecision
L_axle = 4.85 + hl_enlarge;
L_axle_crosshair = 1.8 + hl_enlarge;
L_axle_length = 8; //horizontal style units = 8mm each

// 28BYJ-48 axle hub
S_axle = 5.0 + hl_enlarge;
S_axle_flatside = 3.0 + hl_enlarge;
S_axle_length = 6;

$fn=25;

module Lego_axle(height) {
	translate([0,0,height*L_axle_length/2]) union() {
		cube([L_axle,L_axle_crosshair,height*L_axle_length],center=true);
		cube([L_axle_crosshair,L_axle,height*L_axle_length],center=true);
			}
	cylinder(d1=L_axle+1, d2=0, h=2);
	translate([0,0,-1.99]) cylinder(d=L_axle+1, h=2);
}

module 28BYJ_axle() {
	intersection() {
		cylinder(d= S_axle, h=S_axle_length);
		cube([S_axle+1, S_axle_flatside, S_axle_length*2.1], center=true);
	}

}



module adaptor() {
difference() {
	// body
	cylinder(d= 10, h = L_axle_length+S_axle_length);
	// minus holes
	translate([0,0,-0.01]) union() {
		28BYJ_axle();
		translate([0,0,L_axle_length+S_axle_length-0.01])
		rotate([180,0,0]) 
		 Lego_axle(1);
	}
}
}

