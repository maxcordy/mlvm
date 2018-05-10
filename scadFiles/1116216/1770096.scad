// set the amount of tolerance here
tolerance_inner_diameter = 0.2; // mm

difference() {
    // Outer form
    union() {
        translate([0, 0, 0.5]) {
            cylinder(h=9, d=15, $fn=200);
        }
        translate([0, 0, -1]) {
            cylinder(h=2.1, d=18, $fn=200);
        }
        translate([0, 0, 1.1]) {
            cylinder(h=0.7, d1=18, d2=15, $fn=200);
        }
        translate([0, 0, 8.2]) {
            cylinder(h=0.7, d1=15, d2=18, $fn=200);
        }
        translate([0, 0, 8.9]) {
            cylinder(h=2.1, d=18, $fn=200);
        }
    }
    // Cutouts
    translate([0, 0, -1.5]) {
        cylinder(h=13, d=13 + tolerance_inner_diameter * 2, $fn=200);
        cylinder(h=1.5, d=20, $fn=200);
        translate([0, 0, 11.5]) {
            cylinder(h=1.5, d=20, $fn=200);
        }
    }
}
