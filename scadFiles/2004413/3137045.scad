// Quality
$fn = 128; // [6:256]

// Overlap to avoid zero thickness surfaces/walls - see https://www.makerbot.com/media-center/2011/02/02/openscad-intermediates-combining-forms
O = 0.001;
// Debug with:
//O = 0.001 + $t/4;

// Wall thickness
wall = 1.2; // [0.6, 0.8, 1.0, 1.2, 1.4, 1.6, 1.8, 2.0, 2.2]

// Distance to allow fitting objects
dxyz = 0.2; // [0.1, 0.15, 0.2, 0.25, 0.3]

// Battery model selection, see bat_* for other sizes
bat = [11.60,  5.50, 11.30,  4.70,  8.50,  1.00, "AG13", "LR44"];

// Select part to print
part = 3; // [0:Design view only, 1:Bottom, 2:Top, 3:All]

// Rows to print, 1 is possible but pointless
rows = 4;  // [2:2 rows for 3 batteries, 3:3 rows for 6 batteries, 4:4 rows for 10 batteries, 5:5 rows for 15 batteries, 6:6 rows for 15 batteries, 7:7 rows for 28 batteries]

// D = diameter at the base, D1 = diameter near the top before curving, D2 = Diameter of the pos
//           [0=D,    1=H,   2=D1,  3=H1,  4=D2, 5=crnd, 6=Name, 7=Name2];
bat_CR2025 = [20.00,  2.80, 19.50,  3.00,  18.00,  0.40, "CR2025", ""];
bat_CR2023 = [20.00,  3.40, 19.50,  3.00,  18.00,  0.40, "CR2023", ""];
bat_AG13   = [11.60,  5.50, 11.30,  4.70,  8.50,  1.00, "AG13", "LR44"];
bat_AG10   = [11.60,  3.10, 11.40,  2.60,  9.30,  0.30, "AG10", "LR54"];
bat_LR932  = [ 9.50,  3.20,  9.30,  2.75,  8.00,  0.30, "LR932", ""];

use <UbuntuMono-B.ttf>; // ubuntu-font-family-0.83
// Font for the labels, Ex: "Source Code Pro:style=Bold"
font = "Ubuntu Mono:style=Bold";
//font = "Source Code Pro:style=Bold";

// Adjust font size on the top part, 1.4 for 2 rows (3 cells), 1.8 for 3+ is good
font_size_k = 1.8;

if (part == 0) {
    design(bat);
} else if (part == 1) {
    print_bottom(bat);
} else if (part == 2) {
    print_top(bat);
} else {
    %design(bat);
    print_bottom(bat);
    print_top(bat);
}

module button_batery_model(bat, font, O=0.001) {
    bat_d  = bat[0];
    bat_h  = bat[1];
    bat_d1 = bat[2];
    bat_h1 = bat[3];
    bat_d2 = bat[4];
    crnd   = bat[5];
    difference() {
        union() { // Positive terminal, main cylinder
            cylinder(d1=bat_d, d2=bat_d1, h=bat_h1-crnd+O);
            translate([0, 0, bat_h1-crnd]) {
                difference() { // Chamfered edge
                    rotate_extrude(convexity = 4)
                        translate([bat_d1/2-crnd, 0, 0])
                            circle(r=crnd+O);
                    translate([0, 0, -crnd-O])
                        rotate_extrude(convexity = 4)
                            translate([bat_d1/2-2*crnd-2*O, 0, 0])
                                square([crnd+O, 2*(crnd+2*O)]);
                }
            }
            union() { // Negative terminal
                translate([0, 0, bat_h1-crnd-O])
                    cylinder(d=bat_d2, h=bat_h-bat_h1+O);
                translate([0, 0, bat_h-crnd-O])
                    cylinder(d=bat_d2-2*crnd, h=crnd+O);
                translate([0, 0, bat_h-crnd])
                    rotate_extrude(convexity = 4)
                        translate([bat_d2/2-crnd, 0, 0])
                            circle(r=crnd+O);
            }
        }
        // Labels
        translate([0, 0, -O])
            linear_extrude(height=.1+O)
                text(text="+", font=font, size=bat_d/2, halign="center", valign="center");
    }
}


// Design view
module design(bat) {
    $fn = 16;
    bat_d = bat[0];
    bat_h = bat[1];
    d = bat_d + 2*(wall + dxyz);
    h = bat_h + 2*(dxyz + wall);
    translate([d*(rows+1), 0, 0]) {
        difference() {
            union() {
                translate([0, 0, 0])
                    bottom(bat);
                translate([0, 0, 0])
                    top(bat);
                translate([0, 0, wall+dxyz])
                    %bat_pos_model(bat, wall, dxyz, rows);
            }
            // Cut right half
            translate([(rows-1)*d/2, -d, -h/2]) cube([d*rows+d, d*rows+d, 2*h]);
            // Cut the rear leaving just 1/2 batteries on the front
            //translate([-d, 0, -h/2]) cube([d*rows+d, d*rows+d, 2*h]);
            // Cut 1/2 battery from the front
            //translate([-d, -d*rows-d, -h/2]) cube([d*rows+d, d*rows+d, 2*h]);
        }
    }
}

// Show the batteries positioning model
module bat_pos_model(bat, wall, dxyz, rows = 4) {
    bat_d = bat[0];
    d = bat_d + 2*wall + 2*dxyz;
    for (row = [0:1:rows - 1]) {
        dx = row*d/2;
        for (x = [0:1:rows-1-row]) {
            translate([d*x+dx, d*sin(60)*row, 0]) {
                button_batery_model(bat=bat, font=font);
//                %difference() {
//                    cylinder(d=bat_d+2*dxyz+2*wall, h=2);
//                    translate([0, 0, -.5])
//                    cylinder(d=bat_d+2*dxyz, h=3);
//                }
            }
        }
    }
}

