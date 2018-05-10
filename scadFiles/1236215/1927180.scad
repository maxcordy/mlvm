
// Written by Luc Belliveau
// Creative Commons - Attribution license.

// Needed to add text to the cup adapter.
// Source: http://www.thingiverse.com/thing:16193
// By Harlan Martin.
use <Writescad/Write.scad>

// Text you want on your cup, or false for no text.
cup_text = "Tea";

// Diameter of your existing cup holder.
holder_diameter = 75;

// Diameter you need for larger cups.
expanded_diameter = 103.5;

// How deep your existing cup holder is.
base_height = 53;

// How thick to make the walls of the adapter.
wall_thickness = 3;

// Should we include a slit for a cup handle?
include_cup_handle_slit = true;

// How wide should the slit be ?
slit_width = 18;

// How far from the expanded base should the slit be?
slit_distance_from_base = 0;

// How tall should the transition from small cup to large cup be?  (This creates a slope most 3D printers can manage without supports, set to *wall_thickness* for a flat base, but it may not print without supports).
shim_height = 10;

// *******************************************************************

translate([0,0,0])
difference() {
    cylinder(d1=holder_diameter*0.9,d2=holder_diameter,h=base_height );
    translate([0, 0, wall_thickness])
    cylinder(d1=(holder_diameter*0.9)-(wall_thickness*2),d2=holder_diameter-(wall_thickness*2),h=base_height-wall_thickness+1 );
}

translate([0, 0, base_height])
difference() {
    cylinder(d1=holder_diameter,d2=expanded_diameter,h=shim_height );
    translate([0, 0, -1])
    cylinder(d1=holder_diameter-(wall_thickness*3)-1,d2=expanded_diameter-wall_thickness,h=shim_height+2);
}

translate([0, 0, base_height+shim_height])
difference() {
    cylinder(d1=expanded_diameter,d2=expanded_diameter,h=base_height-shim_height );
    translate([0, 0, -1])
    cylinder(d1=expanded_diameter-(wall_thickness*2),d2=expanded_diameter-(wall_thickness*2),h=base_height+1);
    
    if (include_cup_handle_slit == true) {
        translate([(expanded_diameter/2)-slit_width-slit_width/2+(wall_thickness/2), (expanded_diameter/2)-slit_width-slit_width/2+(wall_thickness/2), slit_distance_from_base])
        cube([slit_width,slit_width,base_height]);
    }
}

if (cup_text != false) {
    translate([0, 0, base_height+shim_height+(base_height-shim_height)/2])
    color([0,1,1])
    writecylinder(text=cup_text, where=[0,0,0], radius=expanded_diameter/2, font="Letters.dxf", h=(base_height-shim_height)/2, west=45, t=3);
}


