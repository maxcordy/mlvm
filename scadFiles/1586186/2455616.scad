$fa=0.5; // default minimum facet angle
$fs=0.5; // default minimum facet size

length		= 150;
height		= 50;
width 		= 50;
font_size	= 30;

function angle() = 
	atan(height / length);

module doorstop() {
	translate([0, width/2, 0])
	rotate([90, 0, 0])
	linear_extrude(width) 
	polygon(points=[[0,0], [length,0], [0,height]]);
}

module hodor() {
	linear_extrude(5)
	text("HODOR", size = font_size, font = "Liberation Mono");
}

module hold_the_door() {
	difference() {
		doorstop();
		rotate([0, angle(), 0])
		translate([0, -font_size/2, 45]) {
			hodor();
		}
	}
}