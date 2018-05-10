back_height = 95;
back_width = 87.1+8;
back_depth = 65; //57

resolution = 100;
edge_radius = 4;
nema_depth = 42;

screw_1 = true;
screw_1_x = (53/2)+0.1;
screw_1_z = 49.6+20;
screw_2 = true;
screw_2_x = -((53/2)+0.1);
screw_2_z = 49.6+20;
screw_3 = false;
screw_3_x = -5.15;
screw_3_z = -0.35+20;
screw_4 = true;
screw_4_x = 5.15;
screw_4_z = -0.35+20;

filament_guide_attachment_offset = 3.1;

support = true;

module round_edge() {
	rotate([0,90,0]) cylinder(h=4, d=edge_radius, center=true, $fn=resolution);
}

module hand_cube() {
	hull() {
		translate([0,-(14.98/2-(edge_radius/2)), -(12.8/2-(edge_radius/2))]) round_edge();
		translate([0,(14.98/2-(edge_radius/2)), -(12.8/2-(edge_radius/2))]) round_edge();
		translate([0,-(14.98/2-(edge_radius/2)), (12.8/2-(edge_radius/2))]) round_edge();
		translate([0,(14.98/2-(edge_radius/2)), (12.8/2-(edge_radius/2))]) round_edge();
	}
}

module hand() {
	difference() {
		hull() {
			cube([4,14.98,12.8+4],center=true);
			translate([0,back_depth+2,-26]) round_edge();
			translate([0,back_depth+2,back_height-22]) round_edge();
		}
		/*
		for(i = [0 : 1 : 4]) {
			hull() {
				translate([0,50,-20+(i*12)]) scale([2,1,1]) round_edge();
				translate([0,15+(i*7),-6+(i*7)]) scale([2,1,1]) round_edge();
			}
		}
		*/
		translate([0,13,3]) {
			for(i = [0 : 1 : 4]) {
				hull() {
					translate([0,50,-18+((4-i)*11)]) scale([2,1,1]) rotate([0,90,0]) cylinder(h=4, d=3, center=true, $fn=resolution);
					translate([0,12+(i*8),-8.5-(i*2)]) scale([2,1,1]) rotate([0,90,0]) cylinder(h=4, d=3, center=true, $fn=resolution);
				}
			}
		}
	}
}
module hand_support() {
	width = 4;
	difference() {
		hull() {
			cube([4,14.98,12.8+4],center=true);
			translate([0,back_depth+2,-26]) round_edge();
			translate([0,back_depth+2,back_height-22]) round_edge();
		}
		hull() {
			cube([8,14.98-width,12.8+4-width],center=true);
			translate([0,back_depth,-26+width]) rotate([0,90,0]) cylinder(h=8, d=edge_radius, center=true, $fn=resolution);
			translate([0,back_depth,back_height-22-width]) rotate([0,90,0]) cylinder(h=8, d=edge_radius, center=true, $fn=resolution);
		}
	}
}

