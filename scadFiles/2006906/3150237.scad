/* [Main Options] */
// Which part to render; in OpenSCAD, use "everything" to render all models at once
 part = "band"; // [clasp:Clasp,band:Elastic Band]

// Length of the elastic band
length = 115; // [80:120]


/* [Other Options] */

// Resolution of the round parts
resolution = 50; // [6:100]

// Elastic band's thickness in mm
height = 1.5;

// Elastic band's width in mm. This should probably be between 2.5mm and 4mm
width = 3;

// Diameter of the nubs/holes in the band in mm
nub_diameter = 5;

// Distance between the middle nubs/holes in mm
nub_offset = 6;

// Height of the nubs on the clasp; adjust to fit the thickness of the band
nub_height = 5.5;

// Thickness of the plastic piece on the clasp that connects the two nubs
nub_connection_height = 1.5;

module clasp() {
	// nubs
	translate([-nub_offset,0,nub_height/2]) cylinder(d=nub_diameter,h=nub_height,center=true, $fn=resolution);
	translate([nub_offset,0,nub_height/2]) cylinder(d=nub_diameter,h=nub_height,center=true, $fn=resolution);
	
	// nub ridges
	nub_top_diameter = nub_diameter+1;
	// left
	hull() {
		translate([-nub_offset-1,0.5,nub_height-(nub_connection_height/2)]) cylinder(d=nub_top_diameter,h=nub_connection_height,center=true, $fn=resolution);
		translate([-nub_offset+2,0.5,nub_height-(nub_connection_height/2)]) cylinder(d=nub_top_diameter,h=nub_connection_height,center=true, $fn=resolution);
	}
	// right
	hull() {
		translate([nub_offset-2,0.5,nub_height-(nub_connection_height/2)]) cylinder(d=nub_top_diameter,h=nub_connection_height,center=true, $fn=resolution);
		translate([nub_offset+1,0.5,nub_height-(nub_connection_height/2)]) cylinder(d=nub_top_diameter,h=nub_connection_height,center=true, $fn=resolution);
	}
	
	// nub connection
	hull() {
		translate([-nub_offset-2,0,nub_connection_height/2]) cylinder(d=nub_diameter,h=nub_connection_height,center=true, $fn=resolution);
		translate([nub_offset+2,0,nub_connection_height/2]) cylinder(d=nub_diameter,h=nub_connection_height,center=true, $fn=resolution);
	}
}
module hole() {
	cylinder(d=nub_diameter,h=height+4,center=true, $fn=resolution);
}
module elastic_band() {
	l = length - 4;
	
	difference() {
		union() {
			// band
			hull() {
				translate([l/2,0,height/2]) cylinder(d=width,h=height,center=true, $fn=resolution);
				translate([-l/2,0,height/2]) cylinder(d=width,h=height,center=true, $fn=resolution);
			}
			
			// center support
			hull() {
				translate([-nub_offset,0,height/2]) cylinder(d=nub_diameter+5,h=height,center=true, $fn=resolution);
				translate([nub_offset,0,height/2]) cylinder(d=nub_diameter+5,h=height,center=true, $fn=resolution);
			}
			
			// side support
			translate([-l/2,0,height/2]) cylinder(d=nub_diameter+4,h=height,center=true, $fn=resolution);
			// side support
			translate([l/2,0,height/2]) cylinder(d=nub_diameter+4,h=height,center=true, $fn=resolution);
		}
		
		// holes
		translate([l/2,0,height/2]) hole();
		translate([-l/2,0,height/2]) hole();
		translate([nub_offset,0,height/2]) hole();
		translate([-nub_offset,0,height/2]) hole();
	}
}


if(part == "everything" || part == "clasp") translate([0,20,nub_diameter/2]) rotate([90,0,0]) clasp();
if(part == "everything" || part == "band") elastic_band();