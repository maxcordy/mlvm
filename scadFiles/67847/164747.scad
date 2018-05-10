$fn=100;

bodyWidth = 20;
thickness = 7;

difference()
{
	union(){
		cube([40,bodyWidth,3]);
		translate([12.5,2.5,0]) cube([15,15,10]);
	}
	translate([10,bodyWidth/2,-1]) cylinder(h=thickness+2,r=1.75);
	translate([10+20,bodyWidth/2,-1]) cylinder(h=thickness+2,r=1.75);
	translate([15,9,1]) rotate(a=[40,0,0]) cube([10,10,50]);
}

