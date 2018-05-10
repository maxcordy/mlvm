// http://www.thingiverse.com/thing:1973679

part = "vertical"; // [vertical:Vertical with top bar,horizontal:Horizontal with top bar,vertical_short:Vertical with clip hole]

card_thickness = 2; // [0:0.1:10]
// ISO/IEC 7810 ID-1 card width
card_width = 53.98;
// ISO/IEC 7810 ID-1 card height
card_height = 85.6;

horizontal_tolerance = 0.5; // [0:0.1:5]
vertical_tolerance = 0.05; // [0:0.01:2]

/* [Logo] */

logo_type = "hacker_emblem"; // [hacker_emblem,text,none]
logo_protrudes = "yes"; // [yes,no]
logo_hacker_emblem_size = 35; // [0:100]
logo_text_line = "BLAH!";
logo_text_font = "Anton";
logo_text_size = 12; // [0:100]
logo_text_rotate = "no"; // [no,right,left,down]

/* [Extended Parameters] */

bottom_thickness = 1; // [0:0.1:20]
top_thickness = 1; // [0:0.1:20]
side_thickness = 2; // [0:0.1:20]

top_bar_height = 8; // [0:40]

leaf_size = 3; // [0:40]
leaf_length = 12; // [0:40]
leaf_offset = 1.5; // [0:0.1:20]
chamfer = .7; // [0:0.1:5]

top_bar_clip_hole_width = 11; // [0:100]
top_bar_clip_hole_height = 4; // [0:40]
top_bar_vertical_belt_hole_distance = 40; // [0:100]
top_bar_horizontal_belt_hole_distance = 60; // [0:100]

card_clip_hole_width = 13; // [0:100]
card_clip_hole_height = 3; // [0:40]

/* [Hidden] */

enable_top_bar = (part == "vertical_short") ? false : true;
orientation = (part == "horizontal") ? "horizontal" : "vertical";
hollow_size = (orientation == "horizontal") ?
    [card_height+horizontal_tolerance*2,
        card_width+horizontal_tolerance*2,
        card_thickness+vertical_tolerance*2] :
    [card_width+horizontal_tolerance*2,
        card_height+horizontal_tolerance*2,
        card_thickness+vertical_tolerance*2];
top_bar_belt_hole_distance = (orientation == "horizontal") ?
    top_bar_horizontal_belt_hole_distance :
    top_bar_vertical_belt_hole_distance;

two_side = false;   // Not ready yet

dot = 0.01;
$fn=64;

module leafs() {
    lsize = (orientation == "vertical") ?
        hollow_size : [hollow_size.y,hollow_size.x];
    lrotation = (orientation == "vertical") ? 0 : 90;
    lpos = (orientation == "vertical") ? [0,0] : [hollow_size.x,0];
    
    translate(lpos) {
        rotate([0,0,lrotation]) {
            translate([0,lsize.y-dot])
                square([leaf_length,dot]);
            translate([0,lsize.y-leaf_length])
                square([dot,leaf_length]);
        
            translate([0,lsize.y/3-leaf_size])
                square([dot,leaf_length]);
        
            translate([lsize.x-leaf_length,lsize.y-dot])
                square([leaf_length,dot]);
            translate([lsize.x-dot,lsize.y-leaf_length])
                square([dot,leaf_length]);
        
            translate([lsize.x-dot,lsize.y/3-leaf_size])
                square([dot,leaf_length]);
        }
    }
}

module grid(step=10, angle=30, size=[40,40], offset=0, width=1)
{
    intersection() {
        square(size);
        for (yy = [offset:step:size.y*2]) {
            ll = size.x/cos(angle) + width*tan(angle);
            echo(ll);
            translate([0,yy])
                rotate([0,0,-angle])
                    translate([-width/2*tan(angle),-width/2])
                        square([ll,width]);
            translate([size.x,yy])
                rotate([0,0,180+angle])
                    translate([-width/2*tan(angle),-width/2])
                        square([ll,width]);
        }
    }
}

module top_hole() {
    offset(r=leaf_size)
    {
        difference() {
            offset(r=-leaf_size)
                square([hollow_size.x,hollow_size.y]);

            if (two_side) {
                translate([0,hollow_size.y/3])
                    offset(r=leaf_size*2) {
                        square([hollow_size.x,dot]);
                        grid(step=20, size=[hollow_size.x,hollow_size.y*2/3], width=dot);
                    }
            } else {
                offset(r=leaf_size*2)
                    leafs();
            }
        }
    }
}

