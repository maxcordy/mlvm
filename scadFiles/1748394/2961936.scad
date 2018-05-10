render_rim = true;
render_tire = true;
render_axle = true;

rim_diameter = 43.3;
rim_width = 26;


tire_diameter = 69;
tire_width = 33.7;


axle_diameter = 6;
axle_cross_thickness = 2.13;

resolution = 120;

module axle(length) {
	intersection() {
		minkowski() {
			cylinder(h=length-2, d=axle_diameter-2, center=true, $fn=resolution);
			sphere(d=1, $fn=resolution);
		}
		union() {
			cube([axle_diameter+2,axle_cross_thickness,length+2], center=true);
			cube([axle_cross_thickness,axle_diameter+2,length+2], center=true);
		}
	}
}

module solid_rim() {
	cylinder(h=rim_width, d=rim_diameter-(2*1.7), center=true, $fn=resolution);
	
	translate([0,0,((rim_width-1.6)/2)]) cylinder(h=1.6, d=rim_diameter, center=true, $fn=resolution);
	translate([0,0,((rim_width-1.6)/2)-4]) cylinder(h=1.6, d=rim_diameter, center=true, $fn=resolution);
	translate([0,0,-((rim_width-1.6)/2)]) cylinder(h=1.6, d=rim_diameter, center=true, $fn=resolution);
	translate([0,0,-((rim_width-1.6)/2)+4]) cylinder(h=1.6, d=rim_diameter, center=true, $fn=resolution);
}

module rim_cutouts() {
	// axle cutout (to prevent first layer from changing diameters)
	//translate([0,0,-(rim_width/2)-(axle_diameter/1.5)]) sphere(d=axle_diameter*2, $fn=resolution);

	difference() {
		intersection() {
			translate([0,0,0]) cylinder(h=rim_width+10, d=rim_diameter-6, center=true, $fn=resolution);
			translate([0,0,rim_diameter*1-rim_width/3]) sphere(d=rim_diameter*2, $fn=resolution);
		}
		
		// axle support
		translate([0,0,-rim_width/4]) cylinder(h=rim_width/2, d=axle_diameter*2, center=true, $fn=resolution);
		
		// spokes
		difference() {
			union() {
				rotate([0,0,0]) cube([rim_diameter,axle_diameter/2,rim_width], center=true);
				rotate([0,0,90]) cube([rim_diameter,axle_diameter/2,rim_width], center=true);
				rotate([0,0,45]) cube([rim_diameter,axle_diameter/2,rim_width], center=true);
				rotate([0,0,-45]) cube([rim_diameter,axle_diameter/2,rim_width], center=true);
			}
			translate([0,0,rim_diameter/2]) sphere(d=rim_diameter, $fn=resolution);
		}
	}
		
	// holes
	for (i = [0:8]) {
		 rotate([0,0,22.5 + (i*45)]) translate([rim_diameter/3,0,0]) cylinder(h=rim_width*2, d=rim_diameter/6, center=true, $fn=resolution);
	}
}

module milled_rim() {
	difference() {
		solid_rim();
		rim_cutouts();
	}
}

module rim() {
	difference() {
		milled_rim();
		axle(rim_width + 10);
	}
}

module solid_tire() {
	difference() {
		sphere(d=tire_diameter, $fn=resolution);
		
		translate([0,0,tire_width]) cylinder(h=tire_width, d=tire_diameter, center=true, $fn=resolution);
		translate([0,0,-tire_width]) cylinder(h=tire_width, d=tire_diameter, center=true, $fn=resolution);
		
		// profile
		difference() {
			union() {
				for (i = [0:16]) {
					 //rotate([0,0,i*360/32]) cube([tire_diameter+10, 2, tire_width+10], center=true);
				}
				for (i = [0:32]) {
					//rotate([30,0,i*360/16]) translate([20,0,0]) cube([tire_diameter+10, 2, tire_width+10], center=true);
					rotate([30,0,i*360/32]) cube([tire_diameter+10, 2, tire_width+10], center=true);
				}
			}
			cylinder(h=tire_width+10, d=tire_diameter*0.9, center=true, $fn=resolution);
			
			//cylinder(h=1, d=tire_diameter*2, center=true, $fn=resolution);
			
			for (i = [0:64]) {
				rotate([0,0,i*360/64]) cube([tire_diameter+10, 0.5, tire_width+10], center=true);
			}
		}
		
		translate([0,0,tire_width + (tire_diameter*0.11)]) sphere(d=tire_diameter*1.03, $fn=resolution);
		translate([0,0,-(tire_width + (tire_diameter*0.11))]) sphere(d=tire_diameter*1.03, $fn=resolution);
		
		cylinder(h=tire_width*2, d=rim_diameter-(2*1.7), center=true, $fn=resolution);

		// cut off overhang from tire over rim
		translate([0,0,((rim_width+10)/2)-0.1]) cylinder(h=10, d=rim_diameter, center=true, $fn=resolution);
		translate([0,0,(-(rim_width+10)/2)+0.1]) cylinder(h=10, d=rim_diameter, center=true, $fn=resolution);

		// remove inner two nibs
		translate([0,0,0]) cylinder(h=rim_width-10, d=rim_diameter, center=true, $fn=resolution);
		
		minkowski() {
			cylinder(h=rim_width/6, d=rim_diameter-((rim_width/3.5)/2), center=true, $fn=resolution);
			sphere(d=rim_width/3.5,$fn=resolution);
		}
	}
}

module tire() {
	difference() {
		solid_tire();
		#solid_rim();
	}
}

if(render_rim) rim();
if(render_axle) translate([-((rim_diameter/2)+10),0,0]) axle(rim_width*2);
if(render_tire) translate([rim_diameter/2 + tire_diameter/2 + 19,0,0]) tire();

