bat_width = 25.1;
bat_height = 42.1;
bat_depth = 4.1;
pcb_width_1 = 51.4;
pcb_width_2 = 44;
pcb_width_3 = 39.6;
pcb_height_1 = 13.7;
pcb_height_2 = 30.4;
pcb_height_3 = 45.4;
pcb_depth = 3.2;
usb_height = 7.5;
usb_offset_x = 2.5; // how much micro usb protrudes from pcb
usb_offset_y = 5.3; // how much micro usb is away from pcb bottom
sma_diameter = 6.2;
wall_size = 2;
hole_dist_x = 45.3;
hole_dist_y = 41.2;
hole_size = 1.6;
hole_offset_y = 1.3;
hole_offset_x = 3.8;
case_width = 56;
case_height = 49.8;
case_depth = 12.6;
but_width = 8;
but_height = 5;
but_offset_z = 3;
but_offset_y = 13;
but_dist = 8;
but_help_dia = 1.2;
but_help_height = 5;
but_help_dist = 3.0;
usb_cut_w = 8.3;
usb_cut_h = 3.3;
usb_cut_off_y = 7.5;
usb_cut_off_z = 5.5;
nub_off_y = 21;
nub_off_x = 13;
hole_dia = 1.75;
hole_outer = 4;
hole_height = 3.7;
helper_discs = 10;

module battery() {
    cube([bat_width, bat_height, bat_depth]);
}

module pcb() {
    difference() {
        union() {
            translate([pcb_width_1 - 39.6 + usb_offset_x, 0, 0])
                cube([pcb_width_3, pcb_height_3, pcb_depth]);
            
            translate([pcb_width_1 - pcb_width_2 + usb_offset_x, 0, 0])
                cube([pcb_width_2, pcb_height_2, pcb_depth]);
            
            translate([usb_offset_x, 0, 0])
                cube([pcb_width_1, pcb_height_1, pcb_depth]);
            
            translate([0, usb_offset_y, 0])
                cube([usb_offset_x, usb_height, pcb_depth]);
        }
        
        translate([usb_offset_x + hole_offset_x + (hole_size / 2), hole_offset_y + (hole_size / 2), -1])
        union() {
            cylinder(d = hole_size, h = pcb_depth + 2, $fn = 20);
            
            translate([hole_dist_x - hole_size, 0, 0])
                cylinder(d = hole_size, h = pcb_depth + 2, $fn = 20);
            
            translate([hole_dist_x - hole_size, hole_dist_y - hole_size, 0])
                cylinder(d = hole_size, h = pcb_depth + 2, $fn = 20);
        }
    }
}

module top() {
    translate([((usb_offset_x + pcb_width_1) - bat_width) / 2, 0, 0])
        battery();
    
    translate([0, 0, bat_depth])
        pcb();
}

module sma() {
    translate([0, 0, -5])
        cylinder(d = 3, h = 5, $fn = 20);
    
    cylinder(d = 9.1, h = 3.5, $fn = 6);
    
    translate([0, 0, 3.5])
        cylinder(d = sma_diameter, h = 10, $fn = 20);
    
    translate([0, 0, 3.5 + 2.5])
        cylinder(d = 9.3, h = 2.5, $fn = 20);
}

module screwholder() {
    difference() {
        cylinder(d = hole_outer, h = hole_height, $fn = 20);
        translate([0, 0, -1])
            cylinder(d = hole_dia, h = hole_height + 2, $fn = 20);
    }
}

module case() {
    difference() {
        // floor
        cube([case_width, case_height, wall_size]);
        
        translate([5.75, case_height - 5.75, -1])
            cylinder(d = hole_dia, h = wall_size + 2, $fn = 20);
        
        translate([5.75, case_height - 5.75, -1])
            cylinder(d = hole_outer, h = 1 + 1.4, $fn = 20);
    }
    
    // bottom
    translate([0, 0, wall_size])
        cube([case_width, wall_size, case_depth]);
    
    // top
    translate([0, case_height - wall_size, wall_size])
        cube([case_width, wall_size, case_depth]);
    
