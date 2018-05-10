thickness = 1.77;
width = 16;
attachment_width = 19.65;
length1 = 78;
length2 = 107;
hole_distance = 6.5;
hole_diameter = 4;
hinge_element_width = 4.65;
hinge_insert_width = 1.4;
hinge_element_cutout_depth_from_needle = 2.6;
needle_attachment_diameter = 1.15;
needle_attachment_band_thickness = 4;
clasp_band_thickness = 3.7;
clasp_cutout_width = 1.8;
resolution=40;

module nub(offset) {
	translate([0,offset-10,thickness]) sphere(d=hole_diameter,$fn=resolution,center=true);
}

module fastenerAdjustable(offset, height) {
    fastener_thickness = thickness+0.2;
	difference() {
		minkowski() {
			translate([0,offset,(fastener_thickness*3)/2]) cube([width, 7, fastener_thickness*height], center=true);
			sphere(r=fastener_thickness,$fn=resolution,center=true);
		}
		translate([0,offset,(fastener_thickness*3)/2]) cube([width, 30, fastener_thickness*height], center=true);
	}
}

module fastener(offset) {
	fastenerAdjustable(offset, 1);
}

module just_the_band(length, clasp, fastener) {
	hull() {
		translate([0,0,needle_attachment_band_thickness/2]) rotate([0,90,0]) cylinder(h=attachment_width,d=needle_attachment_band_thickness,$fn=resolution,center=true);
		translate([0,10,thickness/2]) rotate([0,90,0]) cylinder(h=width,d=thickness,$fn=resolution,center=true);
	}
	hull() {
		translate([0,10,thickness/2]) rotate([0,90,0]) cylinder(h=width,d=thickness,$fn=resolution,center=true);
		translate([0,length,thickness/2]) rotate([0,90,0]) cylinder(h=width,d=thickness,$fn=resolution,center=true);
		
		if(!clasp && !fastener) {
			translate([0,length,thickness/2]) cylinder(h=thickness,d=width,$fn=resolution,center=true);
		}
	}
}

module plain_band(length, clasp, fastener, decoration) {
	just_the_band(length, clasp, fastener);
	
	if(clasp) {
		hull() {
			translate([0,length,thickness/2]) rotate([0,90,0]) cylinder(h=width,d=thickness,$fn=resolution,center=true);
			translate([0,length+4,clasp_band_thickness/2]) rotate([0,90,0]) cylinder(h=width,d=clasp_band_thickness,$fn=resolution,center=true);
		}
	}
	
	if(fastener) {
		fastener(length);
		//fastener(length-20);
		nub(length);
		nub(length-10);
		nub(length-20);
		nub(length-30);
	}
	
	if(decoration) {
		for (i = [0:length-40]) {
			intersection() {
				translate([0,0,0.3]) just_the_band(length, clasp, fastener);
				translate([rands(0,width,1)[0]-(width/2),rands(0,length-40,1)[0],thickness]) {
					/*rotate([0,0,rands(1,360,1)[0]]) */cube([rands(1,10,1)[0],rands(1,10,1)[0],5],center=true);
				}
			}
		}
	}
}
module hinge_cutout() {
	cube([hinge_insert_width, hinge_element_cutout_depth_from_needle*2, needle_attachment_band_thickness*3], center=true);
}
module generic_cutouts(length, clasp, fastener) {
	// needle thread
	translate([0,0,needle_attachment_band_thickness/2]) rotate([0,90,0]) cylinder(h=attachment_width*2,d=needle_attachment_diameter,$fn=resolution,center=true);
	
	offset = (hinge_element_width+hinge_insert_width)/2;

	translate([-offset,0,0]) hinge_cutout();
	translate([offset,0,0]) hinge_cutout();
	hull() {
		translate([-(3*offset),0,0]) hinge_cutout();
		translate([-attachment_width,0,0]) hinge_cutout();
	}
	hull() {
		translate([3*offset,0,0]) hinge_cutout();
		translate([attachment_width,0,0]) hinge_cutout();
	}
	/*
	hull() {
		translate([-offset,0,0]) hinge_cutout();
		translate([-attachment_width,0,0]) hinge_cutout();
	}
	hull() {
		translate([offset,0,0]) hinge_cutout();
		translate([attachment_width,0,0]) hinge_cutout();
	}
	*/
	
	if(clasp) {
		translate([0,length+4,0]) cube([clasp_cutout_width, hinge_element_cutout_depth_from_needle*2, needle_attachment_band_thickness*3], center=true);
		
		translate([0,length+4,clasp_band_thickness/2]) rotate([0,90,0]) cylinder(h=attachment_width*2,d=needle_attachment_diameter,$fn=resolution,center=true);
	}
	if(!clasp && !fastener) {
		for (i = [8:10:length-40]) {
			offset = length - i;
			translate([0,offset,0]) cylinder(h=thickness*3,d=hole_diameter,$fn=resolution,center=true);
		}
	}
}
module band(length, clasp, fastener, decoration) {
	difference() {
		plain_band(length, clasp, fastener, decoration);
		generic_cutouts(length, clasp, fastener);
	}
}

//band(length1, true);
band(length1, false, true);
translate([width*3,0,0]) band(length2, false, false);

translate([width*6,0,0]) band(length1, false, true, true);
translate([width*9,0,0]) band(length2, false, false, true);

translate([-width*3,0,0]) rotate([90,0,0]) fastenerAdjustable(0, 2);