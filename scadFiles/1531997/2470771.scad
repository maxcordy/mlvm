/* [Hotend] */

// Hotend's heatsink diameter
heatsinkDiameter = 25;  // [15:29]
// Length of the clamp
clampLength = 30;  // [18.125:0.125:32.5]
// Z-Probe screw notch
zProbeScrew = 0;  // [1:Present, 0:Absent]
// Height of the Z-Probe Screw
zProbeScrewHeight = 12;  // [0:26]

/* [Fans] */

// Number of fans
doubleSideFan = 0;  // [1:Double, 0:Single]
// Side fan mouth size
widerMouth = 0;  // [1:Bigger, 0:Normal]

// E3D V6 chinese clone placeholder
% union() {
  cylinder(30, heatsinkDiameter / 2, heatsinkDiameter / 2, $fn = 200);
  translate([0, 0, 30]) cylinder(6, 3, 3);
  translate([-14.5, -10, 36]) cube([20, 20, 10]);
  translate([0, 0, 46]) cylinder(4, 3, 3);
  translate([0, 0, 50]) cylinder(3, 3, 0.4);
}

module e3d() {
  translate([0, 0, -1]) cylinder(32, heatsinkDiameter / 2, heatsinkDiameter / 2, $fn = 200);
}

module sideCurve40() {
  intersection() {
    translate([-5 + (30 - clampLength), -20, 0]) cube([clampLength, 8, 25]);
    translate([20, 30, -1]) cylinder(32, 50, 50, $fn = 500);
  }
}

module topCurve40(cut = true) {
  difference() {
    difference() {
      translate([20, -20, 24.5]) rotate([0, 0, 90]) cube([33.25, 14, 15.5]);
      translate([1, 0, 38.8275]) rotate([90, 0, 0]) cylinder(44, 15, 15, true, $fn = 200);
    }
    if (cut) {
      e3d();
      translate([20, -21, 0]) rotate([0, -90, 0]) cube([50, 7.75, 15]);
    }
  }
}

module topCurve40Corner() {
  intersection() {
    translate([0, -15, 0]) topCurve40(false);
    translate([0, 0, 25]) sideCurve40();
    translate([20, -21, 0]) rotate([0, -90, 0]) cube([50, 7.75, 15]);
  }
}

module m3Hole() {
  cylinder(16, 1.5, 1.5, $fn = 50);
}

module mainBody() {
  // Hot end attachment & 40mm fan mount
  difference() {
    union() {
      // Hot end attachment
      difference() {
        translate([-3, -13.25, 0]) cube([25, 26.5, 25]);
        e3d();
      }

      // Fan mount
      translate([25, -20, 0]) rotate([0, -90, 0]) cube([40, 40, 6]);

      // Side curves
      difference() {
        union() {
          sideCurve40();
          mirror([0, 1, 0]) sideCurve40();
        }
        e3d();
      }

      // Top curve
      topCurve40(true);
      topCurve40Corner();
      mirror([0, 1, 0]) topCurve40Corner();
    }
    // Fan funnel
    hull() {
      translate([5, 0, 11]) rotate([0, 75, 0]) cylinder(30, 11, 12.5, $fn = 100);
      translate([26, 0, 20]) rotate([0, 90, 0]) cylinder(1, 18, 18, $fn = 100);
    }
    // M3 holes
    translate([10, -16, 3]) rotate([0, 90, 0]) m3Hole();
    mirror([0, 1, 0]) translate([10, -16, 3]) rotate([0, 90, 0]) m3Hole();
    translate([10, -16, 36]) rotate([0, 90, 0]) m3Hole();
    mirror([0, 1, 0]) translate([10, -16, 36]) rotate([0, 90, 0]) m3Hole();
  }
}

module sideMount() {
  translate([-5, -50, 15]) hull() {
    cube([30, 30, 1.25]);
    translate([0, 0, 15]) cube([30, 30, 1.25]);
  }
}

module sideBodyHollowed() {
  // 30mm fan mount
  union() {
    difference() {
      // Shell
      hull() {
        sideMount();
        translate([-6, -36.25, 40]) cube([22.5, 16.25, 1]);
      }
      // Hollow
      hull() {
        translate([0.9, -5.3, 3]) scale([0.9, 0.8, 0.9]) sideMount();
        translate([-5, -35.45, 40]) rotate([5, 0, 0]) scale([0.85, 0.9, 1]) cube([22.5, 16.25, 1.5]);
      }
    }
    
    translate([0, 0, -1]) difference() {
      // Shell
      hull() {
        translate([-6, -36.25, 40]) cube([22.5, 16.25, 2]);
        translate([-7.75, -19.6, 50.75]) scale([1.25, 1.25, 1.25]) rotate([-45, 0, 0]) if (widerMouth) {
            translate([0, -1.25, 0]) cube([15, 6.5, 1]);
        } else {
            translate([0, -0.25, 0]) cube([15, 4.5, 1]);
        }
      }
      // Hollow
      hull() {
        translate([-5, -35.45, 38]) rotate([5, 0, 0]) scale([0.9, 0.9, 2.5]) cube([22.5, 16.25, 1.5]);
        translate([-6, -19.6, 50]) rotate([-45, 0, 0]) if (widerMouth) {
           translate([0, -1, 0]) cube([15, 6, 2]);
        } else {
            cube([15, 4, 2]);
        }
      }
   }
  }
}

module sideBodyHoles() {
  translate([10, -35, 20]) cylinder(15, 13.5, 10, $fn = 100, true);
  translate([22, -22.5, 12]) union() {
    translate([0, 0, 0]) m3Hole();
    translate([0, -24, 0]) m3Hole();
    translate([-24, 0, 0]) m3Hole();
    translate([-24, -24, 0]) m3Hole();
  }
}

module sideBody() {
  difference() {
    sideBodyHollowed();
    sideBodyHoles();
  }
}

module finalPiece() {
  union() {
    mainBody();
    sideBody();
    if (doubleSideFan) {
      mirror([0, 1, 0]) sideBody();
    }
  }
}

if (zProbeScrew) {
  difference() {
      finalPiece();
      translate([-9, 11.75, -1]) cube([10, 5, zProbeScrewHeight + 1]);
  }
} else {
  finalPiece();
}