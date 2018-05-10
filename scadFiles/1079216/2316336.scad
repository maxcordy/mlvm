/* [Hidden] */
inch=25.4;
slop=0.2;
m5_head_rad=5+slop;
m5_thread_rad=2.5+slop;
m5_thread_thickness=.8;
m5_locknut_height=5;
m5_locknut_rad=(8/cos(180/6))/2;
m3_thread_rad=2;
m3_locknut_height=4;
m3_locknut_width=5.5/cos(180/6);
m3_head_height=1.65+slop;
m3_head_width=5.5+slop;
$fn=360;
cupholder_height=114;
cupholder_top_ring_height=10;
cupholder_bottom_thickness=5;
cupholder_inner_diam=87;
cupholder_outer_diam=95;
cupholder_slot_width=8;
cupholder_slot_height=99;
cupholder_slot_cutout_width=112;
swivel_inner_diam=101;
swivel_outer_diam=115;
swivel_height=10;

/* [Mount] */
// Radius of the handlebar in inches
radius = 0.5;
bar_rad=radius*inch;
// Width of the clamp in inches
clamp_width=0.75;
mount_width=clamp_width*inch;
// Thickness of the clamp in inches
clamp_thickness=0.75;
mount_thickness=clamp_thickness*inch;
// How much of the center is cut off to ensure tight fit around bars in millimeters
halves_separation=3;

translate([cupholder_outer_diam/2+mount_thickness+bar_rad+5,0,mount_width/2])
handlebar_mount();

cup_holder(cupholder_inner_diam/2, cupholder_outer_diam/2, cupholder_height);
//translate([0,0,104]) 
rotate([0,0,-96.5])
swivel_mount(swivel_inner_diam/2, swivel_outer_diam/2, swivel_height);

module swivel_mount(inner_r, outer_r, height){
    translate([0,0,swivel_height/2])
    difference() {
            // Make C shape
        union() {
            for(i = [-outer_r,inner_r]) {
                translate([i,0,-height/2]) cube([outer_r-inner_r, 5,height]);
            }
            difference() {
                cylinder(h=height, r=outer_r, center=true);
                cylinder(h=height+slop, r=inner_r, center=true);
                translate([-outer_r-slop,0,-height]) cube([(outer_r+slop)*2, outer_r+slop,height*2]);
                
            }
        }
        // Make M3 holes and locknut traps
        rotate([0,90,0]) cylinder(h=2*outer_r+slop,r=m3_thread_rad,center=true);
        for (i = [-1,1]) {
            translate([i*(outer_r-.5), 0, 0]) rotate([0,i*270,0]) cylinder(h=m3_locknut_height*2, r1=m3_locknut_width/2+slop*2, r2=m3_locknut_width/2-slop, $fn=6,center=true);
        }
        rotate([90,0,0]) cylinder(h=2*(inner_r+m3_head_height), r=m3_head_width/2, center=true);
        rotate([90,0,0]) cylinder(h=outer_r*2, r=m3_thread_rad, center=true);
    }
}
module cup_holder(inner_r, outer_r, height){
    difference() {
        // cupholder
        cylinder(h=height, r=outer_r);      translate([0,0,5]) cylinder(h=height, r=inner_r);
        // side wall cutouts
        translate([0,0,5])
        for (i = [0:15]){
            rotate([0,0,i*22.5])
            cube([cupholder_slot_cutout_width, cupholder_slot_width,cupholder_slot_height]);
        }
        // M3 hole cutouts
        translate([0,0,109]) rotate([90,0,-6.5]) cylinder(h=cupholder_slot_cutout_width, r=m3_thread_rad,center=true);
        
        // M3 head depression
        translate([0,0,109]) rotate([90,0,-6.5]) cylinder(2*(inner_r+m3_head_height), r=m3_head_width/2,center=true);
    }
}


module handlebar_mount() {
    difference() {
        base_object();
        
        // handlebar cutout
        cylinder(h=mount_width+slop, r=bar_rad+slop, center=true);
        cube([halves_separation,2*(bar_rad+mount_thickness+slop)+slop,mount_width+slop],center=true);
        
        // M5 Hole cutouts
        for(i = [-1,1]){
            translate([0,i*(bar_rad+5+m5_thread_rad+slop), 0]) rotate([0,90,0]) cylinder(h=mount_width*3+slop,r=m5_thread_rad,center=true);
        }
        
        // Socket Head Cutouts
        for(i = [-1,1]){
            translate([6.5, i*(bar_rad+2.5+slop+m5_head_rad),0]) rotate([0,90,0]) cylinder(h=mount_width*2+slop,r=m5_head_rad+slop);
        }
        
        // M5 Locknut Cutouts
        for(i = [-1,1]){
            translate([-6.5,i*(bar_rad+3+slop+m5_locknut_rad), 0]) rotate([0,270,0]) cylinder(h=mount_width*2,r1=m5_locknut_rad-slop,r2=m5_locknut_rad+slop*2,$fn=6);
        }
        
        // M3 Hole cutout
        translate([bar_rad+mount_thickness+slop-5, bar_rad+mount_thickness+slop, 0]) rotate([90,00,0]) cylinder(h=20, r=m3_thread_rad+slop, center=true);
        
        // M3 Locknut Cutout
        translate([bar_rad+mount_thickness+slop-5, bar_rad+mount_thickness+slop-m3_locknut_height-1, 0]) rotate([90,0,0]) cylinder(h=m3_locknut_height+2, r1=m3_locknut_width/2-slop,r2=m3_locknut_width/2+slop*2, $fn=6, center=true);
        
        // Trim back side of mount
        rotate([0,0,270])
        translate([mount_width+bar_rad, 0, -slop/2])
        cube([mount_width/2,mount_width*3+slop,mount_thickness+slop*2], center=true);
        
        // Just to make sure locknut doesn't impede M5 bolt
    %translate([bar_rad+mount_thickness+slop-5, bar_rad+mount_thickness+slop-m3_locknut_height, 0]) rotate([90,0,0]) cylinder(h=m3_locknut_height+slop, r=m3_locknut_width/2+slop, $fn=6, center=true);
    }
}

module base_object(){
    union(){
        cylinder(h=mount_width, r=bar_rad+mount_thickness+slop, center=true);
        translate([0,0,-(mount_width)/2])
        cube([bar_rad+mount_thickness+slop, bar_rad+mount_thickness+slop,mount_width]);
    }
}
