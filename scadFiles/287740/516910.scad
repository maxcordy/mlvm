/**
 * (c) Spiros Papadimitriou, 2014
 *
 * This design is made available under a
 * Creative Commons Attribution Share-Alike license.
 * http://creativecommons.org/licenses/by-sa/3.0/
 * You can share and remix this work, provided that
 * you keep the attribution to the original author intact,
 * and that, f you alter, transform, or build upon
 * this work, you may distribute the resulting work
 * only under the same or similar license to this one.
 */

part = "all";  // [all:All, box:Mitre box, base:Base]

// Beam width
width = 15;
// Beam depth
depth = 15;

// Box length
length = 120;
// Blade guide angle (may also want to adjust length, so clamps don't get in way)
cutting_angle = 0;
// Box wall thickness (sides and bottom)  
thickness = 4.5;

// Box channel slack (width only)
width_slack = 0.2;

// Height of box = beam depth + extra height (should be enough to guide blade in the beginning)
extra_height = 5;  
// Width of clamp notches
clamp_width = 28;

// Brim width also determines length of blade slots
brim_width = 5;  

// Diameter of screws for pegs; set to zero for no holes
screw_diameter = 3.1;  
screw_cap_diameter = 6;
// Make sure it does not exceed thickness, or blade will hit caps
screw_cap_height = 3.2;  

// Thickness of glue-on base piece, to elevate protruding cap screw heads
base_thickness = 5.7;  

// Additional clamping option, using extrusion slots
holes = 1;  // [1:Yes, 0:No]

/* [Advanced] */

blade_width_inches = 0.025;
// Blade slot width is (1+slack_factor) * blade_width; 0.9 should work well for standard 0.025" hacksaw blades
blade_width_slack_factor = 0.9;

// Screw size for slot clamping holes
beam_screw_diameter = 3.2;

// Zero will make peg holes *exactly* tangent to blade slot sides; do not adjust, unless you have issues printing/slicing
screw_peg_slack = 0.03;

/* [Hidden] */

w = width;
d = depth;

slack = width_slack;  // For OB channel, width only

blade_w_in = blade_width_inches;
blade_w_slack_factor = blade_width_slack_factor;  // 0.6 was way too tight
blade_w = 25.4*(1+blade_w_slack_factor)*blade_w_in;
clamp_w = clamp_width;
clamp_d = 2;  // top notch
extra_h = extra_height;

notch_d = 1;
brim_w = brim_width;

thk = thickness;

angle = cutting_angle;

l = length; //100 + w*tan(angle);

peg_r = screw_diameter/2;  // M3 -- 45mm partially threaded works
peg_cap_r = screw_cap_diameter/2;
peg_cap_h = screw_cap_height;
peg_slack = screw_peg_slack;

layer_h = 0.3;  // For hole support

ob_screw_r = beam_screw_diameter/2;


total_h = d + thk + extra_h;

/*************************************************
 * From lib/util.scad (copy-paste for Customizer)
 *************************************************/

module roundedCube4(dim, r, center=false) {
  width = dim[0];
  height = dim[1];
  depth = dim[2];
  centerx = (center[0] == undef ? center : center[0]);
  centery = (center[1] == undef ? center : center[1]);
  centerz = (center[2] == undef ? center : center[2]);
  translate([centerx ? -width/2 : 0, centery ? -height/2 : 0, centerz ? -depth/2 : 0]) union() {
    translate([0, r, 0]) cube([width, height-2*r, depth]);
    translate([r, 0, 0]) cube([width-2*r, height, depth]);
    for (xy = [[r, r],
               [r, height-r],
               [width-r, r],
               [width-r, height-r]]) {
      translate([xy[0], xy[1], 0]) cylinder(r = r, h = depth);
    }
  }
}

// TODO FIXME: dim[2] is not obeyed and top is filleted when dim[2] is >r but <2*r, because corner sphere diameter exceeds height  (should be a half-sphere, in principle)
module roundedCube6(dim, r, center=false) {
  width = dim[0];
  height = dim[1];
  depth = dim[2];
  centerx = (center[0] == undef ? center : center[0]);
  centery = (center[1] == undef ? center : center[1]);
  centerz = (center[2] == undef ? center : center[2]);
  translate([r - (centerx ? width/2 : 0), r - (centery ? height/2 : 0), r - (centerz ? depth/2 : 0)]) hull() {
    // Edges
    translate([0, 0, 0]) rotate([-90, 0, 0]) cylinder(h = height-2*r,r = r);
    translate([width-2*r, 0, 0]) rotate([-90, 0, 0]) cylinder(h = height-2*r,r = r);
    translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(h = width-2*r, r = r);
    translate([0, height-2*r, 0]) rotate([0, 90, 0]) cylinder(h = width-2*r, r = r);
    translate([0, 0, 0]) cylinder(h = depth-r, r = r);
    translate([width-2*r, 0, 0]) cylinder(h = depth-r, r = r);
    translate([0, height-2*r, 0]) cylinder(h = depth-r, r = r);
    translate([width-2*r, height-2*r, 0]) cylinder(h = depth-r, r = r);

    // Corners
    translate([0,0,0]) sphere(r);
    translate([width-2*r, 0, 0]) sphere(r);
    translate([0, height-2*r, 0]) sphere(r);
    translate([width-2*r, height-2*r, 0]) sphere(r);
  }
}

