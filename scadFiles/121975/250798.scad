trayWid = 18;
thickness = 2.4;
len = 50;

t2 = sqrt(2*thickness*thickness)/2;
translate([0,0,len/2]) rotate([90,0,0]) difference() {
	rotate([90,0,0]) tray();
	rotate([0,0,22.5]) {
		cylinder(r=2.25, h=50, center=true, $fn=8);
		translate([0,0,-45]) cylinder(r=6, h=50, center=false, $fn=8);
		translate([0,0,trayWid/2]) cylinder(r1=5.75, r2=2.25, h=3, center=true, $fn=8);
	}
}

module tray() {
	difference() {
		outside();
		translate([1,0,0]) cylinder(r=trayWid/2, h=len+1, center=true); // hollow it out
		linear_extrude(height=len+1, center=true) polygon([
			[0,0],
			[0, trayWid*2],
			[trayWid, 4],
			]);
	}
	translate([0.01,0,0]) hull() {
		// translate([0,trayWid/2,-13/2]) cube(size=[6, thickness+2, 13], center=false);
		translate([0,trayWid/2,0]) rotate([-90,0,0]) cylinder(r=trayWid/2-1, h=thickness+2, center=false);
		translate([0, trayWid/2+thickness, -len/2+0.1]) rotate([90,0,0]) cylinder(r=0.1, h=thickness, center=false);
		translate([0, trayWid/2+thickness, len/2-0.1]) rotate([90,0,0]) cylinder(r=0.1, h=thickness, center=false);
		}		
}

module outside() {
	r = trayWid/2+thickness;
	tx = [1,1];
	hull() {
		cylinder(r=r, h=len, center=true);
		// translate([-r/2,r/2+2,0]) cube(size=[r, r, 13], center=true);
		translate([0,2,0]) rotate([90,0,0]) cylinder(r=8, h=trayWid+thickness+2, center=true); // 
	}

}