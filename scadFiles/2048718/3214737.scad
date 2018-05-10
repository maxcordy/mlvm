led_width = 17;
led_length = 145;

%translate([1,6,0]) cube([led_width,led_length,4]);

total_width = led_width + 2; //2x 1mm walls
total_length = led_length + 2 + 5; //2x 1mm walls + 5mm for wires
mounting_offset = (total_width - led_width/2) / 2;
difference() {

    union() {
        difference() {
            //main body
            cube([total_width,total_length,6]);
    
            //hole for cob
            translate([1,1,-1]) cube([led_width,led_length+5,5]);
        }

        translate([mounting_offset,0,6]) cube([led_width/2,8,12]);
        translate([mounting_offset,-8,10]) cube([led_width/2,8,8]);
        translate([mounting_offset,-16,0]) cube([led_width/2,8,18]);       
        
        hull() {
            translate([mounting_offset,8,6]) cube([led_width/2,1,12]);
            translate([mounting_offset,total_length-1,6]) cube([led_width/2,1,0.1]);
        }
        
        hull() {
            translate([0,0,0]) cube([total_width,1,6]);
            translate([0,5,4]) cube([total_width,1,2]);
        }
        
        
    }
    //hole for wire
    translate([total_width/2,3,-1]) cylinder(r=2, h=20, $fs=0.1);
}