module fillet(h, r) {
  difference() {
     cube([h, r, r]);
     translate([-0.1, r, r]) rotate([0, 90, 0]) cylinder(h = h+.2, r = r);
  }
}

/*************************************************
 * (end Customizer copy-paste)
 *************************************************/


module peg_hole_placement() {
  yofs = (w+thk+brim_w)/2;  // Unrotated
  xofs = (blade_w/2+peg_r-peg_slack);  // Unrotated
  for (sy = [-1,+1], sx = [-1,+1]) 
    translate([sx*xofs/cos(angle)-sy*yofs*tan(angle), sy*yofs, 0]) {
      child(0);
    }
}

module mitre_box() {
  difference() {
    union() {
      // Main volume
      translate([-l/2, -w/2-thk-slack, -thk]) cube([l, w + 2*thk + 2*slack, total_h]);
      // Brim and extended blade guide
      if (brim_w > 0) {
        translate([-l/2, -w/2-thk-brim_w, -thk]) cube([l, w + 2*thk + 2*brim_w, thk]);
        for (s=[-1,+1]) translate([-l/2, s*(w/2+thk+slack), 0]) mirror([0, (1-s)/2, 0]) fillet(l, r=1.5, $fn=18);
        for (s=[-1,+1]) translate([-w/2 - s*tan(angle)*(w+thk+brim_w)/2, -(1-s)*(thk+brim_w-slack)/2 + s*(w/2+slack), -thk]) {
          roundedCube6([w, thk+brim_w-slack, total_h], r=1.5, $fn=18);
          for (sf = [-1,+1]) translate([w/2 + sf*(w/2-0.01), brim_w-slack+0.01, 0]) rotate([0, -90, 90 + (1+sf)*45]) fillet(h=total_h, r=1.5, $fn=18);
        }
      }
    }
    // Beam channel cutout
    translate([-l/2-5, -w/2-slack, 0]) roundedCube6([l+10, w+2*slack, d+extra_h+1], r=0.75, $fn=9);

    // Peg holes
    if (peg_r > 0) {
      translate([0, 0, -thk-1]) peg_hole_placement() union() {
        cylinder(r = peg_r, h = total_h + 2, $fn=24);
        cylinder(r = peg_cap_r, h = peg_cap_h + 1, $fn = 24);
      }
    }

    // Blade slot
    translate([-0*l/10, 0, 0]) rotate([0, 0, angle]) translate([-blade_w/2 , -(w+brim_w+thk)/cos(angle), -notch_d]) cube([blade_w, 2*(w+brim_w+thk)/cos(angle), d+extra_h+notch_d+1]);

    // Clamp indentations
    for (s = [-1,+1]) translate([s*(l/2-clamp_w/2-6)-clamp_w/2, -w-5, d-clamp_d]) roundedCube6([clamp_w, 2*w+10, clamp_d+extra_h+5], r=1, $fn=12);

    // Screw clamping holes
    if (holes) {
      for (s = [-1,+1]) translate([s*(l/2-clamp_w/2-6), w/2+slack+thk, d/2]) rotate([90, 0, 0]) cylinder(r=ob_screw_r, h = w+2*slack+2*thk+2, $fn=18);
    }
  }
  // Hole support
  if (peg_r > 0) {
    translate([0, 0, -thk + peg_cap_h]) peg_hole_placement() cylinder(r = peg_cap_r+.1, h=layer_h);
  }

} // module mitre_box

base_thk = base_thickness;

module mitre_base() {
  difference() {
    translate([-l/2, -w/2-thk-brim_w, 0]) cube([l, w + 2*thk + 2*brim_w, base_thk]);
    for (s=[-1,+1]) translate([-w/2 - s*tan(angle)*(w+thk+brim_w)/2, -(1-s)*(2*thk+brim_w-slack)/2 + s*(w/2+slack), -1]) roundedCube4([w, 2*thk+brim_w-slack, base_thk+2], r=1.5, $fn=18);
    for (s=[-1,+1]) translate([-(l-6*thk-w)/4 + s*(l-6*thk-w)/4 + 3*s*thk, -w/2, -1]) roundedCube4([(l-6*thk-w)/2, w, base_thk+2], r=1.5, $fn=12);
  }
}


if (part == "box" || part == "all") {
  mitre_box();
}
if (part == "base" || part == "all") {
  translate([0, 0, -thk-base_thk]) mitre_base();
}
if (part == "all") {
  translate([-l/2-10, -w/2, 0]) %cube([l+20, w, d]);
}