    difference() {
        // left
        translate([0, wall_size, wall_size])
            cube([wall_size, case_height - (2 * wall_size), case_depth]);
        
        // usb charge port
        translate([-1, usb_cut_off_y, usb_cut_off_z])
            cube([wall_size + 2, usb_cut_w, usb_cut_h]);
        
        translate([wall_size + 1, 35, wall_size + sma_diameter - 2])
            rotate([0, -90, 0])
            cylinder(d = sma_diameter, h = wall_size + 2, $fn = 20);
    }
    
    difference() {
        // right
        translate([case_width - wall_size, wall_size, wall_size])
            cube([wall_size, case_height - (2 * wall_size), case_depth]);
        
        // first (CH) button
        translate([case_width - wall_size - 1, but_offset_y, wall_size + case_depth - but_offset_z - but_height])
            cube([wall_size + 2, but_width, but_height]);
        
        // second (Pow) button
        translate([case_width - wall_size - 1, but_offset_y + but_width + but_dist, wall_size + case_depth - but_offset_z - but_height])
            cube([wall_size + 2, but_width, but_height]);
    }
    
    // button helper
    translate([case_width - wall_size - but_help_dist, but_offset_y + but_width + (but_dist / 2) - (wall_size / 2), wall_size])
        cube([but_help_dist, wall_size, but_help_height - wall_size]);
    translate([case_width - wall_size - but_help_dist + (wall_size / 2), but_offset_y + but_width + (but_dist / 2), wall_size])
        cylinder(d = wall_size, h = but_help_height, $fn = 20);
    translate([case_width - wall_size - but_help_dist, but_offset_y + (but_width / 2) - wall_size, wall_size])
        cube([wall_size / 2, wall_size * 2, wall_size / 2]);
    translate([case_width - wall_size - but_help_dist, but_offset_y + (but_width / 2) - wall_size + but_width + but_dist, wall_size])
        cube([wall_size / 2, wall_size * 2, wall_size / 2]);
    translate([nub_off_x - (wall_size / 2), nub_off_y - (wall_size / 2), wall_size])
        cylinder(d = wall_size, h = but_help_height, $fn = 20);
    
    translate([7, 4.2, wall_size])
        screwholder();
    
    translate([case_width - 5, 5, wall_size])
        screwholder();
    
    translate([case_width - 5, case_height - 5, wall_size])
        screwholder();
    
    translate([5.75, case_height - 5.75, wall_size])
        screwholder();
    
    // helper walls for screw holders
    translate([4, 0, wall_size])
        cube([wall_size + 2, 3, hole_height]);
    translate([0, 0, wall_size])
        cube([6, wall_size + 3.3, hole_height]);
    translate([3, case_height - 4.5, wall_size])
        cube([wall_size + 2, 3, hole_height]);
    translate([0, case_height - 6, wall_size])
        cube([4.5, wall_size + 3, hole_height]);
    translate([case_width - 4, 0, wall_size])
        cube([wall_size + 2, 5.5, hole_height]);
    translate([case_width - 6, 0, wall_size])
        cube([4, wall_size + 2, hole_height]);
    translate([case_width - 4, case_height - 5.5, wall_size])
        cube([wall_size + 2, 5.5, hole_height]);
    translate([case_width - 6, case_height - 4, wall_size])
        cube([4, wall_size + 2, hole_height]);
    translate([nub_off_x - wall_size, nub_off_y - wall_size, wall_size])
        cube([wall_size, case_height - nub_off_y, hole_height]);
    translate([wall_size, nub_off_y - wall_size, wall_size])
        cube([nub_off_x - wall_size, wall_size, hole_height]);
        
    cylinder(d = helper_discs, h = 0.2, $fn = 15);
    translate([case_width, 0, 0])
        cylinder(d = helper_discs, h = 0.2, $fn = 15);
    translate([case_width, case_height, 0])
        cylinder(d = helper_discs, h = 0.2, $fn = 15);
    translate([0, case_height, 0])
        cylinder(d = helper_discs, h = 0.2, $fn = 15);
}

case();

%translate([0, wall_size, wall_size - 0.4])
    top();

%translate([5.5, 35, wall_size + sma_diameter - 2])
    rotate([0, -90, 0])
    sma();
