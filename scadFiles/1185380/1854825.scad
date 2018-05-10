// Customizable Crate
// by Kevin McCormack

// The length of the inside of the box in mm
inside_length = 100; 
// The width of the inside of the box in mm
inside_width = 100; 
// Height of the box in mm
height = 50; 
outside_length = inside_length + 6;
outside_width = inside_width + 6;


module boxBase() {
    difference() {
        translate([0,0,height/2]) cube([outside_length,outside_width,height],center=true);
        translate([0,0,(height/2)+4]) cube([inside_length,inside_width,height],center=true);
        
    }
}

module yCuttout() {
    for (z=[10:10:height-10]) {
        for (x=[0:10:inside_length-10]) {
            translate([x-(inside_length/2)+5,0,z]) rotate([90,0,0]) cylinder(h=outside_width+5,d=6,center=true);
        }
    }
}

module bottomCuttout() {
    for (y=[10:10:inside_width-10]) {
        for (x=[0:10:inside_length-10]) {
            translate([x-(inside_length/2)+5,y-(inside_width/2),0]) cylinder(h=10,d=6,center=true);
        }
    }    
}

module sideCuttout() {
    for (z=[10:10:height-10]) {
        for (y=[0:10:inside_width-10]) {
            translate([0,y-(inside_width/2)+5,z]) rotate([0,90,0]) cylinder(h=outside_length+5,d=6,center=true);
        }
    }
}

difference() {
    boxBase();
    yCuttout();
    bottomCuttout();
    sideCuttout();
}