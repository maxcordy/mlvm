innerD = 7;         // Diameter of the top hook
thick = 2;            // material thickness
lengthOverall = 60;  // Total length of the hook
supportDepth = 10;  // How far the bottom extends
supportHeight = 5; // How tall the bottom comes up
width = 20;         //  Width of the hook across

outerD = innerD + thick*2;

linear_extrude(height=width) {
    union() {
        union() {
            union() {
                union() {
                    difference() {
                        difference() {
                            circle(d=outerD, $fn=30);
                            circle(d=innerD, $fn=30);
                        }
                        translate([0, -outerD/2, 0]) square([outerD, outerD], false);
                    }
                    translate([0, innerD/2, 0]) square([thick, thick], false);
                }
                translate([0, -outerD/2, 0]) square([lengthOverall-outerD/2, thick], false);
            }
            translate([lengthOverall-outerD/2-thick, -outerD/2-supportDepth, 0]) square([thick, supportDepth]);
        }
        translate([lengthOverall-outerD/2-supportHeight-thick, -outerD/2-supportDepth-thick]) square([supportHeight+thick, thick]);
    }
}