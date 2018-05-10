big_number = 100;

holder_radius = 46;
holder_thickness = 3;
holder_height = 30;
tube_bottom_thickness = 1;
pen_count = 16;
pen_radius = 4.5;
pen_length = 150;
rotx = 30;
roty = 0;
rotz = -60;


{ // pen model
    for (a=[1:360/pen_count:360]) {
        rotate([0,0,a])
        translate([holder_radius,0,0])
        rotate([rotx,roty,rotz])
        %cylinder(h=pen_length, r = pen_radius);
    }
}



difference () {
    { // material part of tubes
        for (a=[1:360/pen_count:360]) {
            rotate([0,0,a])
            translate([holder_radius,0,0])
            rotate([rotx,roty,rotz])
            translate([0,0,-big_number*0.5])
            cylinder(h=big_number*2, r = pen_radius + holder_thickness);
        }
    }
    { // hole part of tubes
        difference() {
            {
                for (a=[1:360/pen_count:360])
                    rotate([0,0,a])
                    translate([holder_radius,0,0])
                    rotate([rotx,roty,rotz])
                    translate([0,0,-big_number*0.5])                
                    cylinder(h=big_number*2, r = pen_radius);
                    
            }
        cylinder(h=tube_bottom_thickness, r=holder_radius*2);
        }
    }
    //cut out the bottom
    translate([0,0,-big_number*2])
    cylinder(h=big_number*2, r = holder_radius*8);
    //cut out the top
    translate([0,0,holder_height])
    cylinder(h=big_number*4, r = holder_radius*8);
}
