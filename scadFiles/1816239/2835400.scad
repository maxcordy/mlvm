/******************************************************************************
**  BDSM COLLAR TAG GENERATOR version 1.0.0 (2016-10-09)                     **
**  Copyright (c) Michal A. Valášek - Altairis, 2016                         **
******************************************************************************/ 

/* [Text] */
// (optional)
text_string = "SLAVE";
// (try 2-6, decimals allowed)
text_size = 5;
// (in OpenSCAD format; do not modify unless you know exactly what you are doing)
text_font = "Arial:style=Bold";
// (ISO  code  such as en, de, it, fr, es...; may help with non-standard characters)
text_language = "cs";

/* [Appaerance] */
// (mm)
total_diameter = 30;
// (mm; also determines diameter of the holes)
line_width = 2;

/* [Print Settings] */
number_of_text_layers = 2; 
number_of_base_layers = 5;
// (mm)
first_layer_height = 0.15;
// (mm) 
normal_layer_height = 0.2; 

/* [Hidden] */
base_height = (number_of_base_layers - 1) * normal_layer_height + first_layer_height;   // base plate height in mm
extrude_height = normal_layer_height * number_of_text_layers;                           // motif extrusion height

// Assemble the tag together
union(){
    difference() {
        // Substrate and triskelion
        rotate(50) {
            substrate();
            translate([0, 0, base_height]) triskelion();
        }
        // Hanging hole
        translate([0, total_diameter / 2 - line_width * 2, 0]) cylinder(d = line_width * 2, h = base_height + 1, $fn = 16);
    }

    // Add text if not empty
    if(text_size > 0 && text_string != "") {
        translate([0, 0, base_height]) linear_extrude(extrude_height * 2) text(text = text_string, size = text_size, font = text_font, halign="center", valign = "top", language = text_language);
    }
}

// Tag base with holes
module substrate() {
    difference() {
        cylinder(d = total_diameter, h = base_height, $fn = 64);
        translate(rvect(0, total_diameter / 4)) cylinder(d = line_width * 1.5, h = base_height + 1, $fn = 16);
        translate(rvect(120, total_diameter / 4)) cylinder(d = line_width * 1.5, h = base_height + 1, $fn = 16);
        translate(rvect(240, total_diameter / 4)) cylinder(d = line_width * 1.5, h = base_height + 1, $fn = 16);
    }
}

// The triskelion wheel
module triskelion() {
    linear_extrude(extrude_height){
        difference() {
            circle(d = total_diameter, $fn = 64);
            circle(d = total_diameter - 2 * line_width, $fn = 64);
        }
        circle(line_width, $fn = 32);
        arm(0);
        arm(120);
        arm(240);
    }
}

// Single arc arm
module arm(a) {
    translate(rvect(a, total_diameter / 4))
    rotate(a)
    difference() {
        circle(d = total_diameter / 2, $fn = 32);
        circle(d = total_diameter / 2 - 2 * line_width, $fn = 32);
        translate([0, -total_diameter / 4]) square([total_diameter / 2, total_diameter / 2]);
    }
}

// Function to compute vector for translate, given angle and size
function rvect(a, d) = [sin(360 - a) * d, cos(360 - a) * d];