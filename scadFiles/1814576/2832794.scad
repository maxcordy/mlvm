resolution = 80; // 10; don't increase too much, or you'll get performance issues
width = 95;
height = 120;

translate([100,100,-15]) {
	difference() {
		cylinder(h=20,d=33,$fn=resolution,center=true);

		for (x = [-10:10]) {
			translate([0,x*3,24]) rotate([45,0,0]) cube([200,40,40], center=true);
			translate([x*3,0,24]) rotate([0,45,0]) cube([40,200,40], center=true);
		}
	}
}

difference() {
	union() {
		x_max = floor((200-5)/(2*10));
		y_max = floor((width+20-5)/(2*10));

		// base
		difference() {
			cube([200,width+20,50], center=true);
			translate([80,width/2-10,-32]) cylinder(h=20,d=35,$fn=resolution,center=true);
			translate([-80,width/2-10,-32]) cylinder(h=20,d=35,$fn=resolution,center=true);
			translate([80,-(width/2-10),-32]) cylinder(h=20,d=35,$fn=resolution,center=true);
			translate([-80,-(width/2-10),-32]) cylinder(h=20,d=35,$fn=resolution,center=true);
		}
		/*
		difference() {
			cube([200,width+20,50], center=true);
			for (x = [-x_max*2:x_max*2]) {
				translate([x*10,0,-33]) rotate([0,0,45]) cube([300,3,20], center=true);
			}
			
		for (x = [-x_max/2:x_max/2]) {
			for (y = [-y_max/2:y_max/2]) {
					translate([x*20, y*20, -25]) sphere(d=10,$fn=resolution,center=true);
				}
			}
		}
		*/
		
		// holder
		hull() {
			translate([0,0,height]) rotate([90,0,0]) cylinder(h=width+20,d=35,$fn=resolution,center=true);
			translate([-30,0,0]) rotate([90,0,0]) cylinder(h=width+20,d=35,$fn=resolution,center=true);
			translate([30,0,0]) rotate([90,0,0]) cylinder(h=width+20,d=35,$fn=resolution,center=true);
		}
		
		// bottom stucture
		/*
		for (x = [-x_max/2:x_max/2]) {
			for (y = [-y_max/2:y_max/2]) {
				difference() {
					intersection() {
						cube([200,width+20,50], center=true);
						translate([x*20, y*20, -20]) sphere(d=17,$fn=resolution,center=true);
					}
					translate([x*20, y*20, -25]) sphere(d=10,$fn=resolution,center=true);
				}
			}
		}
		*/
	}
	
	// filament spool cutout
	translate([0,0,100]) rotate([90,0,0]) cylinder(h=width,d=230,$fn=resolution,center=true);
	
	// filament axis cutout
	translate([0,0,height]) rotate([90,0,0]) cylinder(h=width+10,d=30,$fn=resolution,center=true);
	
	// top cutoff
	translate([0,0,height+50]) cube([100,width+60,100], center=true);
	
	// filament guide
	translate([160,0,-20]) rotate([0,90,0]) {
		translate([-3-30,0,-80]) cylinder(h=90, r1=2, r2=2, center=true, $fn=resolution);
		//translate([-3-30,0,-106]) cylinder(h=20, r1=40, r2=1, center=true, $fn=resolution);
		//translate([-3-30,0,-104]) cylinder(h=20, r1=20, r2=1, center=true, $fn=resolution);
		translate([-3-30,0,-56]) cylinder(h=50, r1=3.16, r2=3.6, center=true, $fn=resolution);
		translate([-3-30,0,-60]) cylinder(h=10, r1=1, r2=10, center=true, $fn=resolution);
	}
}
/*#difference() {
	translate([0,0,110]) rotate([90,0,0]) cylinder(h=width,d=200,$fn=resolution,center=true);
	translate([0,0,110]) rotate([90,0,0]) cylinder(h=width+10,d=50,$fn=resolution,center=true);
}*/

translate([0,100,((width+10)/2) - 25]) cylinder(h=width+10,d=30,$fn=resolution,center=true);