difference() {
	union() {
		// right hand
		translate([87.1/2 + 2,0.01,0.01]) {
			difference() {
				hand();
		
				// screw holes
				translate([0,-((14.98/2)-3.02),+((12.8/2)-3.5)]) rotate([0,90,0]) cylinder(h=20, d=2.7, center=true, $fn=resolution);
				translate([0,+((14.98/2)-3.02),+((12.8/2)-3.5)]) rotate([0,90,0]) cylinder(h=20, d=2.7, center=true, $fn=resolution);
			}
			
			// hand support
			hull() {
				translate([-6.5,back_depth+2,back_height-22]) rotate([0,90,0]) cylinder(h=4+13, d=edge_radius, center=true, $fn=resolution);
				translate([0,back_depth+2-44,back_height-22-40]) rotate([0,90,0]) cylinder(h=4, d=edge_radius, center=true, $fn=resolution);
				translate([0,back_depth+2,back_height-22-40]) rotate([0,90,0]) cylinder(h=4, d=edge_radius, center=true, $fn=resolution);
			}
			
			translate([2,0,0]) hand_support();
		}
		
		
		// left hand
		translate([-(87.1/2 + 2),0.01,0.01]) {
			difference() {
				hand();
		
				// screw holes
				translate([0,-((14.98/2)-3.02),-((12.8/2)-3.4)]) rotate([0,90,0]) cylinder(h=20, d=2.7, center=true, $fn=resolution);
				translate([0,+((14.98/2)-3.02),-((12.8/2)-3.4)]) rotate([0,90,0]) cylinder(h=20, d=2.7, center=true, $fn=resolution);
			}

			// hand support
			hull() {
				translate([6.5,back_depth+2,back_height-22]) rotate([0,90,0]) cylinder(h=4+13, d=edge_radius, center=true, $fn=resolution);
				translate([0,back_depth+2-44,back_height-22-40]) rotate([0,90,0]) cylinder(h=4, d=edge_radius, center=true, $fn=resolution);
				translate([0,back_depth+2,back_height-22-40]) rotate([0,90,0]) cylinder(h=4, d=edge_radius, center=true, $fn=resolution);
			}
			
			translate([-2,0,0]) hand_support();
		}
		
		// middle hand
		difference() {
			union() {
				translate([0,0.01,0.01]) scale([1.2,1,1]) hand();
				translate([0,0.01+25,0.01]) scale([1.2,1,1]) cube([4,14.98+50,25],center=true);
				//#translate([0,14,4.01]) cube([4,23,33],center=true);

				// support
				translate([0,(back_depth/2)-3,-(14.98)/2]) cube([87.1+4,back_depth+6.9+2,2],center=true);
			}
			
			// screw holes
			//translate([0,-((14.98/2)-3.02),-10]) rotate([0,0,0]) cylinder(h=20, d=2.7, center=true, $fn=resolution);
			//translate([0,+((14.98/2)-3.02),-10]) rotate([0,0,0]) cylinder(h=20, d=2.7, center=true, $fn=resolution);
			
			// place for center screw
			hull() {
				translate([0,back_depth-2,-5]) scale([2,1,1]) round_edge();
				translate([0,20,10]) scale([2,1,1]) round_edge();
				translate([0,back_depth-2,50]) scale([2,1,1]) round_edge();
			}
		}
		
		// nema support
		translate([0,(back_depth/2)+15+2,-(14.98)/2+(3.5/2)]) cube([87.1+4,back_depth-30,2+3.5],center=true);
	}

	// nema
	difference() {
		union() {
			translate([(87.1/2)-(42/2),-10,-(12.9/2)+(42/2)]) cube([42,130,42],center=true);
			translate([-(87.1/2)+(42/2),-10,-(12.9/2)+(42/2)]) cube([42,130,42],center=true);
			
			translate([(87.1/2)-(42/2),-10+40+(back_depth/2)-1,-(12.9/2)+(42/2)+1.5]) cube([44,45+back_depth,45],center=true);
			translate([-(87.1/2)+(42/2),-10+40+(back_depth/2)-1,-(12.9/2)+(42/2)+1.5]) cube([44,45+back_depth,45],center=true);
			
			union() {
				#cube([87.1,14.98,12.9],center=true);
				
				#translate([(87.1/2)-(42/2),(14.98/2)+(nema_depth/2),-(12.9/2)+(42/2)]) cube([42,nema_depth,42],center=true);
				#translate([17,0,-(12.9/2)-(25/2)]) cylinder(h=25, d=8, center=true, $fn=resolution);
				#translate([-(87.1/2)+(42/2),(14.98/2)+(nema_depth/2),-(12.9/2)+(42/2)]) cube([42,nema_depth,42],center=true);
				#translate([-17,0,-(12.9/2)-(25/2)]) cylinder(h=25, d=8, center=true, $fn=resolution);
			}
		}
		// nema support
		translate([0,(back_depth/2)+15+2,-(14.98)/2+(3.5/2)]) cube([87.1+4,back_depth-30,2+3.5],center=true);
	}
	
	// nema support ridges
	//translate([(87.1/2)-13-7,(back_depth/2),-(14.98)/2+(3.5/2)]) cube([26,30,10],center=true);
	
	// bottom holes
	difference() {
		hull() {
			translate([(87.1/4+1)+16,30,0]) cylinder(h=20, d=10, center=true, $fn=resolution);
			translate([(87.1/4+1)-14,30,0]) cylinder(h=20, d=10, center=true, $fn=resolution);
			
			translate([(87.1/4+1)+16,15,0]) cylinder(h=20, d=10, center=true, $fn=resolution);
			translate([(87.1/4+1)-14,-3,0]) cylinder(h=20, d=10, center=true, $fn=resolution);
			
			translate([87.1/4+1,8,0]) cylinder(h=20, d=38, center=true, $fn=resolution);
		}
		translate([(87.1/4+1)+23,-5,0]) cylinder(h=20, d=30, center=true, $fn=resolution);
	}
	difference() {
		hull() {
			translate([-(87.1/4+1)+14,30,0]) cylinder(h=20, d=10, center=true, $fn=resolution);
			translate([-(87.1/4+1)-16,30,0]) cylinder(h=20, d=10, center=true, $fn=resolution);
			
			translate([-(87.1/4+1)+14,-3,0]) cylinder(h=20, d=10, center=true, $fn=resolution);
			translate([-(87.1/4+1)-16,15,0]) cylinder(h=20, d=10, center=true, $fn=resolution);
			
			translate([-(87.1/4+1),8,0]) cylinder(h=20, d=38, center=true, $fn=resolution);
		}
		translate([-(87.1/4+1)-23,-5,0]) cylinder(h=20, d=30, center=true, $fn=resolution);
	}
	

	// side screw holes
	translate([38,0,-10]) rotate([0,0,0]) cylinder(h=20, d=2.7, center=true, $fn=resolution);
	translate([-38,0,-10]) rotate([0,0,0]) cylinder(h=20, d=2.7, center=true, $fn=resolution);
	
	
	hull() {
		translate([(87.1/4+1)+9,back_depth-16.5+4,0]) cylinder(h=20, d=24, center=true, $fn=resolution);
		translate([(87.1/4+1)-9,back_depth-16.5+4,0]) cylinder(h=20, d=24, center=true, $fn=resolution);
	}
	hull() {		
		translate([-(87.1/4+1)+9,back_depth-16.5+4,0]) cylinder(h=20, d=24, center=true, $fn=resolution);
		translate([-(87.1/4+1)-9,back_depth-16.5+4,0]) cylinder(h=20, d=24, center=true, $fn=resolution);
	}
}

