width           = 85;
height          = 56;
corner_radius   = 3;
hole_dia        = 2.75;
x_hole_dist     = 58;
y_hole_dist     = 49;
hole_offset     = 3.5;
t               = 2;
min_width       = (hole_offset+hole_dia) * 2;

mount_width  = x_hole_dist + hole_offset*2;
mount_height = height;
post_height  = 20;
post_offset  = 2;
post_radius  = (hole_dia)/2.1;

foot_height  = post_height;
foot_width   = post_radius*8;

hole_1 = [hole_offset,hole_offset];
hole_2 = [mount_width-hole_offset,hole_offset];
hole_3 = [mount_width-hole_offset,mount_height-hole_offset];
hole_4 = [hole_offset,mount_height-hole_offset];

whr = 5;
wt  = 2;
gap = (whr-wt)/1.2;

float_height = 0;

// import pi
// color("limegreen") translate([-21.5,-27.5,t+post_offset-2.4]) import("B+_Model_v3.stl", convexity=3);

holes = [hole_1,hole_2,hole_3,hole_4];

*union(){
    // Posts
    for(i = [0:1:len(holes)-1]){
        union(){
            translate(concat(holes[i],t)) cylinder(post_height, post_radius, post_radius*0.9, $fn=20);
            translate(concat(holes[i],post_height+t)) cylinder(t*1.5, post_radius/1.5, post_radius/1.5, $fn=20);
            translate(concat(holes[i],t)) cylinder(post_offset, post_radius*2, post_radius*1.5, $fn=20);
        }
    }

    // Base
    angle = 180;
    linear_extrude(t){
        union(){
            for(i = [0:1:len(holes)-1]){
                translate(concat(holes[i],0)) 
                    rotate([0,0,90 * -1 * sign(i-1.5)])
                    rotate([0,0,90])
                    hull(){
                        circle(foot_width/2, $fn=40);
                        translate([0,foot_width/4,0])
                            square([foot_width, foot_width/2], true);
                    }
            }
            translate(concat(hole_1,0)+[x_hole_dist/2, y_hole_dist/2,0])
                rotate([0,0,atan(y_hole_dist/x_hole_dist)]) 
                    square([norm(hole_3 - hole_1), post_radius*4], true);
            translate(concat(hole_1,0)+[x_hole_dist/2, y_hole_dist/2,0])
                rotate([0,0,-atan(y_hole_dist/x_hole_dist)]) 
                    square([norm(hole_3 - hole_1), post_radius*4], true);
            translate(concat(hole_1,0)+[x_hole_dist/2, y_hole_dist/2,0])
                square([30,20],true);
        }
    }
    for(i = [0:1:len(holes)-1]){
        render() translate([0,sign(i-1.5) * 1,0]) difference(){
            translate([0,sign(i-1.5)*((foot_width/2)-t/2),0])
            translate(concat(holes[i],foot_height/2))
                cube([foot_width,t,foot_height], true);
            for(j = [-1:2:1]){
                translate([j*foot_width/2,0,0])
                translate([0,sign(i-1.5)*((foot_width/2)-t/2),0])
                translate(concat(holes[i],0))
                translate([0,(t+0.2)/2,7])
                rotate([90,0,0]){
                    cylinder(t+0.2,foot_width/3, foot_width/3, $fn=20);
                    translate([-foot_width/3,0,0])
                        cube([foot_width/1.5,foot_height-6,t+0.2]);
                }
            }
        }
    }
}

translate([100,0,-(post_height+t)])
union(){
    // Cover
    translate([0,0,post_height+t+float_height])
    linear_extrude(t)
    difference(){
        union(){
            difference(){
                translate(concat(hole_1,0)+[x_hole_dist/2,y_hole_dist/2,0]) 
                minkowski(){
                    square([x_hole_dist, y_hole_dist], true);
                    circle(corner_radius, $fn=40);
                }
                translate([(t*1.75)+(x_hole_dist/2),(t*1.75)+(y_hole_dist/2),0]) minkowski(){
                    square([x_hole_dist-t*2, y_hole_dist-t*2], true);
                    circle(corner_radius/2, $fn=40);
                }
            }
            for(i = [0:1:len(holes)-1]){
                translate(concat(holes[i],t)) circle(corner_radius, $fn=20);
            }
        }
        for(i = [0:1:len(holes)-1]){
            translate(concat(holes[i],t)) circle(post_radius/1.2, $fn=20);
        }
    }

    // RF Mount
    tx_width  = 20;
    tx_depth  = 20;
    tx_height = 4;
    translate([hole_offset+x_hole_dist/2-tx_width/2-t,hole_offset,t+post_height]){
        cube([tx_width+t*2, y_hole_dist, t]);
        cube([t,tx_depth+1,tx_height+t]);
        translate([tx_width+t,0,0])
            cube([t,tx_depth+1,t*3]);
        translate([t,0,t+tx_height])
        rotate([-90,0,0])
        linear_extrude(tx_depth+1) 
        scale(0.5) 
            polygon([[0,0],[3,0],[0,4]]);
        translate([tx_width+(2.5-t),0,t+tx_height])
        rotate([-90,0,0])
        linear_extrude(tx_depth+1) 
        scale(0.5) 
            polygon([[0,0],[3,0],[3,4]]);
    }
    
//    union(){
//        translate([(x_hole_dist/2)-tx_width/2,tx_depth+t+2+hole_offset,post_height+t])
//        rotate([90,0,0])
//        render()
//        union(){
//            translate([0,tx_height+t/2,tx_depth+5-t]) cube([tx_width+5, t/2, t]);
//            difference(){
//                cube([tx_width+t+3, tx_height+t*2, tx_depth+t+3]);
//                translate([0,t,t]) cube([tx_width+6, tx_height, tx_depth+6]);
//            }
//        }
//        translate([(x_hole_dist/2)-tx_width/2, hole_offset+(tx_depth+t*2), post_height+t]) cube([tx_width+t+3, y_hole_dist-(tx_width+3+t)+1, t]);
//    }

    // Cable Clips
    for(j = [0:1:1]){
        translate([x_hole_dist*j + hole_offset - t*(1-j),hole_offset+(y_hole_dist/2),(post_height+t*2+float_height)+whr]) 
        rotate([0,90,0]) {
            linear_extrude(t)
            difference(){
                union(){
                    circle(whr, true);
                    translate([0,-whr,0]) square([whr,whr*2]);
                }
                translate([-whr,-(gap)/2,0]) square([gap*2,(gap)]);
                translate() circle(whr-wt, $fn=40);
            }
        }
    }
    translate([hole_offset-t,y_hole_dist/2+whr*,post_height+t*2])
    rotate([0,-90,90])
    linear_extrude(whr*2)
        polygon([[0,0],[0,t/2],[t,0]]);
}