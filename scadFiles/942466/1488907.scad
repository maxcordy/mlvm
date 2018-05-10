// The hole diameter you are going for
diameter = 3;

// The number of additional holes
iterations = 10;

// The amount added to the diameter each iteration
step = 0.1;

// The height of the vertical holes
heightBottom = 4;

// The width of the horizontal holes
widthTop = 4;

/* [Hidden] */
padding = 3;
width = (diameter + iterations * step) + 6;
height = width + heightBottom;
length = (diameter * iterations) + (step * iterations) + (padding * iterations) + diameter * 3 ;

$fn = 360;

difference() {
    union() {
        cube([length, width, heightBottom]);
        
        translate([0, width, 0])
            cube([length, widthTop, height]);
    }
    
	for(i = [0 : iterations]) {
        translate([diameter * 1.5, width / 2, -1])
            translate([(diameter * i) + (step * i) + (padding * i), 0, 0])
                cylinder(h=heightBottom + 2, r=(diameter + (step * i)) / 2);
        
        translate([diameter * 1.5 + (diameter * i) + (step * i) + (padding * i), width + widthTop + 1, heightBottom + width / 2])
            rotate([90, 0, 0])
                cylinder(h=heightBottom + 2, r=(diameter + (step * i)) / 2);
	}
}