module bottom_hole() {
    if (two_side) {
        step = 20;
        translate([0,hollow_size.y/3]) {
            difference()
            {
                offset(r=-leaf_offset)
                    square([hollow_size.x,hollow_size.y*2/3+step/2]);
                offset(r=-leaf_size) {
                    offset(r=leaf_size*2+leaf_offset) {
                        //translate([0,-step/2])
                        grid(step=step, angle=30, size=[hollow_size.x,hollow_size.y*2/3+step/2], width=dot, offset=step/2);
                    }
                }
            }
        }
    } else {
        intersection() {
            offset(r=-leaf_offset)
                square([hollow_size.x,hollow_size.y]);
            offset(r=-leaf_size)
                offset(r=leaf_size*2+leaf_offset)
                    leafs();
        }
    }
}

module base_holes() {
    if (enable_top_bar) {
        translate([hollow_size.x/2-top_bar_belt_hole_distance/2,-top_bar_height/2])
            circle(r=top_bar_clip_hole_height/2);
        translate([hollow_size.x/2+top_bar_belt_hole_distance/2,-top_bar_height/2])
            circle(r=top_bar_clip_hole_height/2);
        translate([hollow_size.x/2-top_bar_clip_hole_width/2,-top_bar_height/2]) {
            hull() {
                circle(r=top_bar_clip_hole_height/2);
                translate([top_bar_clip_hole_width,0,0])
                    circle(r=top_bar_clip_hole_height/2);
            }
        }
    } else {
        translate([hollow_size.x/2-card_clip_hole_width/2,6]) {
            hull() {
                circle(r=card_clip_hole_height/2);
                translate([card_clip_hole_width,0,0])
                    circle(r=card_clip_hole_height/2);
            }
        }
    }
}

module base() {
    offset(r=side_thickness) {
        if (enable_top_bar) {
            translate([0,-top_bar_height+side_thickness])
                square([hollow_size.x,hollow_size.y+top_bar_height-side_thickness]);
        } else {
            square([hollow_size.x,hollow_size.y]);
        }
    }
}

// http://www.catb.org/hacker-emblem/
module hacker_emblem(size=30, grid=true, fused=false, step=100, dia = 80, wall = 5, fuse = 20) {
    hacker_emblem = [[0,0],[1,0],[2,0],[2,1],[1,2]];

    resize([size,size]) {
        translate([-step*3/2,-step*3/2]) {
            for (pos = hacker_emblem)
                translate([(pos[0]+.5)*step,(pos[1]+.5)*step])
                    circle(dia/2);
    
            if (grid) {
                difference() {
                    union() {
                        for (xx = [0:3])
                            translate([step*xx-wall/2,-wall/2])
                                square([wall,step*3+wall]);
                        for (yy = [0:3])
                            translate([-wall/2,step*yy-wall/2])
                                square([step*3+wall,wall]);
                    }
    
                    if (fused) {
                        for (xx = [0:2])
                            translate([step*(xx+.5)-fuse/2,-fuse/2-1])
                                square([fuse,step*3+fuse+2]);
                        for (yy = [0:2])
                            translate([-fuse/2-1,step*(yy+.5)-fuse/2])
                                square([step*3+fuse+2,fuse]);
                    }
                }
            }
        }
    }
}

module card_holder() {
    difference() {
        // Chamfered base
        hull() {
            translate([0,0,chamfer*3/2])
                linear_extrude(height=hollow_size.z+bottom_thickness+top_thickness-chamfer*3)
                    base();
            linear_extrude(height=hollow_size.z+bottom_thickness+top_thickness)
                offset(r=-chamfer)
                    base();
        }

        translate([0,0,-.001])
            linear_extrude(height=hollow_size.z+bottom_thickness+top_thickness+.002)
                base_holes();

        translate([0,0,-.001])
            linear_extrude(height=bottom_thickness+.002)
                bottom_hole();
        translate([0,0,bottom_thickness])
            cube([hollow_size.x,hollow_size.y,hollow_size.z]);
        translate([0,0,hollow_size.z+bottom_thickness-.001])
            linear_extrude(height=top_thickness+.002)
                top_hole();

        if (!two_side) {
            logo_thickness = (logo_protrudes == "yes") ?
                bottom_thickness : bottom_thickness/2;
            translate([hollow_size.x/2,(hollow_size.y-(enable_top_bar ? top_bar_height : 0))/2,-.001]) {
                linear_extrude(height=logo_thickness+.002) {
                    mirror([0,1,0]) {
                        if (logo_type == "hacker_emblem") {
                            hacker_emblem(logo_hacker_emblem_size,grid=false,fused=true);
                        } else if (logo_type == "text") {
                            angle = (logo_text_rotate == "right") ? -90 :
                                (logo_text_rotate == "left") ? 90 :
                                (logo_text_rotate == "down") ? 180 : 0;
                            rotate([0,0,angle])
                                text(text=logo_text_line, size=logo_text_size, font=logo_text_font, halign="center", valign="center");
                        }
                    }
                }
            }
        }
    }
}

rotate([0,0,180])
    card_holder();
