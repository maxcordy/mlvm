//Edited 2/14/2013
//Based off of jag's design
//Adapted by Adam Zeloof (azzeloof)


Block_Width = 4;

Block_Length = 2; 

Block_Height = 1;

// knob_diameter=4.8;		//knobs on top of blocks
// knob_height=2;
// knob_spacing=8.0;
// wall_thickness=1.45;
// roof_thickness=1.05;
// block_height=9.5;
// pin_diameter=3;		//pin for bottom blocks with width or length of 1
// post_diameter=6.5;
// reinforcing_width=1.5;
// axle_spline_width=2.0;
// axle_diameter=9.5;


block(Block_Length,Block_Width,Block_Height,axle_hole=false,reinforcement=true);

module block(width,length,height,axle_hole,reinforcement) {
	overall_length=(length-1)*8+4.8+1.45*2;
	overall_width=(width-1)*8+4.8+1.45*2;
	union() {
		difference() {
			union() {
				cube([overall_length,overall_width,height*9.5]);
				translate([4.8/2+1.45,4.8/2+1.45,0]) 
					for (ycount=[0:width-1])
						for (xcount=[0:length-1]) {
							translate([xcount*8,ycount*8,0])
								cylinder(r=4.8/2,h=9.5*height+2,$fs=.1);
					}
			}
			translate([1.45,1.45,-1.05]) cube([overall_length-1.45*2,overall_width-1.45*2,9.5*height]);
			if (axle_hole==true)
				if (width>1 && length>1) for (ycount=[1:width-1])
					for (xcount=[1:length-1])
						translate([xcount*8,ycount*8,-9.5/2])  axle(height+1);
		}

		if (reinforcement==true && width>1 && length>1)
			difference() {
				for (ycount=[1:width-1])
					for (xcount=[1:length-1])
						translate([xcount*8,ycount*8,0]) reinforcement(height);
				for (ycount=[1:width-1])
					for (xcount=[1:length-1])
						translate([xcount*8,ycount*8,-0.5]) cylinder(r=6.5/2-0.1, h=height*9.5+0.5, $fs=.1);
			}

		if (width>1 && length>1) for (ycount=[1:width-1])
			for (xcount=[1:length-1])
				translate([xcount*8,ycount*8,0]) post(height,axle_hole);

		if (width==1 && length!=1)
			for (xcount=[1:length-1])
				translate([xcount*8,overall_width/2,0]) cylinder(r=3/2,h=9.5*height,$fs=.1);

		if (length==1 && width!=1)
			for (ycount=[1:width-1])
				translate([overall_length/2,ycount*8,0]) cylinder(r=3/2,h=9.5*height,$fs=.1);
	}
}

module post(height,axle_hole=false) {
	difference() {
		cylinder(r=6.5/2, h=height*9.5,$fs=.1);
		if (axle_hole==true) {
			translate([0,0,-block_height/2])
				axle(height+1);
		} else {
			translate([0,0,-0.5])
				cylinder(r=4.8/2, h=height*9.5+1,$fs=.1);
		}
	}
}

module reinforcement(height) {
	union() {
		translate([0,0,height*9.5/2]) union() {
			cube([1.5,8+4.8+1.45/2,height*9.5],center=true);
			rotate(v=[0,0,1],a=90) cube([1.5,8+4.8+1.45/2,height*9.5], center=true);
		}
	}
}

module axle(height) {
	translate([0,0,height*9.5/2]) union() {
		cube([9.5,2.0,height*9.5],center=true);
		cube([2.0,9.5,height*9.5],center=true);
	}
}
			