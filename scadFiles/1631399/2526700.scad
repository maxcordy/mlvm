diameter = 36.6; // 36.6
depth = 8.5; // 8.5
resolution = 400; // 400

radius = diameter/2; // default radius = 18.3

rotate([0,90,0]) {
	intersection() {
		difference() {
			union() {
				translate([0,0,-1]) cylinder(h=depth+2, r1=radius+1, r2=radius+1, $fn=resolution, center=false);
				translate([0,0,-10]) cube(size = [20,8,30], center = true);
				
				hull() {
					rotate([90,0,0]) translate([5,-25,0]) cylinder(h=8, r1=5, r2=5, $fn=resolution, center=true);
					rotate([90,0,0]) translate([-5,-25,0]) cylinder(h=8, r1=5, r2=5, $fn=resolution, center=true);
				}

				rotate([0,90,0]) translate([0,0,0]) scale([1,0.3,1]) cylinder(h=1, r1=20, r2=20, $fn=resolution, center=true);
			}
			cylinder(h=depth, r1=radius, r2=radius, $fn=resolution, center=false);
			cylinder(h=(depth+50), r1=(radius-1.3), r2=(radius-1.3), $fn=resolution, center=false);
			
			translate([20,0,0]) cube(size = [20,120,50], center = true);
			translate([-20,0,0]) cube(size = [20,120,50], center = true);

			for (i = [0:20]) {
				translate([0,0,-4-(i*2)]) rotate([0,-90,0]) cylinder(30,2.7 - (i*0.08),2.7 - (i*0.08),$fn=3,center=true);
			}
		}
		
		top = depth+radius+1.2;
		height = 200;
		center = -(height/2)+top;
		translate([0,0,center]) cylinder(h=height, r1=height, r2=0, $fn=resolution, center=true);
	}
}