// bottom screw insert support
intersection() {
	difference() {
		union() {
			translate([(87.1/4+1)+23,-5,-9.5]) cylinder(h=4, d=30, center=true, $fn=resolution);
			translate([-(87.1/4+1)-23,-5,-9.5]) cylinder(h=4, d=30, center=true, $fn=resolution);
		}
		union() {
			translate([(87.1/4+1)+23,-5,-9.5]) cylinder(h=4, d=26, center=true, $fn=resolution);
			translate([-(87.1/4+1)-23,-5,-9.5]) cylinder(h=4, d=26, center=true, $fn=resolution);
		}
	}
	translate([0,+5,-4]) cube([87.1,14.98+10,12.9],center=true);
}

// filament guide holder
module guide(offset) {
	difference() {
		union() {
			hull() {
				translate([offset,back_depth,65]) cube([16,2,15],center=true);
				translate([0.4,-1,65]) cylinder(h=15, d=9.5, center=true, $fn=resolution);
			}
			// bottom guide
			hull() {
				translate([0.4,-1,53]) cylinder(h=9, d1=6, d2=9.5, center=true, $fn=resolution);
				translate([0.4,40,65]) cylinder(h=1, d=1, center=true, $fn=resolution);
			}
			// top guide
			hull() {
				translate([0.4,-1,75]) cylinder(h=5, d2=9, d1=9.5, center=true, $fn=resolution);
				translate([0.4,40,65]) cylinder(h=1, d=1, center=true, $fn=resolution);
			}
		}
		
		translate([0.4,-1,65]) cylinder(h=50, d=3.5, center=true, $fn=resolution);
		translate([0.4,-1,77]) cylinder(h=36, d1=6.1, d2=8.7, center=true, $fn=resolution);
		
		//6.1
	}
}
translate([-18,0,0]) guide(filament_guide_attachment_offset);
translate([18,0,0]) guide(-filament_guide_attachment_offset);

// downward cooling fan
module fan(offset) {
	difference() {
		hull() {
			translate([0,35,-18]) rotate([-18,0,0]) translate([0,1,6-5-3]) cube([45,42,4], center=true);
			translate([offset,32,-23]) rotate([0,0,0]) cube([25,40,10], center=true);
		}
		translate([0,38,-18]) rotate([-19,0,0]) translate([0,0,6]) cube([42,40,20], center=true);
		translate([0,38,-18]) rotate([-19,0,0]) translate([0,0,11]) cube([50,40,20], center=true);
		
		hull() {
			translate([offset,32,-22.3]) rotate([19,0,0]) translate([0,4,2.5]) cube([20,50,1], center=true);
			translate([0,38,-18]) rotate([-19,0,0]) cube([26,23,10], center=true);
		}
		translate([offset,33,-23]) rotate([19,0,0]) translate([0,-26+4,1.5]) cube([20,5,4], center=true);
		
		translate([0,-10,-(12.9/2)+(42/2)]) cube([42,130,42],center=true);
		
		translate([0,38,-20]) rotate([-19,0,0]) translate([-15.4,15.4,0]) cylinder(h=80, d=2, center=true, $fn=resolution);
		translate([0,38,-20]) rotate([-19,0,0]) translate([-15.4,15.4,-16]) cylinder(h=20, d=5, center=true, $fn=resolution);
		
		translate([0,38,-20]) rotate([-19,0,0]) translate([15.4,15.4,0]) cylinder(h=80, d=2, center=true, $fn=resolution);
		translate([0,38,-20]) rotate([-19,0,0]) translate([15.4,15.4,-16]) cylinder(h=20, d=5, center=true, $fn=resolution);
		
		if(offset < 0) {
			translate([0,38,-20]) rotate([-19,0,0]) translate([15.4,-15.4,0]) cylinder(h=80, d=2, center=true, $fn=resolution);
			translate([0,38,-20]) rotate([-19,0,0]) translate([15.4,-15.4,-16]) cylinder(h=20, d=5, center=true, $fn=resolution);
		} else {
			translate([0,38,-20]) rotate([-19,0,0]) translate([-15.4,-15.4,0]) cylinder(h=80, d=2, center=true, $fn=resolution);
			translate([0,38,-20]) rotate([-19,0,0]) translate([-15.4,-15.4,-16]) cylinder(h=20, d=5, center=true, $fn=resolution);
		}
		
		// nema
		translate([0,-10,-(12.9/2)+(42/2)]) cube([43,130,42],center=true);
	
		#translate([0,38,-17]) rotate([-19,0,0]) cube([40,40,10], center=true);
	}
}
translate([-23,0,0]) fan(5);
translate([23,0,0]) fan(-5);

