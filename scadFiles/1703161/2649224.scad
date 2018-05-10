head_diameter = 14.5;
head_edges = 5;
head_thickness = 1.6;
shaft_diameter = 5;
shaft_height = 7.6;
shaft_enclose_wall_thickness = 1;
shaft_enclosure_height = 4;
resolution = 60;
mail_female_ratio = 1.14;
screw_thread = false;
push_thread = true;

module head() {
	cylinder(h=head_thickness, d=head_diameter, center=false, $fn=head_edges);
}

module ridge() {
	/*
	minkowski() {
		cylinder(h=0.1, d=shaft_diameter-1, center=false, $fn=resolution);
		sphere(d=0.7, $fn = resolution);
	}
	*/
	linear_extrude(height = 2, center = true, convexity = 10, scale=[0.5,0.5], $fn=resolution)
		 circle(d = shaft_diameter);
} 

module shaft() {
	// ridging
	if(screw_thread) {
		cylinder(h=head_thickness+shaft_height, d=shaft_diameter-1, center=false, $fn=resolution);
		translate([0,0,(shaft_height/2)+head_thickness])
			linear_extrude(height = shaft_height, center = true, convexity = 10, slices = 100, $fn=resolution, twist = (shaft_height/1.2)*360)
			translate([0.2, 0, 0])
			circle(d=(shaft_diameter-0.5));
	}
	if(push_thread) {
		for(ridge_offset = [head_thickness : 0.92 : head_thickness+shaft_height]) {
			translate([0,0,ridge_offset]) ridge();
		}
	}
}

module male() {
	head();
	shaft();
}

module female() {
	difference() {
		union() {
			head();
			scale([1.1,1.1,1]) cylinder(h=head_thickness+shaft_enclosure_height, d=shaft_diameter+(shaft_enclose_wall_thickness*2), center=false, $fn=resolution);
		}
		 
		rotate([180,0,0]) translate([0,0,-head_thickness-shaft_height]) scale([mail_female_ratio,mail_female_ratio,1]) shaft();
		translate([0,0,-1.45]) cylinder(h=3, d1=shaft_diameter*2, d2 = shaft_diameter/2, center=false, $fn=resolution);
	}
}

male();
translate([head_diameter+5,0,0]) female();