
width = 72.5;
height = 146.85;
rounding = 9.4;
thickness = 8.2;
shell_thickness = 2;
add_support = true;

module round(size, corner) {
      hull() {
      for (x = [0, size[0]]) {
        for (y = [0, size[1]]) {
          translate([x, y, 0])
            cylinder(r=corner, h=size[2]);
        }
      }
    }

}
// Makes a cube with four rounded corners and all edges chamfered
module doubleround(size, corner, chamfer)
{
  $fn=30;

  minkowski(){
    round(size, corner);
    //cylinder(r=radius);
    sphere(r=chamfer);
  }
}

module encasing() {
  translate([rounding, rounding, 0])
    doubleround([width-2*rounding, height-2*rounding-shell_thickness/2, thickness], rounding, shell_thickness);
}

// The Nexus 5x shape, aligned with x, y, and z axes.
module nexus_5x() {
  under_round = 20;
  hull() {
    for (x = [rounding, width-rounding]) {
      for (y = [rounding, height-rounding]) {
        translate([x, y, 0])
          intersection() {
            // The n5x sides slant in by 0.8 mm total
            cylinder(r1=rounding, r2=rounding-0.4, h=thickness-0.5);
            translate([0,0,under_round-1])
              sphere(r=under_round, $fn=50);
          }
      }
    }
  }
}

module top_slant() {
  hull() {
    for (x = [rounding, width-rounding]) {
      for (y = [rounding, height-rounding]) {
        translate([x, y, thickness-0.3])
          cylinder(r1=rounding-0.4, r2=rounding-2.4, h=2*shell_thickness);
      }
    }
  }
  hull() {
    for (x = [rounding, width-rounding]) {
      for (y = [rounding, height-rounding]) {
        translate([x, y, thickness-0.8])
          cylinder(r1=rounding-2.4, r2=rounding-0.4, h=2*shell_thickness);
      }
    }
  }
  hull() {
    for (x = [rounding, width-rounding]) {
      for (y = [rounding, height-rounding]) {
        translate([x, y, thickness-0.6])
          cylinder(r=rounding-0.4, h=0.35);
      }
    }
  }
}

module side_holes() {
  translate([width-0.1, 96.5, 9.5]) {
    hull() {
      for (x = [3, 7]) {
        for (y = [2, 12]) {
          rotate([0, 90, 0])
          translate([x,y,-0.3])
          cylinder(d1=0, d2=4, h=shell_thickness+1, $fn=15);
        }
      }
    }
  }
  translate([width-0.1, 62.5, 9.5]) {
    hull() {
      for (x = [3, 7]) {
        for (y = [2, 27]) {
          rotate([0, 90, 0])
          translate([x,y,-0.3])
          cylinder(d1=0, d2=4, h=shell_thickness+1, $fn=15);
        }
      }
    }
  }
}

module bottom_holes() {
  union() {
    // USB-C: 12.4x6.45
    translate([width/2, -1, thickness/2])
      cube([13.0, 5, 7], center=true);
    translate([59, 1, thickness/2])
      rotate([90,0,0])
        cylinder(d=7.5, h=5, $fn=20);
  }
}

module back_holes() {
  union() {
    // Camera
    translate([width/2, 126, -2*shell_thickness-0.1])
      cylinder(d1=18, d2=24, h=2*shell_thickness+0.2);
    // Fingerprint scanner
    translate([width/2, 103.3, -2*shell_thickness-0.1])
      cylinder(d1=20, d2=13, h=2*shell_thickness+0.2);
    // Flash
    translate([56, 126, -shell_thickness-0.1])
      cube([13, 11, 2*shell_thickness+0.3], center=true);
  }
}

module nexus_5x_cover() {
  difference() {
    encasing();
    nexus_5x();
    // One more to take off the front.
    top_slant();
    side_holes();
    bottom_holes();
    back_holes();
  }
  if (add_support) {
    // sound
    translate([width-0.6, 65.5, 2.5]) {
      for (i = [0,4,8,12,16,20]) {
        translate([0, i, 0])
          cube([1, 2, 3.7]);
      }
    }
    // on
    translate([width-0.6, 100.5, 2.5]) {
      for (i = [0,4]) {
        translate([0, i, 0])
          cube([1, 2, 3.7]);
      }
    }
    // power
    translate([width/2-5, -1, 1.5]) {
      for (i = [0,4, 8]) {
        translate([i, 0, 0])
          cube([2, 1, 5]);
      }
    }
    // audio
    translate([width/2+22, -1, 1.5]) {
          cube([2, 1, 5]);
    }
  }
}

