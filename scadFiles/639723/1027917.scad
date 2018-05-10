// variables
height = 30; // [1:400]
size = 8; // [4,6,8]
// calculations
s = size/8;
// model
scale([s,s,1]) union(){
for (z = [1, 2, 3]) 
{
	rotate([0,0,90*z]) translate([-15,-15,0]) difference(){
		hull(){
			translate([3,3,0]) cylinder(h=height,r=3,$fn=100);
			translate([9,0,0]) cube([6,6,height]);
			translate([9,9,0]) cube([6,6,height]);
			translate([0,9,0]) cube([6,6,height]);
		}
		hull(){
			translate([7.85,3.3,0]) cylinder(h=height,r=1.3,$fn=100);
			translate([14,2,0]) cube([1,1,height]);
			translate([13.54,8,0]) cylinder(h=height,r=2,$fn=100);
			translate([14,9,0]) cube([1,1,height]);
		}
		hull(){
			translate([11,0,0]) cube([2,2,height]);
			translate([13,0,0]) cube([2,2,height]);
		}
		mirror([5,-5,0]) hull(){
			translate([7.85,3.3,0]) cylinder(h=height,r=1.3,$fn=100);
			translate([14,2,0]) cube([1,1,height]);
			translate([13.54,8,0]) cylinder(h=height,r=2,$fn=100);
			translate([14,9,0]) cube([1,1,height]);
		}
		mirror([5,-5,0]) hull(){
			translate([11,-0.5,0]) cube([3,3,height]);
			translate([13,-0.5,0]) cube([3,3,height]);
		}
		translate([15,15,0]) cylinder(h=height,r=3.4,$fn=100);
	}
}
	difference(){
		translate([-5,-5,0]) cube([10,10,height]);
		translate([0,0,0]) cylinder(h=height,r=3.4,$fn=100);
	}
	hull(){
		translate([-14,4,0]) cylinder(h=height,r=1,$fn=100);
		translate([4,-14,0]) cylinder(h=height,r=1,$fn=100);
	}
}