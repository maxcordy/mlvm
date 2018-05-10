// How big IS that phone? (mm; the default is the Nexus 4)
length=133.9;
width=68.7;
height=9.1;
use <utils/build_plate.scad>;
build_plate(3,230,200); // Type A Machines Series 1 build plate
module phone(length,width,height) {
	translate ([-width/2+5,-length/2+5,0]) minkowski() {
		cylinder(height/2,5,5);
		cube([width-10,length-10,height/2]);
	}
%translate([width/2+5+12.13,-length/2+5-12.13,0]) linear_extrude(height=1.75) scale([1/100,1/100,1/100]) circle(100*(12.13));
}
phone(length,width,height);
//phone(103.8,57.7,11.68); // HTC Liberty/Aria
//http://phone-size.com/ enables easy side-by-side comparison of many phones, for which it provides dimensions which may be plugged into the Customizer
// by Patrick Wiseman
// thingiverse.com/thing:48136
