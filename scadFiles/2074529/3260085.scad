// resolution of the round elements
resolution = 12;

// resolution of the blades
blade_resolution = 40;

// resolution of the tip
tip_resolution = 40;

// thickness of the top wall
hull_thickness_top = 0.6;

// thickness of the side walls
hull_thickness_side = 0.8;

// diameter of the top surface
diameter_top = 30;

// thickness of the border around the top airvent inlents; smaller border = larger air inlet
airvents_border_top = 2;

//height between top surface and airvents
height_top = 3;

// diameter just above the air vents
diameter_middle = 40;

// height of the airvents
height_bottom_1 = 3;

// diameter just below the airvents
diameter_bottom = 30;

// height of the slanted surface on which the propellers sit (higher = steeper surface)
inner_chamfer_height = 5;

// height from bottom of airvents to tip
height_bottom_2 = 2.5;

// diameter of the tip
diameter_tip = 2;

// how curved the blades are; smaller number = more curved
blade_diameter = 31;

// thickness of the individual blades
blade_thickness = 1.5;

// total number of blades
number_of_blades = 12;

// whether to apply chamfer to the hull (slow!)
hull_rounded_corners_radius = 0.5;

// whether to apply chamfer everywhere (very slow!)
everywhere_rounded_corners_radius = 0;


module blade() {
	translate([-(blade_diameter/2),0,0]) intersection() {
		difference() {
			cylinder(d=blade_diameter,h=height_top+height_bottom_1+height_bottom_2,$fn=blade_resolution,center=false);
			translate([0,0,-0.1]) cylinder(d=blade_diameter-blade_thickness,h=height_top+height_bottom_1+height_bottom_2+10,$fn=blade_resolution,center=false);
		}
		
		translate([-blade_diameter/2,0,0]) cube([blade_diameter,blade_diameter,height_top+height_bottom_1+height_bottom_2], center=false);
	}
}

module _top_hull() {
	hull() {
		translate([0,0,0]) cylinder(d=diameter_top,h=0.1,$fn=resolution,center=false);
		translate([0,0,height_top]) cylinder(d=diameter_middle,h=0.1,$fn=resolution,center=false);
		translate([0,0,height_top+height_bottom_1]) cylinder(d=diameter_bottom,h=0.1,$fn=resolution,center=false);
		translate([0,0,height_top+height_bottom_1+height_bottom_2-(diameter_tip/2)]) sphere(d=diameter_tip,$fn=tip_resolution,center=true);
	}
}
module top_hull() {
	if(hull_rounded_corners_radius == 0) {
		_top_hull();
	} else {
		minkowski() {
			_top_hull();
			sphere(r=hull_rounded_corners_radius,$fn=resolution,center=true);
		}
	}
}
module top_cutout() {
	difference() {
		union() {
			// top hole
			hull() {
				translate([0,0,-0.1-hull_rounded_corners_radius]) cylinder(d=diameter_top-(2*airvents_border_top),h=0.1,$fn=resolution,center=false);
				translate([0,0,1]) cylinder(d=diameter_top-(2*airvents_border_top),h=0.1,$fn=resolution,center=false);
			}
			// empty space inside
			hull() {
				translate([0,0,hull_thickness_top]) cylinder(d=diameter_top-(hull_thickness_side*2),h=0.1,$fn=resolution,center=false);
				translate([0,0,height_top+hull_rounded_corners_radius]) cylinder(d=diameter_middle-(hull_thickness_side*2),h=0.1,$fn=resolution,center=false);
			}
			// air exit hole
			hull() {
				translate([0,0,height_top+hull_rounded_corners_radius]) cylinder(d=diameter_middle+4+(hull_rounded_corners_radius*2),h=0.1,$fn=resolution,center=false);
				translate([0,0,height_top+height_bottom_1]) cylinder(d=diameter_bottom+4+(hull_rounded_corners_radius*2),h=0.1,$fn=resolution,center=false);
			}
		}
		
		// inner chamfer
		hull() {
			translate([0,0,height_top+height_bottom_1-inner_chamfer_height+0.1+hull_rounded_corners_radius]) cylinder(d=1,h=0.1,$fn=resolution,center=false);
			translate([0,0,height_top+height_bottom_1]) cylinder(d=diameter_bottom+4+(hull_rounded_corners_radius*2),h=0.1,$fn=resolution,center=false);
		}
	}
}
module airblade() {
	difference() {
		top_hull();
		top_cutout();
	}
	intersection() {
		top_hull();
		for (i = [0:number_of_blades]) {
			translate([0,0,-hull_rounded_corners_radius]) rotate([0,0,i*(360/number_of_blades)]) blade();
		}
	}
}

module render() {
	if(everywhere_rounded_corners_radius == 0) {
		airblade();
	} else {
		minkowski() {
			airblade();
			sphere(r=everywhere_rounded_corners_radius,$fn=resolution,center=true);
		}
	}
}

render();