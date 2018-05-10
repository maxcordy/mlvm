// What is the length of the cylindrical object being stored OR what is the width you want the dispenser of little thingies to be (mm)?
obj_len = 44.5;

// What is the diameter of each cylindrical object OR what is the size of the little thingies (mm)?
obj_dia = 10.5;

// How many cylinders/thingies tall should the hopper be? The hopper can hold about depth*height cylinders.
hopper_height = 3; // [2:50]

// How many cylinders/thingies deep should the hopper be?
hopper_depth = 1; // [1:15]

// How many cylinders/thingies deep should the tray be?
num_tray = 1; // [1:15]

// How much extra margin do you want around the cylinders/thingies in the Y/Z axes? 
obj_dia_margin_percentage = 30; // [0:100]
obj_dia_margin = obj_dia_margin_percentage/100;

// How much extra margin do you want around the cylinders/thingies in the X axis? 
obj_len_margin_percentage = 10; // [0:100]
obj_len_margin = obj_len_margin_percentage/100;

// Thickness of the walls, increase for more strength but requiring more material (mm). 
wall_thickness = 1.2;

// What percentage of the hopper front should be open? Set to zero if storing little thingies instead of cylinders.
hopper_gap_percentage = 40; // [0:100]
hopper_gap_fraction = hopper_gap_percentage/100;

dip_type = "front_square+bottom_round"; // [front_round,front_square,front_square+bottom_round]

// What percentage of the tray front should have a rounded gap cut out of it? Set to zero if storing little thingies instead of cylinders.
dip_gap_percentage = 70; // [0:100]
dip_gap_fraction = dip_gap_percentage/100;

// dimensions of the empty space (not including walls)
space_w        = obj_len*(1             + obj_len_margin);
space_d_hopper = obj_dia*(hopper_depth  + obj_dia_margin);
space_d_tray   = obj_dia*(num_tray      + obj_dia_margin + 0.5);
space_h_hopper = obj_dia*(hopper_height + obj_dia_margin);
space_h_tray   = obj_dia*(1             + obj_dia_margin);

// make the tray
tray([space_w,space_d_tray,space_h_tray],wall_thickness,dip_gap_fraction);

// make the hopper
translate([0,space_d_tray,0]) hopper([space_w,space_d_hopper,space_h_hopper],wall_thickness,hopper_gap_fraction,space_h_tray);

// render virtual tray cylinders for display purposes
for (i = [0:num_tray-1]) {
    %translate([obj_len*obj_len_margin/2,(obj_dia+obj_dia_margin)*(0.5+i+0.25),(obj_dia+obj_dia_margin)/2]) 
        rotate([0,90,0]) 
        cylinder(d=obj_dia,h=obj_len);
}

// render virtual hopper cylinders for display purposes
translate([0,space_d_tray,0]) {
    for (i = [0:hopper_height-1], j = [0:hopper_depth-1]) {
        %translate([obj_len*obj_len_margin/2,(obj_dia+obj_dia_margin)*(0.5+j),(obj_dia+obj_dia_margin)*(0.5+i)]) 
            rotate([0,90,0]) 
            cylinder(d=obj_dia,h=obj_len);
    }
}




module tray(size,wall_thickness,dip_gap_fraction) {
    difference() {
        translate([-1,-1,-1]*wall_thickness) 
            cube(size + [2,2,2]*wall_thickness);
        cube(size + [0,wall_thickness*2,wall_thickness*2]);
        if (dip_gap_fraction) {
            if (dip_type=="front_round") {
                translate([size[0]/2,wall_thickness/2,size[2]]) 
                    rotate([90,0,0]) 
                    resize([size[0]*dip_gap_fraction, size[2]*2, wall_thickness*2]) 
                    cylinder(h=10,d=10);
                translate([size[0]*(1-dip_gap_fraction)/2,-1.5*wall_thickness,size[2]]) 
                    cube([size[0]*dip_gap_fraction,wall_thickness*2,wall_thickness*2]);
            } else if (dip_type=="front_square") {
                translate([size[0]*(1-dip_gap_fraction)/2,-1.5*wall_thickness,0]) 
                    cube([size[0]*dip_gap_fraction,wall_thickness*2,(size[2])+wall_thickness*2]);
            } else if (dip_type=="front_square+bottom_round") {
                translate([size[0]*(1-dip_gap_fraction)/2,-1.5*wall_thickness,0]) 
                    cube([size[0]*dip_gap_fraction,wall_thickness*2,(size[2])+wall_thickness*2]);
                translate([size[0]/2,-wall_thickness,-wall_thickness*1.5]) 
                    resize([size[0]*dip_gap_fraction, size[2]*2, wall_thickness*2]) 
                    cylinder(h=10,d=10);
            }
        }
    }
}

module hopper(size,wall_thickness,hopper_gap_fraction,tray_gap) {
    difference() {
        translate([-1,-1,-1]*wall_thickness) 
            cube(size + [2,2,2]*wall_thickness);
        cube(size + [0,0,wall_thickness*2]); // main cavity plus open top
        translate([0,-wall_thickness*2,0]) 
            cube([size[0], size[1]+wall_thickness*2,tray_gap]); // bottom slot
        translate([size[0]*(1-hopper_gap_fraction)/2,-wall_thickness*2,0]) 
            cube(
                [size[0]*hopper_gap_fraction,size[1],size[2]] + 
                [0,wall_thickness*2,wall_thickness*2]
            ); // gap in the middle
    }
    // curved back bottom edge
    difference() {
        translate([0,size[1]-tray_gap/2,0]) cube([size[0],tray_gap/2,tray_gap/2]); // cube filling the back region
        translate([0,size[1]-tray_gap/2,tray_gap/2]) rotate([0,90,0]) cylinder(d=tray_gap,h=size[0]); // neg. cylinder carving the curve out
    }
        
}