// thickness of the bed head bar in mm
bedhead_depth = 38.7;

// width of the magnet in mm (if round use diameter)
magnetWidth = 6.5;
// depth of the magnet in mm (if round use diameter)
magnetDepth = 6.5;
// height of the magnet in mm
magnetHeight = 2.5;

// thickness of the grip arms in mm
gripWidth = 3;
// height of the grip arms in mm (default is 5 times the thickness)
gripHeight = gripWidth * 5;

// width of the holder in mm
baseWidth = 30;
// depth of the holder in mm (default is thickness of bed head bar plus 2 times thickness of the grip arms)
baseDepth = bedhead_depth + 2 * gripWidth;
// height of the holder in mm (default is height of the magnet plus 2mm)
baseHeight = magnetHeight + 2;

module fakeBeadHead() {
    width = 500;
    height = 200;
    translate([0, 0, -half(height)])
        %cube([width, bedhead_depth, height], true);
}

module magneticBase() {
    difference() {
        translate([0, 0, half(baseHeight)]) {
            cube([baseWidth, baseDepth, baseHeight], true);
        }
        for (directionX = [-1, 1]) {
            for (directionY = [-1, 1]) {
                translate([directionX * quarter(baseWidth), directionY * quarter(baseDepth), half(magnetHeight)]) {
                    #cube([magnetWidth, magnetDepth, magnetHeight], true);
                }
            }
        }
    }
    for (direction = [-1, 1]) {
        difference() {
            translate([0, (direction*half(baseDepth))-(direction*half(gripWidth)), 0]) {
                translate([0, 0, -(gripHeight/2)]) {
                    cube([baseWidth, gripWidth, gripHeight], true);
                }
                translate([0, 0, -(gripHeight)]) {
                    rotate([0, 90, 0]) {
                        cylinder(h = baseWidth, d = gripWidth, center = true, $fn = 42);
                    }
                }
            }
            for (dirX = [-1, 1]) {
                translate([dirX*half(half(baseWidth)), direction*(half(bedhead_depth)+half(magnetHeight)), -half(gripHeight)]) {
                    rotate([90, 0, 0]) { rotate([0, 0, 45]) {
                        #cube([magnetWidth, magnetDepth, magnetHeight], true);
                    }}
                }
            }
        }
    }
}

fakeBeadHead();
magneticBase();

function half(value) = value / 2;
function quarter(value) = value / 4;
