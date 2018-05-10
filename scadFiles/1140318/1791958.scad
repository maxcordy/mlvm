// The height of the overhanging lip
lid_height = 5;
// The diameter of the inside of the lid in millimeters
lid_inside_diameter = 75;
// The diameter of the entire lid in millimeters
lid_outside_diameter = lid_inside_diameter + 4;
// The text for the first line of the label
label_text_line1 = "Dog";
// The text for the second line of the label
label_text_line2 = "Food";
// The size of the label text scaling
label_size = 1.8;

module label(the_text) {
    scale([label_size,label_size,1]) linear_extrude(height=1) text(the_text, halign="center", valign="center");
}

module lid() {
    translate([0,0,lid_height / 2]) {
        difference() {
            cylinder(h=lid_height, d=lid_outside_diameter, center=true);
            translate([0,0,2]) {cylinder(h=lid_height, d=lid_inside_diameter, center=true);}
        }
    }
}

difference() {
    lid();
    translate([0,lid_inside_diameter * 0.15,0]) mirror(0,0,180) label(label_text_line1);
    translate([0,lid_inside_diameter * -0.15,0]) mirror(0,0,180) label(label_text_line2);
}