// Print top part
module print_top(bat) {
    bat_d = bat[0];
    bat_h = bat[1];
    translate([0, 0, 2*wall + 2*dxyz + bat_h]) rotate([0, 180, 0]) top(bat);
}

// Print bottom part
module print_bottom(bat) {
    bat_d = bat[0];
    d = bat_d + 2*wall + 2*dxyz;
    translate([d*rows, d*rows, 0]) rotate([0, 0, 180]) bottom(bat);
}

// Outide space
module bat_box_out(bat=bat, wall_xtra=0) {
    bat_d = bat[0];
    bat_h = bat[1];
    d = bat_d + 2*(wall + dxyz);
    union() {
        for (row = [0:1:rows - 1]) {
            dx = row*d/2;
            for (x = [0:1:rows-1-row]) {
                dz = ((rows-row+x) % 3 - 1)*O; // avoid zero thickness walls!
                // echo(row=row, x=x, dz=dz);
                translate([d*x+dx, d*sin(60)*row, dz])
                        cylinder(d=d + 2*wall_xtra,
                                 h=bat_h+wall+dxyz+O);
            }
        }
        // TODO: Instead of hiding the openings use them to fitx the lid?
        polyhedron(
            points=[
                [0, 0, -3*O], // Left bottom
                [0, 0, bat_h+wall+dxyz+3*O], // Left top
                [(rows-1)*d, 0, -3*O],  // Right bottom
                [(rows-1)*d, 0, bat_h+wall+dxyz+3*O], // Right top
                [(rows-1)*d/2, (rows-1)*d*sin(60), -3*O], // Rear bottom
                [(rows-1)*d/2, (rows-1)*d*sin(60), bat_h+wall+dxyz+3*O], // Rear top
            ],
            faces=[
                [0,1,2], [1,3,2], // Front wall
                [2,3,4], [3,5,4], // Right wall
                [4,5,0], [5,1,0], // Left wall
                [0,2,4], // Bottom
                [1,5,3], // Top
            ],
            convexity=2
        );
    }
}

// Inside space
module bat_box_in(bat) {
    bat_d = bat[0];
    bat_h = bat[1];
    d = bat_d + 2*(wall + dxyz);
    for (row = [0:1:rows - 1]) {
        dx = row*d/2;
        for (x = [0:1:rows-1-row]) {
            dz = ((rows-row+x) % 3 - 1)*O; // avoid zero thickness walls!
            translate([d*x+dx, d*sin(60)*row, wall+dz])
                    cylinder(d=bat_d+2*dxyz, h=bat_h+dxyz+5*O);
        }
    }
}

// Bottom piece
module bottom(bat) {
    bat_d = bat[0];
    bat_h = bat[1];
    text_1 = bat[6];
    text_2 = bat[7];
    d = bat_d + 2*(wall + dxyz);
    difference() {
        union() {
            bat_box_out(bat, wall_xtra=0);
            translate([0, -d/2-O, -4*O])
                cube([(rows-1)*d, d/2+2*O, wall+8*O]);
            rotate([0, 0, 60])
                translate([0, O, -4*O])
                    cube([(rows-1)*d, d/2+2*O, wall+8*O]);
            rotate([0, 0, -60])
                translate([-(rows-1)*d/2, (rows-1)*d*sin(60), -4*O])
                    cube([(rows-1)*d, d/2+2*O, wall+8*O]);
        }
        bat_box_in(bat);
        // Label
        translate([(rows-1)*d/2, wall+bat_d/8*(rows-2), 0.4])
            rotate([0, 180, 0])
                linear_extrude(height=wall+O)
                    text(text=text_1, font=font, size=bat_d/2*font_size_k*(rows+1)/5, halign="center", valign="center");
        translate([(rows-1)*d/2, (rows-1)*d/2*sin(60), 0.4])
            rotate([0, 180, 0])
                linear_extrude(height=wall+O)
                    text(text=text_2, font=font, size=bat_d/2*font_size_k*(rows+1)/5, halign="center", valign="center");
    }
}

// Top piece
module top(bat) {
    bat_d = bat[0];
    bat_h = bat[1];
    text_1 = bat[6];
    text_2 = bat[7];
    d = bat_d + 2*(wall + dxyz);
    difference() {
        translate([0, 0, wall+dxyz]) {
            bat_box_out(bat, wall_xtra=wall+dxyz);
            translate([0, -d/2-wall-dxyz-O, bat_h+dxyz+4*O])
                cube([(rows-1)*d, d/2+wall+dxyz+2*O, wall+8*O]);
            rotate([0, 0, 60])
                translate([0, wall+dxyz+O, bat_h+dxyz+4*O])
                    cube([(rows-1)*d, d/2+2*O, wall+8*O]);
            rotate([0, 0, -60])
                translate([-(rows-1)*d/2, wall+dxyz+(rows-1)*d*sin(60), bat_h+dxyz+4*O])
                    cube([(rows-1)*d, d/2+2*O, wall+8*O]);
        }
        translate([0, 0, dxyz])
            bat_box_out(bat, wall_xtra=dxyz);
        // Label
        translate([(rows-1)*d/2, wall+bat_d/8*(rows-2), bat_h+2*wall+2*dxyz-.4])
            linear_extrude(height=wall+O)
                text(text=text_1, font=font, size=bat_d/2*font_size_k*(rows+1)/5, halign="center", valign="center");
        translate([(rows-1)*d/2, (rows-1)*d/2*sin(60), bat_h+2*wall+2*dxyz-.4])
            linear_extrude(height=wall+O)
                text(text=text_2, font=font, size=bat_d/2*font_size_k*(rows+1)/5, halign="center", valign="center");
    }
}