// cable attachment
difference() {
	translate([0,back_depth - 2 /*53*/,back_height-10]) cube([20,12,30],center=true);
	translate([0,back_depth - 2 - 5 /*48*/,back_height-10]) cylinder(h=50, d=17, center=true, $fn=resolution);
	translate([-10,back_depth - 2 + 1 /*63*/,5+back_height-10]) rotate([0,0,45]) cube([50,2,8],center=true);
	translate([10,back_depth - 2 + 1 /*63*/,5+back_height-10]) rotate([0,0,-45]) cube([50,2,8],center=true);
}
// backplate

module screw_hole() {
	translate([0,-2, 0]) rotate([90,0,0]) cylinder(h=20, d=3.88, center=true, $fn=resolution);
}
module nut_holder() {
	difference() {
		translate([0,-2, 0]) rotate([90,0,0]) cylinder(h=6, d=12, center=true, $fn=resolution);
		hull() {
			translate([0,-2, 0]) rotate([90,90,0]) cylinder(h=3.05, d=8.5, center=true, $fn=6);
			translate([0,-2,10]) rotate([90,90,0]) cylinder(h=3.05, d=8.5, center=true, $fn=6);
		}
		translate([0,-13,8]) cube([20,20,20],center=true);
	}
}

// backplate && screw inserts
difference() {
	union() {
		// backplate
		translate([-(back_width/2),back_depth,-19]) cube([back_width,4,back_height],center=false);
		
		if(screw_1) {
			translate([screw_1_x, back_depth, screw_1_z]) nut_holder();
		}
		if(screw_2) {
			translate([screw_2_x, back_depth, screw_2_z]) nut_holder();
		}
		if(screw_3) {
			translate([screw_3_x, back_depth, screw_3_z]) nut_holder();
		}
		if(screw_4) {
			translate([screw_4_x, back_depth, screw_4_z]) nut_holder();
		}
	}
	if(screw_1) {
		translate([screw_1_x, back_depth, screw_1_z]) screw_hole();
	}
	if(screw_2) {
		translate([screw_2_x, back_depth, screw_2_z]) screw_hole();
	}
	if(screw_3) {
		translate([screw_3_x, back_depth, screw_3_z]) screw_hole();
	}
	if(screw_4) {
		translate([screw_4_x, back_depth, screw_4_z]) screw_hole();
	}
}

// front cable holder
/*
difference() {
	union() {
		translate([0,-10,13]) cube([2.8,30,10], center=true);
		hull() {
			translate([0,-30+3,13]) cylinder(h=10,d=6,center=true,$fn=resolution);
			translate([0,-30+3+20,13]) cylinder(h=10,d=1,center=true,$fn=resolution);
		}
	}
	translate([0,-30+3,13]) cylinder(h=12,d=3,center=true,$fn=resolution);

	//translate([0,-30+3,13]) cube([10,10,2], center=true);
	
	//translate([0,-30+3,13+5]) rotate([0,0,30]) translate([0,5,0]) cube([2,10,10], center=true);
	//translate([0,-30+3,13-5]) rotate([0,0,-30]) translate([0,5,0]) cube([2,10,10], center=true);

	translate([0,-30+3,13]) cube([1,15,12], center=true);
	
}
*/

// support
if(support) {
	//translate([-(back_width/2),back_depth,-19]) cube([back_width,2,back_height],center=false);
	
	height = 10;
	translate([-(back_width/2)+4.5,back_depth-height,-20-10]) {
		cube([40,4+height,8], center=false);
	}
	translate([(back_width/2)-4.5-40,back_depth-height,-20-10]) {
		cube([40,4+height,8], center=false);
	}
	/*
	translate([(back_width/2)-98,back_depth-height+12.1,-20-10]) {
		cube([101,1.9,8], center=false);
	}*/
}