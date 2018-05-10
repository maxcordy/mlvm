// Extrusion Sleving Clips
// Design by Marius Gheorghescu, April 2016

// thickness of the bracket base should 
bracket_thickness = 5;

// screw diameter plus clearance
screw_dia = 3.3;

// screw head diameter plus clearance
screw_head_dia = 5.7;

// extrusion size in mm
extrusion_size = 15;

// extrusion outside width
extrusion_channel_width = 5.55;

// extrusion nut channel width
extrusion_channel_deep = 4.4;

// extrusion groove width 
extrusion_groove_width = 3.6;

// extrusion thickness
extrusion_groove_deep = 1.15;

// add "fingers" that go inside the extrusion?
fingers = 1; // [1: Yes, 0: No]

// generate left and right clips?
dual = 1; // [1: Yes, 0: No]

/* [Hidden] */


epsilon = 0.01;
$fn=32;

module round_rect(x, y, r, fn=20)
{
    $fn=fn;
    radius = r;
    hull() {
        translate([-x/2 + radius, y/2 - radius, 0])
            circle(r=radius, center=true);
        translate([x/2 - radius, y/2 - radius, 0])
            circle(r=radius, center=true);
        translate([-x/2 + radius, -y/2 + radius, 0])
            circle(r=radius, center=true);
        translate([x/2 - radius, -y/2 + radius, 0])
            circle(r=radius, center=true);
    }
}

module extrusion_profile(channels=1, all_sides=1, offset=0.001)
{   
    minkowski ()
    {
        difference() {
            square([extrusion_size, extrusion_size], center=true);        

            // grooves
            translate([0, extrusion_size/2 - extrusion_groove_deep/2])
                square([extrusion_groove_width, extrusion_groove_deep], center=true);

            if (all_sides) {
                translate([0, -extrusion_size/2 + extrusion_groove_deep/2])
                    square([extrusion_groove_width, extrusion_groove_deep], center=true);

                rotate([0,0, 90])
                translate([0, extrusion_size/2 - extrusion_groove_deep/2])
                    square([extrusion_groove_width, extrusion_groove_deep], center=true);

                rotate([0,0, 90])
                translate([0, -extrusion_size/2 + extrusion_groove_deep/2])
                    square([extrusion_groove_width, extrusion_groove_deep], center=true);

            }
            
            if (channels)
            {
                // nut channels
                translate([0, extrusion_size/2 - extrusion_channel_deep/2 - extrusion_groove_deep/2])
                    square([extrusion_channel_width, extrusion_channel_deep - extrusion_groove_deep], center=true);
                
                if (all_sides) {
                    translate([0, -extrusion_size/2 + extrusion_channel_deep/2 + extrusion_groove_deep/2])
                        square([extrusion_channel_width, extrusion_channel_deep - extrusion_groove_deep], center=true);

                    rotate([0,0, 90])
                    translate([0, extrusion_size/2 - extrusion_channel_deep/2 - extrusion_groove_deep/2])
                        square([extrusion_channel_width, extrusion_channel_deep - extrusion_groove_deep], center=true);
                    
                    rotate([0,0, 90])
                    translate([0, -extrusion_size/2 + extrusion_channel_deep/2 + extrusion_groove_deep/2])
                        square([extrusion_channel_width, extrusion_channel_deep - extrusion_groove_deep], center=true);
            
                }
            }
        }        
    
        circle(r=offset, center=true);
    }
}


module screw(len)
{
    translate([0, 0, len/2 - epsilon])
    cylinder(r=screw_head_dia/2, h=len, center=true);
    
    translate([0, 0, -len/2])
        #cylinder(r=screw_dia/2, h=len, center=true);
}

module side_clip()
{
    difference() {
        hull () {
            linear_extrude(bracket_thickness) {
                round_rect(extrusion_size, extrusion_size + 2*screw_head_dia, 1);
            }
            
            translate([0, 0, extrusion_size/2 + bracket_thickness])
            rotate([0,90,0])
            #linear_extrude(extrusion_size/2) {
                round_rect(extrusion_size, extrusion_size, 1);
            }
            
        }
        
        translate([0,-extrusion_size/2 - screw_head_dia/2,bracket_thickness])
            screw(100);

        translate([0, extrusion_size/2 + screw_head_dia/2, bracket_thickness])
            screw(100);

        translate([extrusion_size - (extrusion_size-extrusion_groove_width)/2 ,  0, 0])
            linear_extrude(10*extrusion_size) 
            rotate([0, 0, 90]) extrusion_profile(0);
        
        translate([-bracket_thickness + extrusion_groove_width/2,0, extrusion_size/2])
        rotate([0,-90,0])
        screw(100);
    }
}

module rack_clip(fingers=0)
{
    // fingers
    if (fingers)
    difference() {
        translate([0,0,-extrusion_size/8])
        union()
        {
            linear_extrude(extrusion_size/4, center=true) {
                difference() {            
                    square([extrusion_size, extrusion_size], center=true);
                    
                    rotate([0,0,180])
                    extrusion_profile(1,1, 0.3);
                    
                    translate([extrusion_size/2 + extrusion_channel_width/2,0,0])
                        square([extrusion_size, extrusion_size], center=true);
                    
                }
                //%extrusion_profile(0,1);
            }
        }
                
    }


    difference() {
        hull() {
            // shelf support cap
            translate([0,0,-extrusion_size/4-bracket_thickness/2])
            linear_extrude(bracket_thickness, center=true)
                round_rect(extrusion_size, extrusion_size, 0.5);

            // side clip    
            translate([0, 2*bracket_thickness +  0*extrusion_size/2, - extrusion_size/4])
            rotate([0,90,0])
            linear_extrude(bracket_thickness, center=true)
                round_rect(2*extrusion_size, extrusion_size, 0.5);

            // shelf clip
            #translate([0, extrusion_size/2 + bracket_thickness, extrusion_size/4])
            rotate([90,0,0])
            linear_extrude(2*bracket_thickness, center=true)
                round_rect(extrusion_size, extrusion_size, 0.5);

        }
        
                
        // leg screw
        translate([-bracket_thickness + extrusion_groove_width/2, extrusion_size - bracket_thickness, -extrusion_size*3/4])
        rotate([0,-90,0])
            screw(100);


        // shelf screw
        translate([0, extrusion_size/2 + bracket_thickness, screw_head_dia])
        rotate([-90,0,0])
        screw(100);

        // rack extrusion
        translate([0,0, extrusion_size/4])
            linear_extrude(extrusion_size, center=true) 
                extrusion_profile(0,0, 0.3);

        // vertical leg extrusion
        translate([extrusion_size/2 + extrusion_groove_width/2,0, -extrusion_size*3/4])
        rotate([90,0,0])
        linear_extrude(5*extrusion_size, center=true) 
            extrusion_profile(0,1, 0.3);
    }

    
    // rack extrusion
    %translate([0,0, extrusion_size/4])
    linear_extrude(extrusion_size, center=true) 
        extrusion_profile(1,1);


    // vertical leg extrusion
    %translate([extrusion_size/2 + extrusion_groove_width/2,0, -extrusion_size*3/4])
    rotate([90,0,0])
    linear_extrude(5*extrusion_size, center=true) 
        extrusion_profile(1,1);
    
    
}


rotate([-90,0,0])
    rack_clip(fingers);

if (dual)
{
    translate([extrusion_size + 2, 0,0])
    mirror()
    rotate([-90,0,0])
    rack_clip(fingers);
}